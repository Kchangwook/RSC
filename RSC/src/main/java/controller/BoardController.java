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
	public BoardService service = context.getBean("boardService", BoardService.class);
	
	
	// 프로퍼티값 설정
	public void setService(BoardService service) {
		this.service = service;
	}
	
	// 글쓰기 및 글 불러오기
	@RequestMapping("add.do")
	public String addBoard(Board board, Model data) {
		System.out.println(board);
		service.addBoard(board);
		System.out.println("이제 끝이다");
		
		return "index2";
	} // end of addBoard

} // end of BoardController
