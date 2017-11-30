package service;

import java.util.List;


import dao.NoticeDAO;
import domain.Member;
import domain.Notice;

/** notice 데이터를 이용한 서비스 */
public class NoticeService {
	
	/* 변수 */
	private NoticeDAO noticeDAO;
	
	/* 프로퍼티 */
	public void setNoticeDAO(NoticeDAO noticeDAO) {
		this.noticeDAO = noticeDAO;
	}
	
	/* 함수 */
	/** notice 추가하는 함수 */
	public boolean addNotice(Notice n) {
		
		boolean flag = true;
		
		flag = noticeDAO.addNotice(n);
		
		return flag;
		
	}//end of addNotice
	
	/** notice 추가하는 함수 */
	public boolean addNotice1(Notice n) {
		
		boolean flag = true;
		
		flag = noticeDAO.addNotice1(n);
		
		return flag;
		
	}//end of addNotice1
	
	/** 아이디를 통해 notice 데이터를 가져오는 함수 */
	public List<Notice> searchById(String id) {
		
		List<Notice> list = null;
		
		list = noticeDAO.searchById(id);
		
		return list;
		
	}//end of searchNoticeById
	
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 */
	public boolean deleteByNoticeNum(int noticeNum) {
		
		boolean flag = true;
		
		flag = noticeDAO.deleteByNoticeNum(noticeNum);
		
		return flag;
		
	}//end of deleteByNoticeNum
	
	/** notice 데이터 추가 (관리자 공지) */
	public boolean addFromAdmin(Notice n, List<Member> list) {
		boolean flag = true;
		for (int i = 0; i < list.size(); i++) {
			n.setMemberId(list.get(i).getMemberId());
			flag = noticeDAO.addFromAdmin(n);
		}
		return flag;
	}
	
	/** FriendRequest관련 notice 추가 */
	public boolean addFriendRequest(Notice n) {
		
		return noticeDAO.addFriendRequest(n);
		
	}//end of addFriendRequest
	
	/** noticeTarget(group_num)을 통한 notice 테이블 내의 데이터 삭제 (그룹 삭제 투표 취소) */
	public boolean deleteGroupNoticeByNoticeTarget(int noticeTarget) {
		return noticeDAO.deleteGroupNoticeByNoticeTarget(noticeTarget);
	}
	
	/** notice 개수를 반환하는 함수 */
	public int getCount(String memberId) {
		
		return noticeDAO.getCount(memberId);
		
	}//end of getCount

}//end of NoticeService
