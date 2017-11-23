package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import domain.Board;
import domain.GroupAdmin;
import domain.GroupDelete;
import domain.GroupJoin;
import domain.GroupMember;
import domain.Groups;
import domain.Member;
import domain.Notice;
import service.BoardService;
import service.GroupsService;
import service.NoticeService;

@RequestMapping("group")
@Controller
public class GroupController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	private BoardService boardService = context.getBean("boardService",BoardService.class);
	private NoticeService noticeService = context.getBean("noticeService",NoticeService.class);
	
	/** 그룹의 관리자, 회원 리스트 search*/
	@RequestMapping("groupMember.do")
	public String searchGroupMember(@RequestParam("groupNum") String groupNum, Model model){
		
		Map<String, List<Member>> map = new HashMap<>();
		map.put("groupAdmin", groupsService.searchGroupAdminByGroupNum(groupNum));
		map.put("groupMember", groupsService.searchGroupMemberByGroupNum(groupNum));
		
		model.addAttribute("groupInfo", groupsService.searchGroupByNum(groupNum));
		model.addAttribute("groupMember", map);
		return "groupMember";
	}
	
	/** 관리자 임명(group_admin 추가, group_member 삭제) */
	@RequestMapping("appointAdmin.do")
	public String addGroupAdmin(GroupAdmin groupAdmin, GroupMember groupMember) {
		boolean result = groupsService.addGroupAdmin(groupAdmin, groupMember);
		return "redirect:groupMember.do?groupNum="+groupAdmin.getGroupNum();
	}
	
	/** 그룹 회원 추방(group_member 삭제) */
	@RequestMapping("expelMember.do")
	public String deleteGroupMember(GroupMember groupMember) {
		boolean result = groupsService.deleteGroupMember(groupMember);
		return "redirect:groupMember.do?groupNum="+groupMember.getGroupNum();
	}
	
	/** 그룹 회원 검색(group_join 검색) */
	@RequestMapping("groupJoin.do")
	public String searchGroupJoin(@RequestParam("groupNum") String groupNum, Model model) {
		Groups group = groupsService.searchGroupByNum(groupNum);
		List<Member> list = groupsService.searchGroupJoinByGroupNum(groupNum);
		
		model.addAttribute("groupInfo",group);
		model.addAttribute("list",list);
		
		return "groupJoin";
	}
	
	/** 그룹 가입 승인 */
	@RequestMapping("approveJoin.do")
	public String addGroupMember(GroupMember groupMember, GroupJoin groupJoin) {
		boolean result = groupsService.addGroupMember(groupMember, groupJoin);
		return "redirect:groupJoin.do?groupNum="+groupMember.getGroupNum();
	}
	
	/** 그룹 가입 거절 */
	@RequestMapping("rejectJoin.do")
	public String deleteGroupJoin(GroupJoin groupJoin) {
		boolean result = groupsService.deleteGroupJoin(groupJoin);
		return "redirect:groupJoin.do?groupNum="+groupJoin.getGroupNum();
	}
	
	/** 그룹 삭제 요청 notice 전송, group 삭제 투표 추가 */
	@RequestMapping("deleteGroupNotice.do")
	public @ResponseBody boolean addNoticeDeleteGroup(@RequestParam("groupNum") String groupNum,
													  @RequestParam("groupName") String groupName) {
		boolean resultNotice = true;
		boolean resultgroupDelete = true;

		Notice notice = new Notice();
		notice.setNoticeContent("["+groupName+"] 그룹에 대한 삭제 투표가 진행 중 입니다.");
		notice.setNoticeType(1);
		notice.setNoticeTarget(Integer.parseInt(groupNum));
		
		List<Member> groupAdminList = groupsService.searchGroupAdminByGroupNum(groupNum);
		for (int i = 0; i < groupAdminList.size() ; i++) {
			notice.setMemberId(groupAdminList.get(i).getMemberId().trim());
			System.out.println(groupAdminList.get(i).getMemberId().trim());
			if(!noticeService.addNotice(notice)) {
				resultNotice = false;
			}
		}
		
		resultgroupDelete = groupsService.addGroupDelete(
				new GroupDelete(Integer.parseInt(groupNum.trim()),0,0,groupAdminList.size()));
		
		return (resultNotice && resultgroupDelete);
	}
	
	/** 그룹 가입 요청 */
	@RequestMapping("joinGroup.do")
	public @ResponseBody boolean addGroupJoin(GroupJoin groupJoin) {
		boolean result = groupsService.addGroupJoin(groupJoin);
		return true;
	}
	
	/** 그룹 삭제 실행 */
	@RequestMapping(value="voteGroupDelete.do", produces="application/json; charset=utf8")
	public @ResponseBody String updateGroupDelete(@RequestParam("groupNum") int groupNum,
												  @RequestParam("confirmFlag") boolean confirmFlag,
												  @RequestParam("noticeNum") int noticeNum) {
		
		boolean result = true;
		
		result = noticeService.deleteByNoticeNum(noticeNum);
		
		StringBuilder sb = new StringBuilder();
		
		if(confirmFlag) {
			result = groupsService.updateGroupDeleteAgree(groupNum);
			sb.append("찬성 하셨습니다.\n\n");
		} else {
			result = groupsService.updateGroupDeleteDisAgree(groupNum);
			sb.append("반대 하셨습니다.\n\n");
		}
		
		GroupDelete groupDelete = groupsService.searchGroupDeleteByGroupNum(groupNum);
		
		int delAll = groupDelete.getGroupDelAll();
		int delYes = groupDelete.getGroupDelYes();
		int delNo = groupDelete.getGroupDelNo();
		
		double agree = (double)delYes/(double)delAll;
		double disAgree = (double)delNo/(double)delAll;
		
		if( agree >= 0.5 ) {
			result = groupsService.deleteGroupDelete(groupNum); // group_delete 테이블에서 삭제
			result = noticeService.deleteGroupNoticeByNoticeTarget(groupNum); // notice 테이블에서 투표 삭제
			addNoticeToAllGroupMember(""+groupNum, true); // 삭제 메시지 전송
			sb.append("찬성 표가 과반을 넘어 그룹을 삭제합니다.\n\n");
			sb.append("투표 결과 : ( 찬성 "+delYes+"표 / 전체 "+delAll+"표 )");
			// 그룹 삭제도 해야함
		} else if ( disAgree >= 0.5 ) {
			result = groupsService.deleteGroupDelete(groupNum); // group_delete 테이블에서 삭제
			result = noticeService.deleteGroupNoticeByNoticeTarget(groupNum); // notice 테이블에서 투표 삭제
			addNoticeToAllGroupMember(""+groupNum, false); // 삭제 취소 메시지 전송
			sb.append("반대 표가 과반을 넘어 그룹 삭제 투표를 종료합니다.\n\n");
			sb.append("투표 결과 : ( 반대 "+delNo+"표 / 전체 "+delAll+"표 )");
		} else {
			sb.append("현재 투표 결과 : ( 찬성 "+delYes+"표 / 반대 "+delNo+"표 / 전체 "+delAll+"표 )");
		}
		return sb.toString();
	}
	
	/** 그룹 삭제 투표 결과 notice */
	public boolean addNoticeToAllGroupMember(String groupNum, boolean flag) {
		boolean result = true;
		Groups group = groupsService.searchGroupByNum(groupNum);
		
		Notice notice = new Notice();
		notice.setNoticeType(3);
		List<Member> listAdmin = groupsService.searchGroupAdminByGroupNum(groupNum);
		List<Member> listMember = groupsService.searchGroupMemberByGroupNum(groupNum);
		
		if(flag) {
			notice.setNoticeContent("["+group.getGroupName()+"] 그룹이 삭제 되었습니다.");
			result = noticeService.addFromAdmin(notice, listAdmin);
			result = noticeService.addFromAdmin(notice, listMember);
		} else {
			notice.setNoticeContent("["+group.getGroupName()+"] 그룹의 삭제 투표가 종료 되었습니다.");
			result = noticeService.addFromAdmin(notice, listAdmin);
		}
		return result;
	}
	
	/** 그룹에 게시글 추가 */
	@RequestMapping("groupBoard.do")
	public String addGroupBoard(Board board) {
		System.out.println(board);
		boolean result = true;
		result = boardService.addGroupBoard(board);
		return "redirect:../basic/group.do?groupNum="+board.getGroupNum();
	}
	
	/** 가입한 그룹 목록 불러오기 */
	@RequestMapping("groupList.do")
	public String getGroupList(HttpServletRequest request) {
		String id = (String)request.getSession().getAttribute("id");
		List<Groups> list = groupsService.searchGroupbyId(id);
		
		request.setAttribute("list", list);
		
		return "groupList";
	}
	
	/** 그룹 회원 탈퇴 */
	@RequestMapping("exitGroup.do")
	public String deleteGroupMemberSelf(int groupNum, String memberId) {
		GroupMember groupMember = new GroupMember(groupNum, memberId);
		boolean result = groupsService.deleteGroupMember(groupMember);
		System.out.println(groupMember);
		
		return "redirect:groupList.do";
	}
	
	/** 그룹 추가 */
	@RequestMapping(value = "addGroup.do", method = RequestMethod.POST)
	public String addGroup(MultipartHttpServletRequest request) {
		
		// 관심사 정렬
		String interests[] = request.getParameterValues("groupInterest");
		String interest = "";
		String id = (String)request.getSession().getAttribute("id");
		
		for (int i = 0; i < interests.length; i++) {
			if (i == interests.length - 1) 
				interest += interests[i];
			else 
				interest += interests[i] + ",";
		}

		// 입력받은 데이터를 토대로 새로운 그룹 객체 생성
		Groups g = new Groups(request.getParameter("groupName"), request.getParameter("groupInfo"),
				Integer.parseInt(request.getParameter("groupInfoOpen")), interest);
		
		System.out.println(groupsService.addGroup(g, request));
		System.out.println(groupsService.addGroupAdminFirst(g, id));

		// 그룹 추가
		if(groupsService.addGroup(g, request) && groupsService.addGroupAdminFirst(g, id)) {
			request.setAttribute("msg", "그룹 생성에 성공했습니다.");
		}
		else
			request.setAttribute("msg", "그룹 생성에 실패했습니다.");
		
		return "redirect:groupList.do";
	}
	
	/** 존재하는 그룹 이름이 있는지 확인 */
	@RequestMapping(value = "checkSameGroupName.do",produces = "application/json; charset=utf8")
	public @ResponseBody String checkSameGroupName(@RequestParam("groupName") String name) {
		if(groupsService.checkSameGroupName(name))
			return "그룹명이 존재합니다.";
		else
			return "";
	}//end of checkGroupName
	
}













