package subcontroller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import domain.Board;
import service.BoardService;
import service.ReplyService;

/** 게시글 상세보기를 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("board")
public class BoardSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	private ReplyService replyService = context.getBean("replyService", ReplyService.class);
	
	/* 서블릿 */
	/* 번호로 글 검색 */
	/*@RequestMapping("searchBoard.do")
	public @ResponseBody Board searchBoard(@RequestParam("boardNum") int boardNum ) {
		Board board = boardService.searchBoard(boardNum);
		System.out.println(board);
		return board;
	} // end of searchBoard
*/	
	
	/* 게시글과 댓글 불러오기 */
	@RequestMapping("searchBoard.do")
	public @ResponseBody Map<String,Object> searchBoard(@RequestParam("boardNum") int boardNum ) {
		Map<String,Object> map = new HashMap<>();
		
		Board b = boardService.searchBoard(boardNum);
		
		map.put("board", b);
		map.put("reply", replyService.selectReply(boardNum));
		return map;
	} // end of searchBoard
	
	/** 게시글 삭제하기 */
	@RequestMapping(value = "deleteBoard.do",produces = "application/json; charset=utf8")
	public String deleteBoard(HttpServletRequest request) {
		
		String msg = "삭제 성공했습니다.";
		
		int boardNum = Integer.parseInt(request.getParameter("boardNum"));
		
		if(!boardService.deleteByNum(boardNum))
			msg = "삭제 실패했습니다.";
		
		return msg;
		
	}//end of deleteBoard
	
} // end of BoardSubController
