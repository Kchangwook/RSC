package controller;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import domain.Member;
import service.BoardService;
import service.MemberService;

/** 기본 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("basic")
public class BasicController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	private BoardService boardService = context.getBean("boardService",BoardService.class);
	
	/* 서블릿 */
	/** 시작 페이지 이동 */
	@RequestMapping("start.do")
	public String start() {
		
		return "index";
		
	}//end of start
	
	/** 회원 가입 */
	@RequestMapping("join.do")
	public String join(Model model,@ModelAttribute("member") Member m) {
		
		if(memberService.addMember(m))
			model.addAttribute("msg", "가입에 성공했습니다.");
		else
			model.addAttribute("msg","가입에 실패했습니다.");
		
		return "index";
	}//end of join
	
	/** 로그인 
	 * @throws Exception */
	@RequestMapping("login.do")
	public String login(HttpSession session,Model model,@RequestParam("memberId")String id,@RequestParam("memberPw")String pwd) throws Exception {
		
		String url = "index";
		
		switch(memberService.checkLogin(id, pwd)) {
		//존재하지 않을 때
		case 0:
			model.addAttribute("msg", "로그인에 실패했습니다.");
			return url;
		//마스터 계정일 때
		case 1:
			session.setAttribute("level", "master");
			session.setAttribute("id", "master");
			break;
		//관리자 계정일 때
		case 2:
			session.setAttribute("level", "admin");
			session.setAttribute("id", id);
			break;
		//일반 회원일 때
		case 3:
			session.setAttribute("level", "member");
			session.setAttribute("id", id);
			break;
		default:
			throw new Exception();
		}
		
		url = "loginMain";

		memberService.updateLoginInfo(id);
		model.addAttribute("list", boardService.selectAllBoard(id));
		
		return url;
		
	}//end of login
	
}//end of StartController
