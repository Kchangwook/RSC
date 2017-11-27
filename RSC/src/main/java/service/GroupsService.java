package service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
				if (!g.getGroupImg().equals("resources/img/group.jpg")) {
					String fileName[] = g.getGroupImg().split("/");
					ftp.download("group", fileName[fileName.length - 1], "group");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}//end of searchGroupbyId

	/** 존재하는 그룹 이름이 있는지 확인 */
	public boolean checkSameGroupName(String name) {
		Groups g = groupsDAO.checkSameGroupName(name);
		
		// 같은 그룹명이 없을 시
		if (g == null)
			return false;
		// 같은 그룹명이 있을 시
		else
			return true;
	}
	
	/** 그룹 생성 */
	public boolean addGroup(Groups g, MultipartHttpServletRequest request) {
		
		boolean flag = true;
		
		g = this.uploadProfile(request, g, "groupImg");
		
		// 이미지가 비어있지 않다면
		if (!g.getGroupImg().equals("resources/img/group.jpg")) {
			
			System.out.println("imgName: "+g.getGroupImg());
			
			String fileName[] = g.getGroupImg().split("/");

			// ftp에 파일 업로드
			int result = ftp.upload("group", fileName[fileName.length - 1]);
			
			System.out.println(result);
		}

		// DB에 데이터 추가
		flag = groupsDAO.addGroup(g);
		
		return flag;
	}//end of addGroup
	
	/** 그룹 생성 후 관리자 지정 */
	public boolean addGroupAdminFirst(Groups g, String id) {
		boolean flag = true;
		
		Groups newg = groupsDAO.checkSameGroupName(g.getGroupName());
		
		flag = groupsDAO.addGroupAdminFirst(new GroupAdmin(id, newg.getGroupNum()));
		
		return flag;
	}
	
	/** 그룹 이미지 업로드 */
	private Groups uploadProfile(MultipartHttpServletRequest request, Groups g, String mode) {
		MultipartFile file = request.getFile(mode);
		
		try {
			if (file.isEmpty()) { // 파일 유무 검사
			} else if (file.getSize() > (5 * 1024 * 1024)) {
				System.out.println("## 용량이 너무 큽니다. \n 5메가 이하로 해주세요.");
			}

			file.transferTo(new File("C:/Users/kosta/git/RSC/RSC/src/main/webapp/info/group/" + g.getGroupNum() + "_"
					+ file.getOriginalFilename()));

			if (!file.getOriginalFilename().equals(""))
				g.setGroupImg("info/group/" + g.getGroupName() + "_" + file.getOriginalFilename());

		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}

		return g;
		
	}// end of uploadProfile
	
	/** 그룹에 관리자 몇 명인지 확인 */
	public int checkAdminCount(int groupNum) {
		int count = groupsDAO.checkAdminCount(groupNum);
		
		return count;
	}//end of checkAdminCount
	
	/** 그룹 정보 수정 */
	public boolean updateGroup(Groups originGroup, Groups updatedGroup, MultipartHttpServletRequest request) {
		// 이름 수정
		if( !originGroup.getGroupName().equals( updatedGroup.getGroupName() )) {
			originGroup.setGroupName( updatedGroup.getGroupName() );
		}
		// 정보 수정
		if(!originGroup.getGroupInfo().equals( updatedGroup.getGroupInfo() )) {
			originGroup.setGroupInfo( updatedGroup.getGroupInfo() );
		}
		// 정보 공개 수정
		if(originGroup.getGroupInfoOpen() != updatedGroup.getGroupInfoOpen() ) {
			originGroup.setGroupInfoOpen( updatedGroup.getGroupInfoOpen() );
		}
		// 관심사 수정
		if(!originGroup.getGroupInterest().equals( updatedGroup.getGroupInterest() )) {
			originGroup.setGroupInterest( updatedGroup.getGroupInterest() );
		}
		
		updatedGroup = this.uploadProfile(request, updatedGroup, "groupImg");
		
		if (updatedGroup.getGroupImg() != null) {

			String fileName[] = updatedGroup.getGroupImg().split("/");

			// ftp에 파일 업로드
			ftp.upload("group", fileName[fileName.length - 1]);

			originGroup.setGroupImg(updatedGroup.getGroupImg());
		}
		
		
		return this.groupsDAO.updateGroup(originGroup);
	}
}
