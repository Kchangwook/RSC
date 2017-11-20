package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.GroupAdmin;
import domain.GroupJoin;
import domain.GroupMember;
import domain.Groups;
import domain.Member;
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
	
	/** 일부 groupName을 통해 group 데이터를 가져오는 함수 */
	public List<Groups> searchByPartOfGroupName(String groupName) {
		
		List<Groups> list = null;
		
		session = getSqlSession();
		list = session.selectList("group.selectByPartOfGroupName", groupName);
		
		return list;
		
	}//end of searchByPartOfGroupName
	
	/** 그룹 관리자와 회원 리스트를 Map으로 반환 */
	public Map<String, List<Member>> searchGroupAdminMemberByGroupNum(String groupNum){
		session = getSqlSession();
		Map<String, List<Member>> map = new HashMap<>();
		map.put("groupAdmin", session.selectList("group.selectGroupAdminByGroupNum",groupNum));
		map.put("groupMember", session.selectList("group.selectGroupMemberByGroupNum",groupNum));
		return map;
	}
	
	// 그룹 번호로 그룹 검색
	public Groups searchGroupByNum(String groupNum) {
		session = getSqlSession();
		return session.selectOne("group.selectGroupByNum",groupNum);
	}
	
	/** 그룹 관리자 임명(group_admin 추가, group_member 삭제) */
	public boolean addGroupAdmin(GroupAdmin groupAdmin, GroupMember groupMember) {
		session = getSqlSession();
		boolean flag = true;
		flag = (session.insert("group.insertGroupAdmin",groupAdmin)*
				session.delete("group.deleteGroupMember",groupMember)) > 0 ? true : false ;
		return flag;
	}
	
	/** 그룹 회원 추방 (group_member 삭제) */
	public boolean deleteGroupMember(GroupMember groupMember) {
		session = getSqlSession();
		boolean flag = true;
		flag = session.delete("group.deleteGroupMember",groupMember) > 0 ? true : false ;
		return flag;
	}
	
	/** 그룹 가입 희망자 검색 */
	public List<Member> searchGroupJoinByGroupNum(String groupNum){
		session = getSqlSession();
		return session.selectList("group.selectGroupJoin",groupNum);
	}
	
	/** 그룹 가입 승인(group_member 추가, group_join 삭제)*/
	public boolean addGroupMember(GroupMember groupMember, GroupJoin groupJoin) {
		session = getSqlSession();
		boolean flag = true;
		flag = (session.insert("group.insertGroupMember",groupMember)*
				session.delete("group.deleteGroupJoin",groupJoin)) > 0 ? true : false ;
		return flag;
	}
	
	/** 그룹 가입 거절 */
	public boolean deleteGroupJoin(GroupJoin groupJoin) {
		session = getSqlSession();
		boolean flag = session.delete("group.deleteGroupJoin",groupJoin) > 0 ? true : false ;
		return flag;
	}
}
