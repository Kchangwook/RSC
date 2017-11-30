package subcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import domain.Friend;
import domain.FriendRequest;
import service.FriendRequestService;
import service.FriendService;
import service.NoticeService;

/** 알림과 관련된 비동기 통신 클래스 */
@Transactional
@RestController
@RequestMapping("notice")
public class NoticeSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private FriendRequestService friendRequestService = context.getBean("friendRequestService",FriendRequestService.class);
	private NoticeService noticeService = context.getBean("noticeService",NoticeService.class);
	private FriendService friendService = context.getBean("friendService",FriendService.class);
	
	/* 함수 */
	/** 친구 요청 결과 */
	@RequestMapping("friendResult.do")
	public String friendResult(HttpServletRequest request) {
		
		//항목 정렬
		String memberId = (String)request.getSession().getAttribute("id");
		int noticeNum = Integer.parseInt(request.getParameter("noticeNum"));
		int requestNum = Integer.parseInt(request.getParameter("requestNum"));
		String result = request.getParameter("result");
		FriendRequest fr = friendRequestService.searchByNum(requestNum);
		String friendId = fr.getMemberId();
		
		if(result.equals("true")) 
			friendService.addFriend(new Friend(memberId,friendId));
		
		friendRequestService.deleteByNum(requestNum);
		noticeService.deleteByNoticeNum(noticeNum);
		
		return "success";		
		
	}//end of friendResult
	
	/** 알림의 개수를 가져오는 함수 */
	@RequestMapping(value = "getCount.do",produces = "application/json; charset=utf8")
	public int getCount(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		
		return noticeService.getCount(memberId);
		
	}//end of getCount
	
}//end of NoticeSubController
