package controller;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Reply;
import service.ReplyService;

/** 댓글 등록을 위한 컨트롤러 */
@Controller
@RequestMapping("reply")
public class ReplyController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private ReplyService replyService = context.getBean("replyService", ReplyService.class);
	
	/* 프로퍼티 */
	public void setService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	/* 게시글 번호로 댓글 불러오기 */
	@RequestMapping("readReply.do")
	public @ResponseBody List<Reply> readReply(@RequestParam("boardNum") int boardNum) {
		List<Reply> list = replyService.selectReply(boardNum);
		return list;
	} // end of readReply
	
	
} // end of ReplyController
