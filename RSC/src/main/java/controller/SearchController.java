package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Groups;
import domain.Member;
import service.GroupsService;
import service.MemberService;

/** 회원 또는 그룹 검색 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("searchMemberAndGroup")
public class SearchController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private MemberService memberService = context.getBean("memberService",MemberService.class);
	private GroupsService groupService = context.getBean("groupsService",GroupsService.class);
	
	/** 일부 memberNick을 통해 member 데이터를 가져오는 기능 */
	/** 일부 groupName을 통해 group 데이터를 가져오는 기능 */
	@RequestMapping(value="searchByPart.do",produces = "application/json; charset=utf8")
	public @ResponseBody String searchByPart(@RequestParam("part") String part) {
		
		List<Member> list = new ArrayList<>();
		List<Groups> listGroup = new ArrayList<>();
		
		StringBuffer sb = new StringBuffer();
		
		list = memberService.searchByPartOfMemberNick(part);
		listGroup = groupService.searchByPartOfGroupName(part);
		
		sb.append("[");
		if(list.size() > 0) {
			for( int i=0; i<list.size() ; i++ ) {
				sb.append("{");
				sb.append("\"memberId\":\""+list.get(i).getMemberId()+"\",");
				sb.append("\"memberNick\":\""+list.get(i).getMemberNick()+"\",");
				sb.append("\"memberImg\":\""+list.get(i).getMemberImg()+"\",");
				sb.append("\"memberInterest\":\""+list.get(i).getMemberInterest()+"\"}");
				if(i != list.size()-1 ) {
					sb.append(",");
				}
			}
		}
		
		if(listGroup.size() > 0) {
			if(sb.length() > 1) {
				sb.append(",");
			}
			for( int i=0; i<listGroup.size() ; i++ ) {
				sb.append("{");
				sb.append("\"groupNum\":\""+listGroup.get(i).getGroupNum()+"\",");
				sb.append("\"groupName\":\""+listGroup.get(i).getGroupName()+"\",");
				sb.append("\"groupImg\":\""+listGroup.get(i).getGroupImg()+"\",");
				sb.append("\"groupInfo\":\""+listGroup.get(i).getGroupInfo()+"\",");
				sb.append("\"groupInterest\":\""+listGroup.get(i).getGroupInterest()+"\"}");
				if(i != listGroup.size()-1 ) {
					sb.append(",");
				}
			}
		}
		sb.append("]");
		
		return sb.toString();
		
	}//end of searchByPart
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 기능 *//*
	@RequestMapping(value="deleteByNoticeNum.do",produces = "application/json; charset=utf8")
	public void deleteByNoticeNum(@RequestParam("noticeNum") int noticeNum) {
		
		noticeService.deleteByNoticeNum(noticeNum);
	}//end of deleteByNoticeNum*/
	
}//end of SearchController