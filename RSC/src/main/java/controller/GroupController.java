package controller;

import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.GroupAdmin;
import domain.GroupJoin;
import domain.GroupMember;
import domain.Groups;
import domain.Member;
import service.GroupsService;

@RequestMapping("group")
@Controller
public class GroupController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	
	
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
}













