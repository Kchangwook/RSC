package subcontroller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import service.MemberService;

/** 회원 가입을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("join")
public class JoinSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
	private MemberService memberService = context.getBean("memberService",MemberService.class);
	
	/* 서블릿 */
	/** 존재하는 아이디가 있는지 확인 */
	@RequestMapping(value = "checkId.do",produces = "application/json; charset=utf8")
	public String checkId(@RequestParam("id") String id) {
		
		if(memberService.isNotHavingId(id)) 
			return "아이디가 존재합니다.";
		else
			return "";
		
	}//end of checkId


	/** 존재하는 닉네임이 있는지 확인 */
	@RequestMapping(value = "checkNick.do",produces = "application/json;charset=utf8")
	public String checkNick(@RequestParam("nick") String nick) {
		
		if(memberService.checkSameNick(nick))
			return "닉네임이 존재합니다.";
		else
			return "";
	}//end of checkNick
	
}//end of LoginSubController
