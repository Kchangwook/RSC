package subcontroller;

import java.util.List;

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
	
	
	/*@RequestMapping("addReply.do")
	public @ResponseBody List<Reply> addReply(Reply r) {
		//r 의 데이터 확인
		if(r.getReplyContent()!=null) {
			boolean result = replyService.addReply(r);
		}
		List<Reply> list = replyService.selectReply(r.getBoardNum());
		return list;
	} // end of addReply */
	
} // end of ReplySubController
