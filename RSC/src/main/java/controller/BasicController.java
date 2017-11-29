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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import domain.Board;
import domain.Member;
import service.BoardService;
import service.GroupsService;
import service.MemberService;

/** 기본 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("basic")
public class BasicController {

	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	private BoardService boardService = context.getBean("boardService", BoardService.class);
	private GroupsService groupsService = context.getBean("groupsService", GroupsService.class);

	/* 서블릿 */
	/** 시작 페이지 이동 */
	@RequestMapping("start.do")
	public String start(HttpServletRequest request) {

		Map<String, List<Board>> map = boardService.getLists();
		request.setAttribute("map", map);
		
		return "index";

	}// end of start

	/** 회원 가입 */
	@RequestMapping(value = "join.do", method = RequestMethod.POST)
	public String join(MultipartHttpServletRequest request) {
		
		// 관심사 정렬
		String interests[] = request.getParameterValues("memberInterest");
		String interest = "";

		for (int i = 0; i < interests.length; i++) {
			if (i == interests.length - 1)
				interest += interests[i];
			else
				interest += interests[i] + ",";
		}
		
		// 입력받은 데이터를 토대로 새로운 멤버 객체 생성
		Member m = new Member(request.getParameter("memberId"), request.getParameter("memberPw"),
				request.getParameter("memberNick"), interest, Integer.parseInt(request.getParameter("memberInfoOpen")),
				0);

		// 멤버 추가
		if (memberService.addMember(m, request))
			request.setAttribute("msg", "가입에 성공했습니다.");
		else
			request.setAttribute("msg", "가입에 실패했습니다.");

		return "redirect:../index.html";
	}// end of join

	/**
	 * 로그인
	 * 
	 * @throws Exception
	 */
	@RequestMapping("login.do")
	public String login(HttpServletRequest request) throws Exception {

		String url = "index";
		String id = request.getParameter("loginId");
		String pwd = request.getParameter("loginPwd");
		HttpSession session = null;
		
		switch (memberService.checkLogin(id, pwd)) {
		// 존재하지 않을 때
		case 0:
			url = "redirect:start.do?msg=fail";
			return url;
		// 마스터 계정일 때
		case 1:
			session = request.getSession();
			session.setMaxInactiveInterval(60*60*6);
			session.setAttribute("level", "master");
			session.setAttribute("id", "master");
			url = "redirect:../admin/board.do";
			break;
		// 관리자 계정일 때
		case 2:
			session = request.getSession();
			session.setMaxInactiveInterval(60*60*6);
			session.setAttribute("level", "admin");
			session.setAttribute("id", id);
			url = "redirect:../admin/board.do";
			break;
		// 일반 회원일 때
		case 3:
			session = request.getSession();
			session.setMaxInactiveInterval(60*60*6);
			session.setAttribute("level", "member");
			session.setAttribute("id", id);
			
			// 닉네임과 이미지를 가져온 후 세션에 추가
			Member m = memberService.searchById(id);
			String nick = m.getMemberNick();
			String imgSrc = m.getMemberImg();
			session.setAttribute("nick", nick);
			session.setAttribute("imgSrc", imgSrc);
			
			url = "redirect:../board/readBoard.do?cnt=1";
			memberService.updateLoginInfo(id);
			break;
		default:
			throw new Exception();
		}

		return url;

	}// end of login

	/** 로그아웃 */
	@RequestMapping("logout.do")
	public String logout(HttpSession session) throws Exception {

		String id = (String) session.getAttribute("id");
		String url = "redirect:../index.html";
		String level = (String) session.getAttribute("level");

		if (level.equals("member")) {
			// 로그아웃 정보 수정
			if (!memberService.logoutMember(id))
				url = "error";
			else {
				session.invalidate();
				session = null;
			}
		} else {
			session.invalidate();
			session = null;
		}

		return url;

	}// end of logout

	/** 마이페이지로 이동 */
	@RequestMapping("mypage.do")
	public String mypage(HttpServletRequest request) {
		
		String id = (String)request.getSession().getAttribute("id");
		
		Member member = memberService.searchById(id);
		request.setAttribute("member", member);
		
		return "mypage";

	}// end of mypage

	/** 마이페이지에서 회원 정보 수정 */
	@RequestMapping(value = "update.do", method = RequestMethod.POST)
	public String update(MultipartHttpServletRequest request) {
		
		//파라미터 값 받아오기
		String id = (String)request.getSession().getAttribute("id");
		String pwd = request.getParameter("myPw");
		String nick = request.getParameter("myNick");
		int infoOpen = Integer.parseInt(request.getParameter("myInfoOpen"));
		
		if(pwd.equals(""))
			pwd = "empty";
		
		if(nick.equals(""))
			nick = "empty";

		// 관심사 정렬
		String interests[] = request.getParameterValues("myInterest");
		String interest = "";
		
		for (int i = 0; i < interests.length; i++) {
			if (i == interest.length() - 1)
				interest += interests[i];
			else
				interest += interests[i] + ",";
		}
		
		//원래 정보 가져오기
		Member origin = memberService.searchById(id);
		
		//수정 정보 객체 만들기
		Member after = new Member(id,pwd,nick,interest,infoOpen,0);
		after.setMemberInterest(interest);
		after.setMemberImg(request.getParameter("mypageSrc"));
		
		//정보 수정
		memberService.updateMember(origin, after, request);

		return "redirect:mypage.do";

	}// end of update
	
	/** 그룹 메인 페이지 ( 관리자,회원 판단 / 그룹 정보 및 게시글 전달 ) */
	@RequestMapping("group.do")
	public String goGroup(Model model, HttpServletRequest request,@RequestParam("groupNum") String groupNum) {
		// 세션으로 부터 그룹의 관리자/회원/방문자 판단
		System.out.println("controller");
		
		HttpSession session = request.getSession();
		String id = String.valueOf(session.getAttribute("id")).trim();
		
		Map<String, String> map = new HashMap<>();
		map.put("groupNum", groupNum);
		map.put("memberId", id);
		String level = groupsService.getLevelForGroup(map);
		
		model.addAttribute("groupLevel",level);
		model.addAttribute("groupInfo", groupsService.searchGroupByNum(groupNum));
		model.addAttribute("groupBoardList",boardService.searchByGroupNum(groupNum));
		return "groupMain";
	}

}// end of StartController
