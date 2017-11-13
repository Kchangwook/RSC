package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;

import dao.AdminDAO;
import dao.MemberDAO;
import domain.Admin;
import domain.Member;

/** member 데이터를 이용한 서비스 */
@Transactional
public class MemberService{
	
	/* 변수 */
	private MemberDAO memberDAO;
	private AdminDAO adminDAO;
	
	/* 프로퍼티 */
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	public void setAdminDAO(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}
	
	/* 함수 */
	/** 회원 아이디가 존재하는지 검색하는 서비스 */
	public boolean isNotHavingId(String id) {
		
		boolean flag = true;
		
		try {
			
			//입력받은 아이디에 대한 member, admin에 존재하거나 master이면 안됨
			if(memberDAO.searchById(id) == null && adminDAO.searchById(id) == null && !id.equals("master"))
				flag = false;
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return flag;
		
	}//end of searchId
	
	/** 중복된 닉네임이 있는지 확인하는 함수 */
	public boolean checkSameNick(String nick) {

		Member m = memberDAO.searchByNick(nick);
		
		//같은 닉네임이 없을 시
		if(m == null)
			return false;
		//같은 닉네임이 있을 시
		else
			return true;
		
	}//end of checkSameNick
	
	/** 회원 정보를 추가하는 함수 */
	public boolean addMember(Member m,HttpServletRequest request) {
		
		boolean flag = true;

			if(m.getMemberInterest() == null)
				m.setMemberInterest("");
			
			//이미지가 존재하지 않으면 기본 이미지로 설정
			if(m.getMemberImg() == "") 
				m.setMemberImg("/resources/img/profile.jpg");
			
			flag = memberDAO.addMember(m);

		return flag;
		
	}//end of addMember
	
	/** 회원이 존재하는지 확인하는 함수 */
	public int checkLogin(String id, String pwd) {
		
		int flag = 0;
		
		Member m = memberDAO.searchById(id);
		Admin a = adminDAO.searchById(id);
		
		// master계정인 경우: 1
		if(id.equals("master") && pwd.equals("1234"))
			flag = 1;
		// admin 계정인 경우: 2
		else if(a != null && a.getAdminPw().equals(pwd))
			flag = 2;
		// member 계정인 경우: 3
		else if( m != null && m.getMemberPw().equals(pwd))
			flag = 3;
			
		return flag;
		
	}//end of checkLogin
	
	/** 로그인 성공시 회원 정보를 수정하는 함수 */
	public boolean updateLoginInfo(String id) {
		
		return memberDAO.updateLoginInfo(id);
		
	}//end of updateLoginInfo
	
	/** 멤버 닉네임 또는 아이디로 리스트 반환 */
	public List<Member> searchByIdName(String memberIdName){
		return memberDAO.searchByIdName(memberIdName);
	}
	
	/** 모든 멤버 리스트 반환 */
	public List<Member> searchAllMembers(){
		return memberDAO.searchAll();
	}

}//end of MemberService
