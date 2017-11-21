package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Friend;

/** DB내의 friend 테이블과 데이터를 주고 받는 클래스 */
public class FriendDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** 친구 정보와 목록을 가져오는 함수 */
	public List<Friend> getList(String id){
		
		List<Friend> list = null;
		
		session = getSqlSession();
		list = session.selectList("friend.selectFriends",id);
		
		return list;
		
	}//end of getList
	
	/** 친구 정보를 삭제하는 함수 */
	public boolean deleteFriend(Friend f) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("friend.deleteById",f)>0?true:false;
		
		return flag;
		
	}//end of deleteFriend
	
	/** 친구 존재 여부를 찾는 함수 */
	public boolean isFriend(Friend f) {
	
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.selectOne("friend.searchFriends",f) != null?true:false;
		
		return flag;
		
	}//end of isFriend
	
}//end of FriendDAO
