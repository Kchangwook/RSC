package service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import dao.MemberDAO;
import domain.Member;

/** member 데이터를 이용한 서비스 */
@Transactional
public class MemberService{

	/* 변수 */
	private MemberDAO memberDAO;
	
	/* 프로퍼티 */
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	
	/* 함수 */
	
	/** 회원 데이터를 추가하는 함수 */
	public void addMember(Member m) {
		
		memberDAO.addMember(m);
		
	}//end of addMember

	/** 회원 데이터를 모두 삭제하는 함수 */
	public void deleteAll() {
		
		memberDAO.deleteAll();
		
	}//end of deleteAll

	/** 총 회원수를 가져오는 함수 */
	public int getCount() {

		return memberDAO.getCount();
		
	}//end of getCount

	/** 모든 데이터를 가져오는 함수 */
	public List<Member> searchAll() {

		return memberDAO.searchAll();
		
	}//end of searchAll

}
