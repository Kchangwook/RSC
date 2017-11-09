package controller;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import domain.Groups;
import service.GroupsService;

@Controller
@RequestMapping("admin")
public class AdminController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);
	
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
		return "redirect:admin/group.do";
	}

}
