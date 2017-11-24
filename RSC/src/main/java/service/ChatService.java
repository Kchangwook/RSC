package service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import dao.ChatDAO;
import domain.Chat;
import domain.Member;
import ftp.FTPService;

@Transactional
/** Chat 데이터를 이용한 서비스 */
public class ChatService {

	/* 변수 */
	private ChatDAO chatDAO;
	private FTPService ftpService;
	
	/* 프로퍼티 */
	public void setChatDAO(ChatDAO chatDAO) {
		this.chatDAO = chatDAO;
	}
	public void FTPService(FTPService ftpService) {
		this.ftpService = ftpService;
	}
	
	/* 함수 */
	/** ID를 통해 채팅방 목록을 가져오는 함수 */
	public List<Chat> getMembers(String memberId){
		
		//아이디를 통해 채팅방 번호들 가져오기
		List<Chat> list = chatDAO.getNum(memberId);
		
		//아무것도 가져오지 못 했을 시에 null 값을 반환
		if(list == null)
			return list;
		
		//채팅방 번호에 일치하는 회원 정보들 가져오기
		for(Chat c:list) {
			c.setMembers(chatDAO.getMembers(c.getChatNum()));
			
			//내 정보 제거하기
			for(Member m:c.getMembers())
				if(m.getMemberId().equals(memberId)) {
					c.getMembers().remove(m);
					break;
				}
		}
		
		//리스트 반환
		return list;
		
	}//end of getMembers
	
	/** 채팅방을 만드는 함수 */
	public boolean makeChatRoom(List<String> memberIds) {
		
		boolean flag = true;
		
		for(int i = 0;i<memberIds.size();i++) {
			
			if(i == 0)
				flag = chatDAO.makeRoom(memberIds.get(0));
			else
				flag = chatDAO.addMember(memberIds.get(i));
			
			if(!flag)
				return false;
		}
		
		return flag;
		
	}//end of memberIds
	
}//end of ChatService
