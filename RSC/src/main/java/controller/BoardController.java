package controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Board;
import service.BoardService;

/** 게시글 등록을 위한 컨트롤러 */
@Controller
@RequestMapping("board")
public class BoardController {
	
	/* 변수 */
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	public BoardService boardService = context.getBean("boardService", BoardService.class);
	
	
	// 프로퍼티값 설정
	public void setService(BoardService service) {
		this.boardService = service;
	}
	
	// 글쓰기 및 글 불러오기
	@RequestMapping("addBoard.do")
	public String addBoard(Board b, Model data, String memberId) {
		boardService.addBoard(b);
		data.addAttribute("list", boardService.selectAllBoard(memberId));
		return "loginMain";
	} // end of addBoard
	
	// 로그인 후 글 불러오기
	@RequestMapping("readBoard.do")
	public String readBoard(Model data, String memberId) {
		data.addAttribute("list", boardService.selectAllBoard(memberId));
		return "loginMain";
	}
	
} // end of BoardController
