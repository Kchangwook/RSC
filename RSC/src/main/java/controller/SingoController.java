package controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Board;
import domain.BoardSingo;
import domain.Notice;
import domain.Reply;
import domain.ReplySingo;
import service.BoardService;
import service.NoticeService;
import service.ReplyService;
import service.SingoService;

/** 신고 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("singo")
public class SingoController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private SingoService singoService = context.getBean("singoService", SingoService.class);
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	private ReplyService replyService = context.getBean("replyService", ReplyService.class);
	private NoticeService noticeService = context.getBean("noticeService", NoticeService.class);
	
	/* 프로퍼티 */
	public void setService(SingoService service) {
		this.singoService = service;
	}
	
	/* 게시글 신고 등록 & 게시자에게 알림 주기 */
	@RequestMapping("addBoardSingo.do")
	public String addBoardSingo(BoardSingo bs) {
		Board board = boardService.searchBoard1(bs.getBoardNum());
		
		Notice notice = new Notice();
		
		notice.setMemberId(board.getMemberId());
		notice.setNoticeContent(board.getBoardTime() + "에 작성한 글이 신고 되었습니다");

		noticeService.addNotice1(notice);
		singoService.addBoardSingo(bs);
		
		return "redirect:../board/readBoard.do";
	} // end of addBoardSingo

	/* 댓글 신고 등록 & 게시자에게 알림 주기*/
	@RequestMapping("addReplySingo.do")
	public String addReplySingo(ReplySingo rs) {
		
		Reply reply = replyService.searchReply1(rs.getReplyNum());
		
		Notice notice = new Notice();
		
		notice.setMemberId(reply.getMemberId());
		notice.setNoticeContent(reply.getReplyTime() + "에 작성한 글이 신고 되었습니다");
		
		noticeService.addNotice1(notice);
		singoService.addReplySingo(rs);
		
		
		return "redirect:../board/readBoard.do";
	} // end of addReplySingo
	
} // end of SingoController
