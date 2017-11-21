package controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Admin;
import domain.Board;
import domain.Groups;
import domain.Member;
import domain.Notice;
import service.BoardService;
import service.GroupsService;
import service.MemberService;
import service.NoticeService;
import service.SingoService;

/**
 *  관리자 페이지 기능
 *  	1. 회원 관리
 *  	2. 그룹 관리
 *  	3. 게시글 관리
 * 		4. 신고 게시글/댓글/그룹 관리
 * 		5. 공지사항
 * 		6. 관리자 계정 생성(master)
 * */
@Controller
@RequestMapping("admin")
public class AdminController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	private SingoService singoService = context.getBean("singoService",SingoService.class);
	private NoticeService noticeService = context.getBean("noticeService", NoticeService.class);
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	
	/** 그룹관리 페이지 */
	@RequestMapping("group.do")
	public String goAdminGroup(Model model) {
		List<Groups> allList = groupsService.searchAllGroups();
		model.addAttribute("allList",allList);
		return "adminGroup";
	}
	
	@RequestMapping("groupDelete.do")
	public String deleteGroup(@RequestParam("groupNum") String groupNum) {
		int gNum = Integer.parseInt(groupNum.trim());
		boolean result = groupsService.deleteGroupByNum(gNum);
		return "redirect:group.do";
	}
	
	/** 모든 그룹 검색 */
	@RequestMapping("searchGroup.do")
	public @ResponseBody List<Groups> searchGroupByName(@RequestParam("groupName") String groupName) {
		List<Groups> list = groupsService.searchGroupByName(groupName.toString());
		return list;
	}
	
	/** 회원관리 페이지 */
	@RequestMapping("member.do")
	public String goAdminMember(Model model) {
		List<Member> allList = memberService.searchAllMembers();
		model.addAttribute("allList", allList);
		return "adminMember";
	}
	
	@RequestMapping("searchMember.do")
	public @ResponseBody List<Member> searchMemberByIdName(@RequestParam("memberIdName") String memberIdName){
		List<Member> list = memberService.searchByIdName(memberIdName);
		return list;
	}
	
	@RequestMapping("memberDelete.do")
	public String deleteMember(@RequestParam("memberId") String memberId) {
		boolean result = memberService.deleteMemberByID(memberId.trim());
		return "redirect:member.do";
	}
	
	/** 신고 페이지 */
	@RequestMapping("singo.do")
	public String goAdminSingo() {
		return "adminSingo";
	}
	
	@RequestMapping("singoList.do")
	public @ResponseBody List getSingoList(@RequestParam("type") String type) {
		List list;
		switch(type.trim()) {
		case "board":
			list = singoService.searchAllBoardSingo();
			break;
		case "reply":
			list = singoService.searchAllReplySingo();
			break;
		default :
			list = singoService.searchAllGroupSingo();
			break;
		}
		return list;
	}
	
	@RequestMapping("restoreSingo.do")
	public @ResponseBody List restoreSingo(@RequestParam("type") String type,
			  				   @RequestParam("singoNum") String singoNum,
			  				   @RequestParam("num") String num) {
		boolean result;
		List list;
		switch(type) {
		case "board":
			result = singoService.restoreBoardSingo(singoNum, num);
			list = singoService.searchAllBoardSingo(); 
			break;
		case "reply":
			result = singoService.restoreReplySingo(singoNum, num);
			list = singoService.searchAllReplySingo();
			break;
		default:
			result = singoService.restoreGroupSingo(singoNum, num);
			list = singoService.searchAllGroupSingo();
			break;
		}
		return list;
	}
	
	@RequestMapping("deleteSingo.do")
	public @ResponseBody List deleteSingo(@RequestParam("type") String type,
							  @RequestParam("singoNum") String singoNum,
							  @RequestParam("num") String num) {
		boolean result;
		List list;
		switch (type) {
		case "board":
			result = singoService.deleteBoardBySingo(num);
			list = singoService.searchAllBoardSingo();
			break;
		case "reply":
			result = singoService.deleteReplyBySingo(num);
			list = singoService.searchAllReplySingo();
			break;
		default:
			result = singoService.deleteGroupBySingo(num);
			list = singoService.searchAllGroupSingo();
			break;
		}
		return list;
	}
	
	/** 공지사항 */
	@RequestMapping("sendNotice.do")
	public @ResponseBody boolean addNoticetoAll(Notice notice,@RequestParam("memberId") String memberId) {
		boolean result = true;
		
		List<Member> list = new LinkedList<Member>();
		
		if (memberId.equals("allMember")){
			list = memberService.searchAllMembers();
		} else {
			String[] memberArr = memberId.split(",");
			for(int i=0 ; i < memberArr.length ; i++ ) {
				list.add(new Member());
				list.get(i).setMemberId(memberArr[i]);
			}
		}
		result = noticeService.addFromAdmin(notice, list);
		return result;
	}
	
	/** 게시글 관리 
	 * @throws ParseException */
	@RequestMapping("board.do")
	public String goAdminBoard(Model model) throws ParseException {
		
		Map<String, Object> map = new HashMap<>();
		map.put("orderColumn", "board_time");
		map.put("orderType", "desc");
		map.put("boardIdContent", "");
		
		List<Board> list = boardService.searchAllOrder(map);

		model.addAttribute("list", list);
		return "adminBoard";
	}
	
	/** 게시글 정렬  */
	@RequestMapping("boardOrder.do")
	public @ResponseBody List<Board> searchBoardOrdered(
			@RequestParam("orderColumn") String orderColumn,
			@RequestParam("orderType") String orderType,
			@RequestParam("boardIdContent") String boardIdContent){
		Map<String, Object> map = new HashMap<>();
		map.put("orderColumn", orderColumn);
		map.put("orderType", orderType);
		map.put("boardIdContent", boardIdContent);
		
		List<Board> list = boardService.searchAllOrder(map);
		
		return list;
	}
	
	/** 관리자 추가페이지 이동 */
	@RequestMapping("add.do")
	public String goAdminAdd() {
		return "adminAdd";
	}
	
	@RequestMapping("addAdmin.do")
	public String addAdmin(Admin admin, Model model) {
		boolean result = memberService.addAdmin(admin);
		if(result) {
			model.addAttribute("msg", admin.getAdminId()+" 관리자 계정 생성을 성공하였습니다."); 
		} else {
			model.addAttribute("msg", "관리자 계정 생성을 실패하였습니다."); 
		}
		model.addAttribute("url", "add.do"); 
		return "controllerAlert"; 
	}
	
} // end of AdminController
