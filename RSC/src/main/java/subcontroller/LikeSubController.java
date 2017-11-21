package subcontroller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import domain.Board;
import service.BoardService;

/** 좋아요 기능을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("like")
public class LikeSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	
	/* 게시글 좋아요 */
	@RequestMapping("plusLike.do")
	public @ResponseBody Board plusLike(@RequestParam("boardNum") int boardNum) {
		Board board = boardService.plusLike(boardNum);
		return board;
	} // end of plusLike
	
	/* 게시글 좋아요 취소 */
	@RequestMapping("minusLike.do")
	public @ResponseBody Board minusLike(@RequestParam("boardNum") int boardNum) {
		Board board = boardService.minusLike(boardNum);
		return board;
		
	} // end of minusLike
	
	
	
} // end of LikeSubController
