package dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.FriendRequest;

/** DB내의 friendrequest 테이블과 데이터를 주고 받는 클래스 */
public class FriendRequestDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** FriendRequest를 추가하는 함수 */
	public boolean addFriendRequest(FriendRequest f) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("friendRequest.addRequest",f)>0?true:false;
		
		return flag;
		
	}//end of addFriendRequest
	
	/** FriendRequest가 존재하는지 확인하는 함수 */
	public boolean isFriendRequest(FriendRequest f) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.selectOne("friendRequest.searchRequest",f) != null?true:false;
		
		return flag;
		
	}//end of isFriendRequest
	
}//end of FriendRequestDAO
