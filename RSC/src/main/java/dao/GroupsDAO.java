package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.GroupAdmin;
import domain.GroupDelete;
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
	
	/** 그룹 관리자/회원/방문자 판단 */
	public String getLevelForGroup(Map map) {
		session = getSqlSession();
		String level = "visitor";
		
		if(session.selectOne("group.selectGroupAdminByGroupNumMemberId",map) != null ) {
			level = "admin";
		} else if (session.selectOne("group.selectGroupMemberByGroupNumMemberId", map) != null ) {
			level = "member";
		} 
		return level;
	}
	
	/** 그룹 관리자를 리스트로 반환 */
	public List<Member> searchGroupAdminByGroupNum(String groupNum){
		session = getSqlSession();
		List<Member> list = session.selectList("group.selectGroupAdminByGroupNum",groupNum);
		return list;
	}
	/** 그룹 회원을 리스트로 반환*/
	public List<Member> searchGroupMemberByGroupNum(String groupNum){
		session = getSqlSession();
		List<Member> list = session.selectList("group.selectGroupMemberByGroupNum",groupNum);
		return list;
	}
	
	/** 그룹 가입 추가 */
	public boolean addGroupJoin(GroupJoin groupJoin) {
		session = getSqlSession();
		return session.insert("group.insertGroupJoin",groupJoin) > 0 ? true : false ;
	}
	
	/** 그룹 삭제 투표 추가 (group_delete table) */
	public boolean addGroupDelete(GroupDelete groupDelete) {
		session = getSqlSession();
		return session.insert("group.insertGroupDelete",groupDelete) > 0 ? true : false ;
	}
	
	/** 그룹 삭제 투표 찬성 update */
	public boolean updateGroupDeleteAgree(int groupNum) {
		session = getSqlSession();
		return session.update("group.updateGroupDeleteAgree",groupNum) > 0 ? true : false ;
	}
	
	/** 그룹 삭제 투표 반대 update */
	public boolean updateGroupDeleteDisAgree(int groupNum) {
		session = getSqlSession();
		return session.update("group.updateGroupDeleteDisAgree",groupNum) > 0 ? true : false ;
	}
	
	/** 그룹 삭제 투표 검색 */
	public GroupDelete searchGroupDeleteByGroupNum(int groupNum) {
		session = getSqlSession();
		return session.selectOne("group.selectGroupDeleteByGroupNum",groupNum);
	}
	
	/** 그룹 삭제 투표 delete*/
	public boolean deleteGroupDelete(int groupNum) {
		session = getSqlSession();
		return session.update("group.deleteGroupDelete",groupNum) > 0 ? true : false ;
	}
	
	/** id를 통해 알아온 groupNum 리스트로 groups 데이터 가져오는 함수 */
	public List<Groups> searchGroupbyId(String id) {
		
		session = getSqlSession();
		
		List<Groups> list = session.selectList("group.searchAdminGroupbyId", id); // 관리자인 그룹
		List<Groups> listMember = session.selectList("group.searchMemberGroupbyId", id); // 회원인 그룹
		
		for (int i = 0; i < listMember.size() ; i++) {
			list.add(listMember.get(i));
		}
		
		return list;
		
	}//end of searchGroupbyId
	
	/** 존재하는 그룹 이름이 있는지 확인 */
	public Groups checkSameGroupName(String groupName) {
		session = getSqlSession();
		
		return session.selectOne("group.checkSameGroupName", groupName);
	}// end of checkSameGroupName

	/** 그룹 생성 */
	public boolean addGroup(Groups g) {
		
		boolean flag = true;

		session = getSqlSession();
		flag = session.insert("group.addGroup", g) > 0 ? true : false;
		
		return flag;
	}//end of addGroup
	
	/** 그룹 생성 후 관리자 지정 */
	public boolean addGroupAdminFirst(GroupAdmin ga) {

		boolean flag = true;

		session = getSqlSession();
		flag = session.insert("group.insertGroupAdmin", ga) > 0 ? true : false;
		
		return flag;
	}//end of addGroupAdminFirst

	/** 그룹 관리자 임명(group_admin 추가, group_member 삭제) */
	public boolean addGroupAdmin(GroupAdmin groupAdmin) {
		session = getSqlSession();
		boolean flag = true;
		flag = session.insert("group.insertGroupAdmin",groupAdmin) > 0 ? true : false ;
		
		return flag;
	}
	
	/** 그룹에 관리자 몇 명인지 확인 */
	public int checkAdminCount(int groupNum) {
		session = getSqlSession();
		int count = 0;
		count=session.selectOne("group.checkAdminCount", groupNum);
		
		return count;
	}//end of checkAdminCount
	
	/** 그룹 정보 수정 */
	public boolean updateGroup(Groups group) {
		session = getSqlSession();
		return session.update("group.updateGroup",group) > 0 ? true : false ;
	}
}
