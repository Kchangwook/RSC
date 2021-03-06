package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Member;

/** DB내의 member 테이블과 데이터를 주고 받는 클래스 */
public class MemberDAO extends SqlSessionDaoSupport {

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** 데이터를 추가하는 함수 */
	public boolean addMember(Member m) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("member.add",m)>0?true:false;
		
		return flag;
		
	}//end of addMember
	
	/** 아이디를 통해 데이터를 가져오는 함수 */
	public Member searchById(String id) {
		
		Member m = null;
		
		session = getSqlSession();
		m = session.selectOne("member.selectById",id);
		
		return m;
		
	}//end of searchMemberById
	
	/** 모든 데이터를 가져오는 함수 */
	public List<Member> searchAll(){
		
		List<Member> list = null;
		
		session = getSqlSession();
		list = session.selectList("member.selectAll");
		
		return list;
		
	}//end of searchAll
	
	/** 테이블 내의 모든 데이터 삭제 */
	public boolean deleteAll() {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("member.deleteAll")>0?true:false;
		
		return flag;
		
	}//end of deleteAll
	
	/** 테이블 내의 데이터 수 가져오기 */
	public int getCount() {
		
		int count = 0;
		
		session = getSqlSession();
		count = session.selectOne("member.getCount");
		
		return count;
		
	}//end of getCount;
	
	/** 닉네임으로 데이터가져오기 */
	public Member searchByNick(String nick) {
		
		Member m = null;
		
		session = getSqlSession();
		m = session.selectOne("member.selectByNick",nick);
		
		return m;
		
	}//end of nick
	
	/** 로그인 정보를 수정하기 */
	public boolean updateLoginInfo(String id) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.update("member.updateLoginInfo",id)>0?true:false;
		
		return flag;
		
	}//end of updateLoginInfo
	
	/** 닉네임 또는 아이디로 멤버 리스트 반환*/
	public List<Member> searchByIdName(String memberIdName){
		session = getSqlSession();
		return session.selectList("member.selectByIdName",memberIdName);
	}
	
	/** 아이디를 통해 닉네임 반환 */
	public String getNick(String id) {
		
		String name = "";
		
		name = session.selectOne("member.selectNick",id);
		
		return name;
		
	}//end of getNick
	
	/** 일부 membrNick을 통해 member 데이터를 가져오는 함수 */
	public List<Member> searchByPartOfMemberNick(String memberNick) {
		
		List<Member> list = null;
		
		session = getSqlSession();
		list = session.selectList("member.selectByPartOfMemberNick", memberNick);
		
		return list;
		
	}//end of searchByPartOfMemberNick
	
	/** ID로 member 삭제 */
	public boolean deleteMemberByID(String memberId) {
		session = getSqlSession();
		return session.delete("member.deleteById", memberId)>0 ? true : false;
	}
	
	/** member logout정보 수정 */
	public boolean updateLogout(String memberId) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.update("member.updateLogout", memberId)>0?true:false;
		
		return flag;
		
	}//end of updateLogout

	/** mypage에서 member 정보 수정 함수 */
	public boolean updateMypageInfo(Member member) {
		
		boolean flag = true;
		
		session = getSqlSession();
		
		flag = session.update("member.updateMypageInfo", member)>0?true:false;
		return flag;
		
	}//end of updateMypageInfo
	
	/** 현재 로그인 중인 친구 찾기 */
	public List<Member> searchPresentLogin(String memberId){
		
		List<Member> list = null;
		
		session = getSqlSession();
		list = session.selectList("member.searchPresentLogin",memberId);
		
		return list;
		
	}//end of searchPresentLogin
	
	/** chatNum으로 채팅방 멤버 검색 */
	public List<Member> searchChatMemberByChatNum(int chatNum){
		List<Member> list = null;
		session = getSqlSession();
		list = session.selectList("member.selectChatMemberByChatNum",chatNum);
		return list;
	}
	
	/** 전체 친구의 회원정보 검색 */
	public List<Member> searchFriendMemberById(String memberId){
		session = getSqlSession();
		List<Member> list = session.selectList("member.selectFriendMemberById",memberId);
		return list;
	}
	
	/** 오랫동안 로그인하지 않은 회원 삭제 */
	public void deleteOldMember() {
		session = getSqlSession();
		session.delete("member.deleteOldMember");
	}
	
}//end of MemberDAO
