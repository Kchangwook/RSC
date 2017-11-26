package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.OneRandomChat;

/** DB내의 oneRandomChat 테이블과 데이터를 주고 받는 클래스 */
public class OneRandomChatDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** OneRandomChat 레코드 추가 */
	public boolean addOneRandomChat(String memberId) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("oneRandomChat.addOneRandomChat",memberId)>0?true:false;
		
		return flag;
		
	}//end of addOneRandomChat
	
	/** OneRandomChat 레코드 삭제 */
	public boolean deleteOneRandomChat(int num) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("oneRandomChat.deleteOneRandomChat",num)>0?true:false;
		
		return flag;
		
	}//end of deleteOneRandomChat
	
	/** OneRandomChat 리스트 가져오기 */
	public List<OneRandomChat> getAll(){
		
		List<OneRandomChat> list = null;
		
		session = getSqlSession();
		list = session.selectList("oneRandomChat.getAll");
		
		return list;
		
	}//end of getAll
	
}//end of OneRandomChatDAO
