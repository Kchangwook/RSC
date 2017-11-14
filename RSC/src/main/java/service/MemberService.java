package service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.AdminDAO;
import dao.MemberDAO;
import domain.Admin;
import domain.Member;
import ftp.FTPService;

/** member 데이터를 이용한 서비스 */
@Transactional
public class MemberService {

	/* 변수 */
	private MemberDAO memberDAO;
	private AdminDAO adminDAO;
	private FTPService ftp;

	/* 프로퍼티 */
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}

	public void setAdminDAO(AdminDAO adminDAO) {
		this.adminDAO = adminDAO;
	}
	public void setFTPService(FTPService ftp) {
		this.ftp = ftp;
	}

	/* 함수 */
	/** 회원 아이디가 존재하는지 검색하는 서비스 */
	public boolean isNotHavingId(String id) {

		boolean flag = true;

		try {

			// 입력받은 아이디에 대한 member, admin에 존재하거나 master이면 안됨
			if (memberDAO.searchById(id) == null && adminDAO.searchById(id) == null && !id.equals("master"))
				flag = false;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;

	}// end of searchId

	/** 중복된 닉네임이 있는지 확인하는 함수 */
	public boolean checkSameNick(String nick) {

		Member m = memberDAO.searchByNick(nick);

		// 같은 닉네임이 없을 시
		if (m == null)
			return false;
		// 같은 닉네임이 있을 시
		else
			return true;

	}// end of checkSameNick

	/** 회원 정보를 추가하는 함수 */
	public boolean addMember(Member m, MultipartHttpServletRequest request) {

		boolean flag = true;
		
		// 이미지가 존재하지 않으면 기본 이미지로 설정
		if (m.getMemberImg() == "")
			m.setMemberImg("resources/img/profile.jpg");
		
		//내 컴퓨터 내로 이미지 업로드
		m = this.uploadProfile(request, m);
		
		String fileName[] = m.getMemberImg().split("/");

		//ftp에 파일 업로드
		ftp.upload("member", fileName[fileName.length-1]);

		//DB에 데이터 추가
		flag = memberDAO.addMember(m);
				
		return flag;

	}// end of addMember

	/** 회원이 존재하는지 확인하는 함수 */
	public int checkLogin(String id, String pwd) {

		int flag = 0;

		Member m = memberDAO.searchById(id);
		Admin a = adminDAO.searchById(id);

		// master계정인 경우: 1
		if (id.equals("master") && pwd.equals("1234"))
			flag = 1;
		// admin 계정인 경우: 2
		else if (a != null && a.getAdminPw().equals(pwd))
			flag = 2;
		// member 계정인 경우: 3
		else if (m != null && m.getMemberPw().equals(pwd))
			flag = 3;

		return flag;

	}// end of checkLogin

	/** 로그인 성공시 회원 정보를 수정하는 함수 */
	public boolean updateLoginInfo(String id) {

		return memberDAO.updateLoginInfo(id);

	}// end of updateLoginInfo

	/** 멤버 닉네임 또는 아이디로 리스트 반환 */
	public List<Member> searchByIdName(String memberIdName) {
		return memberDAO.searchByIdName(memberIdName);
	}

	/** 모든 멤버 리스트 반환 */
	public List<Member> searchAllMembers() {
		return memberDAO.searchAll();
	}

	/** 회원 이미지 업로드 */
	private Member uploadProfile(MultipartHttpServletRequest request, Member m) {
		
		MultipartFile file = request.getFile("memberImg");

		try {
			if (file.isEmpty()) { // 파일 유무 검사
			} else if (file.getSize() > (5 * 1024 * 1024)) {
				System.out.println("## 용량이 너무 큽니다. \n 5메가 이하로 해주세요.");
			}

			file.transferTo(new File("C:/Users/kchan/git/RSC/RSC/src/main/webapp/info/member/" + m.getMemberId()+"_"+file.getOriginalFilename()));
			m.setMemberImg("info/member/"+m.getMemberId()+"_"+file.getOriginalFilename());
			
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
		
		return m;

	}// end of uploadProfile

	/** 닉네임 가져오기 */
	public String getNick(String id) {

		return memberDAO.getNick(id);

	}// end of getNick
	
	/** 일부 membrNick을 통해 member 데이터를 가져오는 함수 */
	public List<Member> searchByPartOfMemberNick(String memberNick) {
		
		List<Member> list = null;
		
		list = memberDAO.searchByPartOfMemberNick(memberNick);
		
		return list;
		
	}//end of searchByPartOfMemberNick
	
	/** ID로 member 삭제 */
	public boolean deleteMemberByID(String memberId) {
		return memberDAO.deleteMemberByID(memberId);
	}
	
	/** 아이디를 통해 데이터를 가져오는 함수 */
	public Member searchById(String id) {
		
		Member m = null;
		
		m = memberDAO.searchById(id);
		
		return m;
		
	}//end of searchMemberById
	
	/** member 정보 수정 함수 */
	public boolean updateMember(Member member, HttpServletRequest request) {
		
		List<Member> list = null;
		
		System.out.println("정보수정");
		
		//return memberDAO.updateLoginInfo(id);
		return true;
		
	}//end of updateMember

}// end of MemberService
