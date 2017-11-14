package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import domain.Board;
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
	public String start(HttpServletRequest request) {
		
		Map<String,List<Board>> map = boardService.getLists();
		request.setAttribute("map", map);
		
		return "index";
		
	}//end of start
	
	/** 회원 가입 */
	@RequestMapping(value = "join.do", method = RequestMethod.POST)
	public String join(MultipartHttpServletRequest request) {
				
		String interests[] = request.getParameterValues("memberInterest");
		String interest = "";
		
		for(String s:interests)
			interest += s+",";
		
		Member m = new Member(request.getParameter("memberId"),request.getParameter("memberPw")
				,request.getParameter("memberNick"),interest
				,Integer.parseInt(request.getParameter("memberInfoOpen")),0);
		
		if(memberService.addMember(m,request))
			request.setAttribute("msg","가입에 성공했습니다.");
		else
			request.setAttribute("msg","가입에 실패했습니다.");
		
		return "redirect:../index.html";
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
			//닉네임 가져온 후 세션에 추가
			String nick = memberService.getNick(id);
			
			session.setAttribute("nick", nick);
			url = "redirect:../board/readBoard.do";
			memberService.updateLoginInfo(id);
			break;
		default:
			throw new Exception();
		}
		
		return url;
		
	}//end of login
	
	/** 로그아웃 */
	@RequestMapping("logout.do")
	public String logout(HttpSession session) throws Exception {
		
		session.invalidate();
		session = null;
		
		return "redirect:../index.html";
		
	}//end of logout
	
	/** 마이페이지로 이동 */
	@RequestMapping("mypage.do")
public String mypage(Model model, @RequestParam("mypageMemberId") String memberId) {
		
		String url = "mypage";
		
		Member member = memberService.searchById(memberId);
		
		model.addAttribute("member", member);
		
		Map map = new HashMap();
		
		map.put("exercise", false);
		map.put("cooking", false);
		map.put("movie", false);
		map.put("music", false);
		map.put("book", false);
		map.put("fashion", false);
		map.put("game", false);
		map.put("trip", false);
		map.put("etc", false);
		
		String[] interest = member.getMemberInterest().split(",");
		
		for (int i = 0; i < interest.length; i++) {
			map.replace(interest[i], true);
		}
		
		model.addAttribute("interest", map);
		
		return url;
		
	}//end of mypage
	
	/** 마이페이지에서 회원 정보 수정 */
	@RequestMapping("update.do")
public String update(Model model, @ModelAttribute("member") Member m, HttpServletRequest request, @RequestParam("memberId")String id, @RequestParam("memberPw")String pwd) {
		
		String url = "mypage";
		
		if(memberService.checkLogin(id, pwd) != 0) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다");
		} else {
			if(memberService.updateMember(m, request))
				model.addAttribute("msg", "정보수정에 성공했습니다");
			else
				model.addAttribute("msg","정보수정에 실패했습니다.");
		}
		
		return url;
		
	}//end of update
	
}//end of StartController
