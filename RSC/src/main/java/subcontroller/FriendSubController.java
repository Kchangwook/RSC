package subcontroller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import domain.Board;
import domain.FriendRequest;
import domain.Member;
import domain.Notice;
import service.BoardService;
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
	private BoardService boardService = context.getBean("boardService",BoardService.class);
	
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
	
	/** 친구가 쓴 글 더보기 */
	@RequestMapping("readFriendBoard.do")
	public @ResponseBody List<Board> readFriendBoard(@RequestParam("friendId") String id,
													 @RequestParam("cnt") int cnt) {
		
		Board b = new Board(id, cnt);
		
		List<Board> list = boardService.getForAll(b);
		
			return list;
	}
	
}//end of FriendSubController
