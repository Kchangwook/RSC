package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Board;
import service.BoardService;
import service.ReplyService;

/** 게시글 등록을 위한 컨트롤러 */
@Controller
@RequestMapping("board")
public class BoardController {
	
	/* 변수 */
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	public BoardService boardService = context.getBean("boardService", BoardService.class);
	public ReplyService replyService = context.getBean("replyService", ReplyService.class);
	
	/* 프로퍼티 */
	public void setService(BoardService service) {
		this.boardService = service;
	}
	
	/* 게시글 작성 & 불러오기 */
	@RequestMapping("addBoard.do")
	public String addBoard(Board b, Model data, String memberId) {
		boardService.addBoard(b);
		return "redirect:readBoard.do";
	} // end of addBoard
	
	/* 로그인 후 불러오기 */
	@RequestMapping("readBoard.do")
	public String readBoard(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		
		request.setAttribute("boardList", boardService.selectAllBoard(memberId));
		return "loginMain";
	}
	
	/* 번호로 글 검색 */
	@RequestMapping("searchBoard.do")
	public @ResponseBody Board searchBoard(@RequestParam("boardNum") int boardNum ) {
		Board board = boardService.searchBoard(boardNum);
		return board;
	}
	
} // end of BoardController
