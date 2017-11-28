package service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

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

		m = this.uploadProfile(request, m, "memberImg");

		// 이미지가 비어있지 않다면
		if (!m.getMemberImg().equals("resources/img/profile.jpg")) {
			String fileName[] = m.getMemberImg().split("/");

			// ftp에 파일 업로드
			ftp.upload("member", fileName[fileName.length - 1]);
		}

		// DB에 데이터 추가
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
	private Member uploadProfile(MultipartHttpServletRequest request, Member m, String mode) {

		MultipartFile file = request.getFile(mode);

		System.out.println("fileName: " + file.getOriginalFilename());

		try {
			if (file.isEmpty()) { // 파일 유무 검사
			} else if (file.getSize() > (5 * 1024 * 1024)) {
				System.out.println("## 용량이 너무 큽니다. \n 5메가 이하로 해주세요.");
			}

			file.transferTo(new File("C:/Users/kosta/git/RSC/RSC/src/main/webapp/info/member/" + m.getMemberId() + "_"
					+ file.getOriginalFilename()));

			if (!file.getOriginalFilename().equals(""))
				m.setMemberImg("info/member/" + m.getMemberId() + "_" + file.getOriginalFilename());

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

	}// end of searchByPartOfMemberNick

	/** ID로 member 삭제 */
	public boolean deleteMemberByID(String memberId) {
		return memberDAO.deleteMemberByID(memberId);
	}

	/** 아이디를 통해 데이터를 가져오는 함수 */
	public Member searchById(String id) {

		Member m = null;

		m = memberDAO.searchById(id);

		return m;

	}// end of searchMemberById

	/** mypage에서 member 정보 수정 함수 */
	public boolean updateMember(Member origin, Member after, MultipartHttpServletRequest request) {
		HttpSession session = request.getSession();
		
		// 비밀번호 변경
		if (!after.getMemberPw().equals("empty"))
			origin.setMemberPw(after.getMemberPw());

		// 닉네임 변경
		if (!after.getMemberNick().equals("empty")) {
			origin.setMemberNick(after.getMemberNick());
			session.setAttribute("nick", after.getMemberNick());
		}
		// 정보 공개 여부 변경
		if (origin.getMemberInfoOpen() != after.getMemberInfoOpen())
			origin.setMemberInfoOpen(after.getMemberInfoOpen());

		// 관심사 변경
		if (!origin.getMemberInterest().equals(after.getMemberInterest()))
			origin.setMemberInterest(after.getMemberInterest());

		// 프로필 사진 변경
		after = this.uploadProfile(request, after, "mypageImg");

		if (after.getMemberImg() != null) {

			String fileName[] = after.getMemberImg().split("/");

			// ftp에 파일 업로드
			ftp.upload("member", fileName[fileName.length - 1]);

			origin.setMemberImg(after.getMemberImg());
			session.setAttribute("imgSrc", after.getMemberImg());
		}

		return this.memberDAO.updateMypageInfo(origin);

	}// end of updateMember

	/** member 로그아웃 함수 */
	public boolean logoutMember(String id) {

		return memberDAO.updateLogout(id);

	}// end of logoutMember

	/** 관리자 계정 생성 */
	public boolean addAdmin(Admin admin) {
		return adminDAO.addAdmin(admin);
	}
	
	/** 현재 접속중인 친구 찾기 */
	public List<Member> searchPresentLogin(String memberId){
		
		return memberDAO.searchPresentLogin(memberId);
		
	}//end of searchPresentLogin
	
	
	/** chatNum으로 채팅방 멤버 검색 */
	public List<Member> searchChatMemberByChatNum(int chatNum){
		
		return memberDAO.searchChatMemberByChatNum(chatNum);
		
	}
	
	/** 전체 친구의 회원정보 검색 */
	public List<Member> searchFriendMemberById(String memberId){
		return memberDAO.searchFriendMemberById(memberId);
	}

}// end of MemberService
