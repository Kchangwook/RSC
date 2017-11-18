package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Board;
import domain.Friend;
import domain.Member;
import service.BoardService;
import service.FriendService;
import service.MemberService;

/** 친구 관련 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("friend")
public class FriendController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private FriendService friendService = context.getBean("friendService",FriendService.class);
	private MemberService memberService = context.getBean("memberService",MemberService.class);
	private BoardService boardService = context.getBean("boardService",BoardService.class);
	
	/** 모든 친구 리스트를 불러오기 */
	@RequestMapping("getList.do")
	public String getFriendList(HttpServletRequest request) {
		
		String id = (String)request.getSession().getAttribute("id");
		List<Friend> list = friendService.getList(id);
		
		request.setAttribute("list", list);
		
		return "friendList";
		
	}//end of getFriendList
	
	/** 선택한 친구를 삭제 */
	@RequestMapping("delete.do")
	public String deleteFriend(HttpServletRequest request) {
	
		return friendService.deleteFriend(new Friend(request.getParameter("memberId"),request.getParameter("friendId")));
		
	}//end of deleteFriend
	
	/** 친구의 정보를 가져오는 함수 */
	@RequestMapping("getFriendInfo.do")
	public String getFriendInfo(HttpServletRequest request) {
		
		String url = "";
		String id = request.getParameter("friendId");
		
		// 회원정보 가져오기
		Member friend = memberService.searchById(id);
		if(friend == null)
			url = "error";
		else {
			url = "friend";
			request.setAttribute("friend", friend);
		}
		
		//회원이 작성한 전체 게시글들 가져오기
		List<Board> list = boardService.getForAll(id);
		if(list == null)
			url = "error";
		else {
			url = "friend";
			request.setAttribute("list", list);
		}
		
		return url;
		
	}//end of getFriendInfo
	
}//FriendController
