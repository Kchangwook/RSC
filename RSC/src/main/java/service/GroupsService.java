package service;

import java.util.List;
import java.util.Map;

import dao.GroupsDAO;
import domain.GroupAdmin;
import domain.GroupDelete;
import domain.GroupJoin;
import domain.GroupMember;
import domain.Groups;
import domain.Member;
import ftp.FTPService;

public class GroupsService {
	
	private GroupsDAO groupsDAO;
	private FTPService ftp;
	
	public void setGroupsDAO(GroupsDAO groupsDAO) {
		this.groupsDAO = groupsDAO;
	}
	
	public void setFTPService(FTPService ftp) {
		this.ftp = ftp;
	}
	
	// 모든 그룹 반환하는 메서드
	public List<Groups> searchAllGroups(){
		return groupsDAO.searchAllGroups();
	}
	
	// 그룹 삭제하는 메서드
	public boolean deleteGroupByNum(int groupNum) {
		return groupsDAO.deleteGroupsByNum(groupNum);
	}
	
	// 그룹명으로 그룹 검색하는 메서드
	public List<Groups> searchGroupByName(String groupName){
		return groupsDAO.searchGroupByName(groupName);
	}
	
	/** 일부 groupName을 통해 group 데이터를 가져오는 함수 */
	public List<Groups> searchByPartOfGroupName(String groupName) {
		
		List<Groups> list = null;
		
		list = groupsDAO.searchByPartOfGroupName(groupName);
		
		return list;
		
	}//end of searchByPartOfGroupName
	
	public Groups searchGroupByNum(String groupNum) {
		return groupsDAO.searchGroupByNum(groupNum);
	}
	
	/** 관리자 임명(group_admin 추가, group_member 삭제)*/
	public boolean addGroupAdmin(GroupAdmin groupAdmin, GroupMember groupMember) {
		return groupsDAO.addGroupAdmin(groupAdmin, groupMember);
	}
	
	/** 그룹 회원 추방 */
	public boolean deleteGroupMember(GroupMember groupMember) {
		return groupsDAO.deleteGroupMember(groupMember);
	}
	
	/** 그룹 가입 희망자 검색 */
	public List<Member> searchGroupJoinByGroupNum(String groupNum){
		return groupsDAO.searchGroupJoinByGroupNum(groupNum);
	}
	
	/** 그룹 가입 승인 */
	public boolean addGroupMember(GroupMember groupMember, GroupJoin groupJoin) {
		return groupsDAO.addGroupMember(groupMember, groupJoin);
	}
	
	/** 그룹 가입 거절 */
	public boolean deleteGroupJoin(GroupJoin groupJoin) {
		return groupsDAO.deleteGroupJoin(groupJoin);
	}
	
	/** 그룹 관리자/회원/방문자 판단 */
	public String getLevelForGroup(Map map) {
		return groupsDAO.getLevelForGroup(map);
	}
	
	/** 그룹 관리자를 리스트로 반환 */
	public List<Member> searchGroupAdminByGroupNum(String groupNum){
		return groupsDAO.searchGroupAdminByGroupNum(groupNum);
	}
	/** 그룹 회원을 리스트로 반환*/
	public List<Member> searchGroupMemberByGroupNum(String groupNum){
		return groupsDAO.searchGroupMemberByGroupNum(groupNum);
	}
	
	/** 그룹 가입 요청 추가 */
	public boolean addGroupJoin(GroupJoin groupJoin) {
		return groupsDAO.addGroupJoin(groupJoin);
	}
	
	/** 그룹 삭제 투표 추가 */
	public boolean addGroupDelete(GroupDelete groupDelete) {
		return groupsDAO.addGroupDelete(groupDelete);
	}
	
	/** 그룹 삭제 투표 찬성 update */
	public boolean updateGroupDeleteAgree(int groupNum) {
		return groupsDAO.updateGroupDeleteAgree(groupNum) ;
	}
	
	/** 그룹 삭제 투표 반대 update */
	public boolean updateGroupDeleteDisAgree(int groupNum) {
		return groupsDAO.updateGroupDeleteDisAgree(groupNum);
	}
	
	/** 그룹 삭제 투표 검색 */
	public GroupDelete searchGroupDeleteByGroupNum(int groupNum) {
		return groupsDAO.searchGroupDeleteByGroupNum(groupNum);
	}
	
	/** 그룹 삭제 투표 delete*/
	public boolean deleteGroupDelete(int groupNum) {
		return groupsDAO.deleteGroupDelete(groupNum) ;
	}
	
	/** id를 통해 알아온 groupNum 리스트로 groups 데이터 가져오는 함수 */
	public List<Groups> searchGroupbyId(String id) {
		
		List<Groups> list = groupsDAO.searchGroupbyId(id);
		
		try {
			// ftp에 파일 업로드
			for (Groups g : list) {
				if (!g.getGroupImg().equals("resources/img/profile.jpg")) {
					String fileName[] = g.getGroupImg().split("/");
					ftp.download("member", fileName[fileName.length - 1], "member");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}//end of searchGroupbyId

}
