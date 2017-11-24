package subcontroller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import domain.Member;
import service.MemberService;

/** 회원을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("member")
public class MemberSubController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	
	/* 함수 */
	/** 현재 로그인 중인 회원 찾기 */
	@RequestMapping(value = "checkLogin.do",produces = "application/json; charset=utf8")
	public @ResponseBody List<Member> checkLogin(HttpServletRequest request) {
		
		//파라미터 설정
		String memberId = (String)request.getSession().getAttribute("id");
		
		//접속 중인 친구 찾기
		List<Member> list = memberService.searchPresentLogin(memberId);
		
		//실패서 null 반환
		if(list == null)
			return null;
		
		return list;
		
	}//end of checkLogin
	
}//end of MemberSubController
