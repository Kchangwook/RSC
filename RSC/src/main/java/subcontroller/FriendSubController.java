package subcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import domain.FriendRequest;
import service.FriendRequestService;

/** 친구 페이지 서브 컨트롤러 */
@RestController
@RequestMapping("friend")
public class FriendSubController {

	/* 변수 */
	ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	FriendRequestService frService = context.getBean("friendRequestService",FriendRequestService.class);
	
	/** 친구 요청을 추가 */
	@RequestMapping(value = "requestFriend.do",produces = "application/json; charset=utf8")
	public String addFriendRequest(HttpServletRequest request) {
		
		FriendRequest f = new FriendRequest(request.getParameter("memberId"),request.getParameter("friendId"));
		
		if(frService.addFriendRequest(f))
			return "친구 요청이 되었습니다";
		else
			return "친구 요청에 실패했습니다.";
		
	}//end of addFriendRequest
	
}//end of FriendSubController
