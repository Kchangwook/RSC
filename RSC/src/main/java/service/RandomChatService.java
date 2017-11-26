package service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import dao.GroupRandomChatDAO;
import dao.OneRandomChatDAO;
import domain.GroupRandomChat;
import domain.OneRandomChat;

@Transactional
/** RandomChat 데이터를 이용한 서비스 */
public class RandomChatService {

	/* 변수 */
	private OneRandomChatDAO oneRandomChatDAO;
	private GroupRandomChatDAO groupRandomChatDAO;
	
	/* 프로퍼티 */
	public void setOneRandomChatDAO(OneRandomChatDAO oneRandomChatDAO) {
		this.oneRandomChatDAO = oneRandomChatDAO;
	}
	public void setGroupRandomChatDAO(GroupRandomChatDAO groupRandomChatDAO) {
		this.groupRandomChatDAO = groupRandomChatDAO;
	}
	
	/* 함수 */
	/** 1:1 채팅 대기열에 추가하는 함수 */
	public boolean addOneRandomChat(String memberId) {
		
		return oneRandomChatDAO.addOneRandomChat(memberId);
		
	}//end of addOneRandomChat

	/** 1:1채팅 대기열에서 삭제하는 함수 */
	public boolean deleteOneRandomChat(int num) {
		
		return oneRandomChatDAO.deleteOneRandomChat(num);
		
	}//end of deleteOneRandomChat
	
	/** 1:1 채팅 대기열을 가져오는 함수 */
	public List<OneRandomChat> getOne(){
		
		return oneRandomChatDAO.getAll();
		
	}//end of getOne
	
	/** 그룹 채팅 대기열에 추가하는 함수 */
	public boolean addGroupRandomChat(String memberId) {
		
		return groupRandomChatDAO.addgroupRandomChat(memberId);
		
	}//end of addOneRandomChat

	/** 1:1채팅 대기열에서 삭제하는 함수 */
	public boolean deleteGroupRandomChat(int num) {
		
		return groupRandomChatDAO.deletegroupRandomChat(num);
		
	}//end of deleteOneRandomChat
	
	/** 1:1 채팅 대기열을 가져오는 함수 */
	public List<GroupRandomChat> getGroup(){
		
		return groupRandomChatDAO.getAll();
		
	}//end of getOne
	
}//end of RandomChatService
