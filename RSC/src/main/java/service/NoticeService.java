package service;

import java.util.List;


import dao.NoticeDAO;
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
	
	/** 아이디를 통해 notice 데이터를 가져오는 함수 */
	public List<Notice> searchById(String id) {
		
		List<Notice> list = null;
		
		list = noticeDAO.searchById(id);
		
		return list;
		
	}//end of searchNoticeById
	
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 */
	public boolean deleteByNoticeNum(int noticeNum) {
		
		boolean flag = true;
		System.out.println(noticeNum);
		flag = noticeDAO.deleteByNoticeNum(noticeNum);
		
		return flag;
		
	}//end of deleteByNoticeNum

}//end of NoticeService