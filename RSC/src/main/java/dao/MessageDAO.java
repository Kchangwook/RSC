package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Message;

public class MessageDAO  extends SqlSessionDaoSupport{
	
	/* 변수 */
	private SqlSession session;
	
	/** chatNum으로 모든 메시지 가져오기 */
	public List<Message> searchAllMessageByChatNum(int chatNum){
		session = getSqlSession();
		return session.selectList("message.selectAllMessageByChatNum",chatNum);
	}
	
	/** message table에 삽입 */
	public boolean addMessage(Message message) {
		session = getSqlSession();
		return session.insert("message.insertMessage", message) > 0 ? true : false ;
	}
	
	/** 같은 chatNum 중 가장 최근 메시지의 messageNum 가져오기 */
	public int searchRecentMessageNumByChatNum(int chatNum) {
		session = getSqlSession();
		return session.selectOne("message.selectRecentMessageNumByChatNum",chatNum);
	}
	
	/** 같은 chatNum 중 최근 message list 가져오기 */
	public List<Message> searchRecentMessage(Message message){
		session = getSqlSession();
		return session.selectList("message.selectRecentMessage",message);
	}

}
