package service;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import dao.MessageDAO;
import domain.Message;

public class MessageService {
	
	/* 변수 */
	private MessageDAO messageDAO;
	
	/* 프로퍼티 */
	public void setMessageDAO(MessageDAO dao) {
		this.messageDAO = dao;
	}
	
	/** chatNum으로 모든 메시지 가져오기 */
	public List<Message> searchAllMessageByChatNum(int chatNum){
		return messageDAO.searchAllMessageByChatNum(chatNum);
	}

	/** message table에 삽입 */
	public boolean addMessage(Message message) {
		return messageDAO.addMessage(message);
	}
	
	/** 같은 chatNum 중 가장 최근 메시지의 messageNum 가져오기 */
	public int searchRecentMessageNumByChatNum(int chatNum) {
		return messageDAO.searchRecentMessageNumByChatNum(chatNum);
	}
	
	/** 같은 chatNum 중 최근 message list 가져오기 */
	public List<Message> searchRecentMessage(Message message){
		return messageDAO.searchRecentMessage(message);
	}
}
