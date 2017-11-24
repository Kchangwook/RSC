package subcontroller;

import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import service.ChatService;

/** 채팅을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("chat")
public class ChatSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private ChatService chatService = context.getBean("chatService",ChatService.class);
	
	/** 채팅방 만들기 */
	@RequestMapping(value = "makeRoom.do",produces = "application/json; charset=utf8")
	public String makeRoom(@RequestBody Map<String,List<String>> map) {
		
		//파라미터 정리
		String msg = "채팅방을 만드는데 성공하셨습니다.";
		List<String> nicks = map.get("people");
		
		if(!chatService.makeChatRoom(nicks))
			msg = "채팅방을 만드는데 실패했습니다.";
		
		return msg;
		
	}//end of makeRoom
	
}//end of ChatSubController
