package controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Reply;
import service.ReplyService;

/** 댓글 등록을 위한 컨트롤러 */
@Controller
@RequestMapping("reply")
public class ReplyController {

	/* 변수 */
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	public ReplyService replyService = context.getBean("replyService", ReplyService.class);
	
	// 프로퍼티값 설정
	public void setService(ReplyService replyService) {
		this.replyService = replyService;
	}
	
	// 댓글 작성 및 불러오기
	@RequestMapping("addReply.do")
	public String addReply(Reply r, Model model, int boardNum) {
		replyService.addReply(r);
		model.addAttribute("replyList", replyService.selectAllReply(boardNum));
		return "loginMain";
	}
	
	/* 댓글 불러오기 */
	@RequestMapping("readReply.do")
	public String readReply(Model model, int boardNum) {
		model.addAttribute("replyList", replyService.selectAllReply(boardNum));
		return "loginMain";
	}
	
	
} // end of ReplyController
