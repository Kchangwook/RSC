package subcontroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import service.RandomChatService;

/** 랜덤 채팅을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("random")
public class RandomChatSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private RandomChatService randomChatService = context.getBean("randomChatService", RandomChatService.class);
	
	/* 함수 */
	/** 1:1 랜덤채팅 대기열에 넣는 함수 */
	@RequestMapping(value = "addOne.do",produces = "application/json; charset=utf8")
	public String addOne(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		if(randomChatService.addOneRandomChat(memberId))
			return "1:1 랜덤채팅 대기열에 추가되었습니다.";
		else
			return "1:1 랜덤채팅 대기열에 추가되지 못했습니다.";
		
	}//end of addOne
	
	/** 그룹 랜덤채팅 대기열에 넣는 함수 */
	@RequestMapping(value = "addGroup.do",produces = "application/json; charset=utf8")
	public String addGroup(HttpServletRequest request) {
		
		String memberId = (String)request.getSession().getAttribute("id");
		if(randomChatService.addGroupRandomChat(memberId))
			return "그룹 랜덤채팅 대기열에 추가되었습니다.";
		else
			return "그룹 랜덤채팅 대기열에 추가되지 못했습니다.";
		
	}//end of addGroup
	
}//end of RandomChatSubController
