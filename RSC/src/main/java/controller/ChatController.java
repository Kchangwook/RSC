package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Chat;
import domain.Member;
import domain.Message;
import service.ChatService;
import service.MemberService;
import service.MessageService;

/** 채팅 기능을 위한 컨트롤러 */
@Controller
@Transactional
@RequestMapping("chat")
public class ChatController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private ChatService chatService = context.getBean("chatService",ChatService.class);
	private MemberService memberService = context.getBean("memberService",MemberService.class);
	private MessageService messageService = context.getBean("messageService", MessageService.class);
	
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
	
	/** 채팅 페이지 이동 */
	@RequestMapping("chatting.do")
	public String goChattingPage(@RequestParam("chatNum") int chatNum, Model model) {
		List<Message> messagelist = messageService.searchAllMessageByChatNum(chatNum);
		List<Member> memberList = memberService.searchChatMemberByChatNum(chatNum);
		
		model.addAttribute("chatNum",chatNum);
		
		if(messagelist.size() > 0) {
			model.addAttribute("recentMessageNum",messagelist.get(messagelist.size()-1).getMessageNum());
		} else {
			model.addAttribute("recentMessageNum",0);
		}
		
		model.addAttribute("messageList",messagelist);
		model.addAttribute("memberList",memberList);
		return "chatting";
	}
	
	/** 채팅 메시지 서버에 전송 */
	@RequestMapping(value="sendingMsg.do", produces = "application/json; charset=utf8")
	public @ResponseBody String sendingMessage(Message message) {
		System.out.println(message);
		boolean result = messageService.addMessage(message);
		if(result) {
			return "전송 성공";
		} else {
			return "전송 실패";
		}
	}
	
	/** 같은 chatNum 중 최근 messageNum 검색 */
	@RequestMapping("compareMsgNum.do")
	public @ResponseBody int compareMsgNum(@RequestParam("chatNum") int chatNum) {
		int recentMsgNum = messageService.searchRecentMessageNumByChatNum(chatNum);
		return recentMsgNum;
	}
	
	/** 메시지 list 갱신 */
	@RequestMapping("recentMsg.do")
	public @ResponseBody List<Message> getRecentMessage(@RequestParam("chatNum") int chatNum,
														@RequestParam("messageNum") int messageNum){
		Message message = new Message();
		message.setChatNum(chatNum);
		message.setMessageNum(messageNum);
		
		List<Message> list = messageService.searchRecentMessage(message);
		return list;
	}
	
	/** 채팅방 나가기 */
	@RequestMapping("goOutChat.do")
	public String goOutChat(Chat chat) {
		boolean result = chatService.deleteChat(chat);

		return "redirect:getList.do";
	}
	
	/** 친구 목록 가져오기 */
	@RequestMapping("getFriendList.do")
	public @ResponseBody List<Member> searchFriendList(@RequestParam("memberId") String memberId){
		List<Member> list = memberService.searchFriendMemberById(memberId);
		return list;
	}
	
	/** 친구 초대 하기 */
	@RequestMapping("invite.do")
	public String addChatMember(@RequestParam("chatNum") int chatNum,
								@RequestParam("inviteList") String inviteList) {
		boolean result = true;
		String[] memberList = inviteList.split(",");
		Chat chat = new Chat();
		
		for (int i = 0; i < memberList.length; i++) {
			chat.setChatNum(chatNum);
			chat.setMemberId(memberList[i]);
			result = chatService.addChatMemberInvited(chat);
		}
		
		return "redirect:chatting.do?chatNum="+chatNum;
	}
	
}//end of ChattingController
