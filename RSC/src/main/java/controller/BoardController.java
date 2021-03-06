package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	
	/** 게시글 작성 */
	@RequestMapping(value = "addBoard.do", method = RequestMethod.POST)
	public String addBoard(MultipartHttpServletRequest request) { 
		
		// 입력받은 데이터를 토대로 새로운 Board 객체 생성
		Board b = new Board(0,request.getParameter("memberId"), request.getParameter("boardContent"));

		System.out.println(b);
		
		boardService.addBoard(b, request);
		
		return "redirect:readBoard.do?cnt=1";
		
	} // end of addBoard
	
	/** 게시글 불러오기 */
	@RequestMapping("readBoard.do")
	public String readBoard(HttpServletRequest request) {
		
		String memberId = (String)request.getSession(false).getAttribute("id");
		int cnt = Integer.parseInt(request.getParameter("cnt").trim());
		
		Board b = new Board(memberId, cnt);
		
		List<Board> list = boardService.selectMoreBoard(b);
		
		request.setAttribute("boardList", list);
		
		return "loginMain";
		
	} // end of readBoard
	
	/** 내가 작성한 게시글 불러오기 */
	@RequestMapping("myBoards.do")
	public String myBoards(HttpServletRequest request) {
		
		String memberId = (String)request.getSession(false).getAttribute("id");
		int cnt = Integer.parseInt(request.getParameter("cnt").trim());
		
		Board b = new Board(memberId, cnt);
		
		Member m = memberService.searchById(memberId);
		request.setAttribute("member", m);
		
		List<Board> list = boardService.getMine(b);
		request.setAttribute("list", list);
		
		return "myBoard";
		
	}//end of myBoards
	
	/** 게시글 수정하기 */
	@RequestMapping("modifyBoard.do")
	public String modifyBoard(HttpServletRequest request) {
		
		String msg = "";
		
		//파라미터 설정
		int boardNum = Integer.parseInt(request.getParameter("modifyNum"));
		String boardContent = request.getParameter("modifyContent");
		
		//객체 생성
		Board b = new Board();
		b.setBoardNum(boardNum);
		b.setBoardContent(boardContent);
		
		//내용 수정 성공 여부
		if(boardService.updateContent(b))
			msg = "수정에 성공했습니다.";
		else
			msg = "수정에 실패했습니다.";
		
		return "redirect:myBoards.do?cnt=1";
		
	}//end of modifyBoard
	
	/** 그룹 게시글 수정 */
	@RequestMapping("modifyGroupBoard.do")
	public String updateGroupBoard(HttpServletRequest request) {
		
		String msg = "";
		
		//파라미터 설정
		int boardNum = Integer.parseInt(request.getParameter("modifyNum"));
		String boardContent = request.getParameter("modifyContent");
		int groupNum = Integer.parseInt(request.getParameter("groupNum"));
		
		//객체 생성
		Board b = new Board();
		b.setBoardNum(boardNum);
		b.setBoardContent(boardContent);
		
		//내용 수정 성공 여부
		if(boardService.updateContent(b))
			msg = "수정에 성공했습니다.";
		else
			msg = "수정에 실패했습니다.";
		
		return "redirect:../basic/group.do?groupNum="+groupNum+"&cnt=1";
	}
	
} // end of BoardController
