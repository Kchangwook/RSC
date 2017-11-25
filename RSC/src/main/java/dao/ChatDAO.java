package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Chat;
import domain.Member;

/** DB내의 Chat 테이블과 데이터를 주고 받는 클래스 */
public class ChatDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** 채팅 번호를 통해 채팅 멤버들을 가져오는 함수 */
	public List<Member> getMembers(int chatNum){
		
		List<Member> list = null;
		
		session = getSqlSession();
		list = session.selectList("chat.getMemberByNum",chatNum);
		
		return list;
		
	}//end of getMembers
	
	/** 회원이 속한 채팅방 번호를 가져오는 함수 */
	public List<Chat> getNum(String memberId){
		
		List<Chat> list = null;
		
		session = getSqlSession();
		list = session.selectList("chat.getChatNum",memberId);
		
		return list;
		
	}//end of getNum
	
	/** 채팅방을 만드는 함수 */
	public boolean makeRoom(String memberId) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("chat.makeChatRoom",memberId)>0?true:false;
		
		return flag;
		
	}//end of memberId
	
	/** 채팅 맴버를 초대하는 함수 */
	public boolean addMember(String memberId) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("chat.addChatMember",memberId)>0?true:false;
		
		return flag;
		
	}//end of addMember
	
	
	/** 채팅방 나가기 */
	public boolean deleteChat(Chat chat) {
		boolean flag = true;
		session = getSqlSession();
		flag = session.delete("chat.deleteChat",chat) > 0 ? true : false ;
		
		return flag;
	}
	
	/** 현재 채팅방에 추가로 친구 초대하기 */
	public boolean addChatMemberInvited(Chat chat) {
		boolean flag = true;
		session = getSqlSession();
		flag = session.insert("chat.addChatMemberInvited",chat) > 0 ? true : false ;
		return flag;
	}
	
}//end of ChatDAO
