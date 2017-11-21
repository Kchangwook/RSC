package subcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import domain.FriendRequest;
import domain.Notice;
import service.FriendRequestService;
import service.NoticeService;

/** 친구 페이지 서브 컨트롤러 */
@RestController
@RequestMapping("friend")
public class FriendSubController {

	/* 변수 */
	ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	FriendRequestService frService = context.getBean("friendRequestService",FriendRequestService.class);
	NoticeService noticeService = context.getBean("noticeService",NoticeService.class);
	
	/** 친구 요청을 추가 */
	@RequestMapping(value = "requestFriend.do",produces = "application/json; charset=utf8")
	public String addFriendRequest(HttpServletRequest request) {
		
		//파라미터 정렬
		String friendId = request.getParameter("friendId");
		String memberId = (String)request.getSession().getAttribute("id");
		FriendRequest f = new FriendRequest(request.getParameter("memberId"),friendId);
		
		if(frService.addFriendRequest(f)) {
			
			//알림 생성
			noticeService.addFriendRequest(new Notice(friendId,memberId+"님이 친구요청을 하셨습니다.",2));
			return "친구 요청이 되었습니다";
		}
		else
			return "친구 요청에 실패했습니다.";
		
	}//end of addFriendRequest
	
}//end of FriendSubController
