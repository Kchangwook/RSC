package subcontroller;

import java.util.HashMap;
import java.util.Map;

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
	public @ResponseBody Map searchBoard(@RequestParam("boardNum") int boardNum ) {
		Map map = new HashMap<>();
		map.put("board", boardService.searchBoard(boardNum));
		map.put("reply", replyService.selectReply(boardNum));
		return map;
	} // end of searchBoard
	
} // end of BoardSubController
