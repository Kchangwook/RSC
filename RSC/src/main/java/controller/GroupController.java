package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Board;
import domain.GroupAdmin;
import domain.GroupJoin;
import domain.GroupMember;
import domain.Groups;
import domain.Member;
import service.BoardService;
import service.GroupsService;

@RequestMapping("group")
@Controller
public class GroupController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	private BoardService boardService = context.getBean("boardService",BoardService.class);
	
	/** 그룹의 관리자, 회원 리스트 search*/
	@RequestMapping("groupMember.do")
	public String searchGroupMember(@RequestParam("groupNum") String groupNum, Model model){
		
		Map<String, List<Member>> map = groupsService.searchGroupAdminMemberByGroupNum(groupNum);
		Groups group = groupsService.searchGroupByNum(groupNum);
		
		model.addAttribute("group",group);
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
		
		model.addAttribute("group",group);
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
	@RequestMapping("addGroup.do")
	public String addGroup(String memberId) {
		
		
		return "redirect:groupList.do";
	}
}













