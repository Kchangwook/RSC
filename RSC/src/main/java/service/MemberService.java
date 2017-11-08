package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import dao.AdminDAO;
import dao.MemberDAO;
import domain.Member;

/** member 데이터를 이용한 서비스 */
@Transactional
public class MemberService{

	/* 변수 */
	@Autowired private MemberDAO memberDAO;
	@Autowired private AdminDAO adminDAO;
	
	/* 프로퍼티 */
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	public void setAdminDAO(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}
	
	/* 함수 */
	/** 회원 아이디가 존재하는지 검색하는 서비스 */
	public boolean searchId(String id) {
		
		boolean flag = true;
		
		try {
			
			//입력받은 아이디가 member, admin에 존재하거나 master이면 안됨
			if(memberDAO.searchById(id) != null || adminDAO.searchById(id) != null || id.equals("master"))
				flag = false;
			
		}catch(Exception e) {
			
		}
		
		return flag;
		
	}//end of searchId
	
	/** 회원 정보를 추가하는 함수 */
	public boolean addMember(Member m) {
		
		boolean flag = true;
		
		//이미지가 존재하지 않으면 기본 이미지로 설정
		if(m.getMemberImg() == null) {
			
		}
		
		flag = memberDAO.addMember(m);
		
		return flag;
		
	}//end of addMember

}//end of MemberService