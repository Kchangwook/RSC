package controller;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Groups;
import domain.Member;
import service.GroupsService;
import service.MemberService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	
	@RequestMapping("group.do")
	public String goAdminGroup(Model model) {
		List<Groups> allList = groupsService.searchAllGroups();
		model.addAttribute("allList",allList);
		return "adminGroup";
	}
	
	@RequestMapping(value="groupDelete.do")
	public String deleteGroup(@RequestParam("groupNum") String groupNum) {
		System.out.println(123);
		int gNum = Integer.parseInt(groupNum.trim());
		boolean result = groupsService.deleteGroupByNum(gNum);
		System.out.println(result);
		return "redirect:group.do";
	}
	
	@RequestMapping("searchGroup.do")
	public @ResponseBody List<Groups> searchGroupByName(@RequestParam("groupName") String groupName) {
		List<Groups> list = groupsService.searchGroupByName(groupName.toString());
		return list;
	}
	
	@RequestMapping("member.do")
	public String goAdminMember(Model model) {
		List<Member> allList = memberService.searchAllMembers();
		model.addAttribute("allList", allList);
		return "adminMember";
	}
	
	@RequestMapping("searchMember.do")
	public @ResponseBody List<Member> searchMemberByIdName(@RequestParam("memberIdName") String memberIdName){
		System.out.println("------1");
		List<Member> list = memberService.searchByIdName(memberIdName);
		System.out.println(list);
		return list;
	}


}
