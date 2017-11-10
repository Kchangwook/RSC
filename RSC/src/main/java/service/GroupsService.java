package service;

import java.util.List;

import dao.GroupsDAO;
import domain.Groups;

public class GroupsService {
	
	private GroupsDAO groupsDAO;
	
	public void setGroupsDAO(GroupsDAO groupsDAO) {
		this.groupsDAO = groupsDAO;
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

}
