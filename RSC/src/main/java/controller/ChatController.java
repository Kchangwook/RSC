package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import domain.Chat;
import service.ChatService;

/** 채팅 기능을 위한 컨트롤러 */
@Controller
@Transactional
@RequestMapping("chat")
public class ChatController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private ChatService chatService = context.getBean("chatService",ChatService.class);
	
	/* 함수 */
	/** 회원이 속한 채팅방 정보들 가져오기 */
	@RequestMapping("getList.do")
	public String getList(HttpServletRequest request) {
		
		//파라미터 정리
		String url = "chattingList";
		String memberId = (String)request.getSession().getAttribute("id");
		
		//회원 아이디가 포함된 채팅방들 가져오기 
		List<Chat> list = chatService.getMembers(memberId);
		
		//데이터를 가져오는데 실패하면 에러 페이지로 이동
		if(list == null)
			url = "error";
		else
			request.setAttribute("list", list);
			
		return url;
		
	}//end of getList
	
}//end of ChattingController
