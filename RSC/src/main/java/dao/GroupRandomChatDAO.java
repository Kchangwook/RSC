package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.GroupRandomChat;

public class GroupRandomChatDAO extends SqlSessionDaoSupport {

	/* 변수 */
	private SqlSession session;

	/* 함수 */
	/** groupRandomChat 레코드 추가 */
	public boolean addgroupRandomChat(String memberId) {

		boolean flag = true;

		session = getSqlSession();
		flag = session.insert("groupRandomChat.addgroupRandomChat", memberId) > 0 ? true : false;

		return flag;

	}// end of addgroupRandomChat

	/** groupRandomChat 레코드 삭제 */
	public boolean deletegroupRandomChat(int num) {

		boolean flag = true;

		session = getSqlSession();
		flag = session.delete("groupRandomChat.deletegroupRandomChat", num) > 0 ? true : false;

		return flag;

	}// end of deletegroupRandomChat

	/** groupRandomChat 리스트 가져오기 */
	public List<GroupRandomChat> getAll() {

		List<GroupRandomChat> list = null;

		session = getSqlSession();
		list = session.selectList("groupRandomChat.getAll");

		return list;
	}// end of getAll

}// end of GroupRandomChatDAO
