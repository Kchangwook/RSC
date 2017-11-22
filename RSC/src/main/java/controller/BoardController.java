package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Board;
import domain.Member;
import service.BoardService;
import service.MemberService;
import service.ReplyService;

/** 게시글 등록을 위한 컨트롤러 */
@Controller
@RequestMapping("board")
public class BoardController {
	
	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	private ReplyService replyService = context.getBean("replyService", ReplyService.class);
	private MemberService memberService = context.getBean("memberService",MemberService.class);
	
	/* 프로퍼티 */
	public void setService(BoardService service) {
		this.boardService = service;
	}
	
	/* 게시글 작성 */
	@RequestMapping("addBoard.do")
	public String addBoard(Board b, Model data, String memberId) {
		boardService.addBoard(b);
		return "redirect:readBoard.do";
	} // end of addBoard
	
	/* 게시글 불러오기 */
	@RequestMapping("readBoard.do")
	public String readBoard(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		List<Board> list = boardService.selectAllBoard(memberId);
		
		request.setAttribute("boardList", list);
		return "loginMain";
	} // end of readBoard
	
	/** 내가 작성한 게시글 불러오기 */
	@RequestMapping("myBoards.do")
	public String myBoards(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		
		Member m = memberService.searchById(memberId);
		request.setAttribute("member", m);
		
		List<Board> list = boardService.getMine(memberId);
		request.setAttribute("list", list);
		
		return "myBoard";
		
	}//end of myBoards
	
} // end of BoardController
