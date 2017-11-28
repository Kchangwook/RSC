package controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Board;
import domain.BoardSingo;
import domain.GroupSingo;
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
		// 날짜 형식 변환
		Date form = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		
		String time = sdf.format(board.getBoardTime());
		
		Notice notice = new Notice();
		
		notice.setMemberId(board.getMemberId());
		notice.setNoticeContent(time + "에 작성한 글이 신고 되었습니다");
		
		noticeService.addNotice1(notice);
		singoService.addBoardSingo(bs);
		
		return "redirect:../board/readBoard.do?cnt=1";
	} // end of addBoardSingo

	/* 댓글 신고 등록 & 게시자에게 알림 주기*/
	@RequestMapping("addReplySingo.do")
	public String addReplySingo(ReplySingo rs) {
		
		Reply reply = replyService.searchReply1(rs.getReplyNum());
		// 날짜 형식 변환
		Date form = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		
		String time = sdf.format(reply.getReplyTime());
		
		// 알림 객체 생성
		Notice notice = new Notice();
		
		notice.setMemberId(reply.getMemberId());
		notice.setNoticeContent(time + "에 작성한 댓글이 신고 되었습니다");
		
		noticeService.addNotice1(notice);
		singoService.addReplySingo(rs);
		
		
		return "redirect:../board/readBoard.do?cnt=1";
	} // end of addReplySingo
	
	/* 그룹 게시글 신고 등록 & 게시자에게 알림 주기 */
	@RequestMapping("addGroupBoardSingo.do")
	public String addGroupBoardSingo(BoardSingo bs,
									@RequestParam("groupNum") int groupNum,
									@RequestParam("groupName") String groupName) {
		Board board = boardService.searchBoard1(bs.getBoardNum());
		
		Date form = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		
		String time = sdf.format(board.getBoardTime());
		
		Notice notice = new Notice();
		
		notice.setMemberId(board.getMemberId());
		notice.setNoticeContent(time + "에 ["+groupName+"]그룹에 작성한 글이 신고 되었습니다");

		noticeService.addNotice1(notice);
		singoService.addBoardSingo(bs);
		
		return "redirect:../basic/group.do?groupNum="+groupNum;
	} // end of addBoardSingo

	/* 그룹 댓글 신고 등록 & 게시자에게 알림 주기*/
	@RequestMapping("addGroupReplySingo.do")
	public String addGroupReplySingo(ReplySingo rs,
									@RequestParam("groupNum") int groupNum,
									@RequestParam("groupName") String groupName) {
		
		Reply reply = replyService.searchReply1(rs.getReplyNum());
		
		Date form = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
		
		String time = sdf.format(reply.getReplyTime());
		
		Notice notice = new Notice();
		
		notice.setMemberId(reply.getMemberId());
		notice.setNoticeContent(time + "에 ["+groupName+"]그룹에 작성한 댓글이 신고 되었습니다");
		
		noticeService.addNotice1(notice);
		singoService.addReplySingo(rs);
		
		
		return "redirect:../basic/group.do?groupNum="+groupNum;
	} // end of addReplySingo
	
	/** 그룹 신고 */
	@RequestMapping("groupSingo.do")
	public @ResponseBody boolean addGroupSingo(GroupSingo groupSingo) {
		boolean result = singoService.addGroupSingo(groupSingo);
		return result;
	}
	
} // end of SingoController
