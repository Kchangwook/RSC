package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Groups;
import oracle.net.aso.g;

public class GroupsDAO extends SqlSessionDaoSupport{
	
	private SqlSession session;
	
	public List<Groups> searchAllGroups() {
		session = getSqlSession();
		return session.selectList("group.selectAll");
	}
	
	public boolean deleteGroupsByNum(int groupNum) {
		session = getSqlSession();
		return session.delete("group.deleteGroupByNum",groupNum)>0 ? true : false ;
	}
	
	// 그룹명으로 그룹 검색
	public List<Groups> searchGroupByName(String groupName) {
		session = getSqlSession();
		return session.selectList("group.selectGroupByName",groupName);
	}
}
