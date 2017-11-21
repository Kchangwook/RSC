package service;

import org.springframework.transaction.annotation.Transactional;

import dao.FriendRequestDAO;
import domain.FriendRequest;

@Transactional
/** friendrequest 데이터를 이용한 서비스 */
public class FriendRequestService {

	/* 변수 */
	private FriendRequestDAO dao;
	
	/* 프로퍼티 */
	public void setFriendRequestDAO(FriendRequestDAO dao) {
		this.dao = dao;
	}
	
	/* 함수 */
	/** 친구 요청을 추가하는 함수 */
	public boolean addFriendRequest(FriendRequest f) {
		
		return dao.addFriendRequest(f);
		
	}//end of addFriendRequest
	
	/** 친구 요청이 존재하는지 확인하는 함수 */
	public boolean isFriendRequest(FriendRequest f) {
		
		return dao.isFriendRequest(f);
		
	}//end of isFriendRequest
	
	/** 친구 요청을 삭제하는 함수 */
	public boolean deleteByNum(int requestNum) {
		
		return dao.deleteByNum(requestNum);
		
	}//end of deleteByFriend
	
	/** 요청 번호로 request 찾기 */
	public FriendRequest searchByNum(int requestNum) {
		
		return dao.searchByNum(requestNum);
		
	}//end of searchByNum
	
}//end of FriendRequestService
