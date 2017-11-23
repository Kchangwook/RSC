package subcontroller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import domain.Reply;
import service.ReplyService;

/** 댓글 기능을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("reply")
public class ReplySubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	private ReplyService replyService = context.getBean("replyService", ReplyService.class);
	
	/* 서블릿 */
	/* 댓글 등록 및 게시글 번호로 댓글 가져오기 */
	@RequestMapping("addReply.do")
	public @ResponseBody List<Reply> addReply(Reply r) {
		boolean result = replyService.addReply(r);
		List<Reply> list = replyService.selectReply(r.getBoardNum());
		return list;
	} // end of addReply
	
	/** 댓글 번호로 댓글 삭제하기 */
	@RequestMapping("deleteReply.do")
	public String deleteReply(HttpServletRequest request) {
		
		String msg = "";
		int replyNum = Integer.parseInt(request.getParameter("replyNum"));
		
		if(replyService.deleteByNum(replyNum))
			msg = "삭제에 성공했습니다.";
		else
			msg = "삭제에 실패했습니다.";
		
		return msg;
		
	}//end of deleteReply
	
} // end of ReplySubController
