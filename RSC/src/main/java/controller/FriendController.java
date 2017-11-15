package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Friend;
import service.FriendService;

/** 친구 관련 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("friend")
public class FriendController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private FriendService service = context.getBean("friendService",FriendService.class);
	
	/** 모든 친구 리스트를 불러오기 */
	@RequestMapping("getList.do")
	public String getFriendList(HttpServletRequest request) {
		
		String id = (String)request.getSession().getAttribute("id");
		List<Friend> list = service.getList("ckddnr");
		
		request.setAttribute("list", list);
		
		return "friendList";
		
	}//end of getFriendList
	
	/** 선택한 친구를 삭제 */
	@RequestMapping("delete.do")
	public String deleteFriend(HttpServletRequest request) {
	
		return service.deleteFriend(new Friend(request.getParameter("memberId"),request.getParameter("friendId")));
		
	}//end of deleteFriend
	
}//FriendController
