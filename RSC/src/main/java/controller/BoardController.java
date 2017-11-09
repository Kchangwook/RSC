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
	public String addBoard(Board b, Model data, String memberId) {
		System.out.println(b);
		service.addBoard(b);
		System.out.println("이제 끝이다");
		data.addAttribute("list", service.selectAllBoard(memberId));
		System.out.println("얘는 찍히니");
		return "index2";
	} // end of addBoard
	
	// 로그인 후 글 불러오기
	@RequestMapping("read.do")
	public String readBoard(Model data, String memberId) {
		data.addAttribute("list", service.selectAllBoard(memberId));
		return "index2";
	}
} // end of BoardController
