package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Notice;

/** DB내의 notice 테이블과 데이터를 주고 받는 클래스 */
public class NoticeDAO extends SqlSessionDaoSupport {
	
	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** 데이터를 추가하는 함수 */
	public boolean addNotice(Notice n) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("notice.add",n)>0?true:false;
		
		return flag;
		
	}//end of addNotice
	
	/** 데이터를 추가하는 함수 */
	public boolean addNotice1(Notice n) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("notice.addSingoNotice",n)>0?true:false;
		
		return flag;
		
	}//end of addNotice1
	
	/** 아이디를 통해 데이터를 가져오는 함수 */
	public List<Notice> searchById(String id) {
		
		List<Notice> list = null;
		
		session = getSqlSession();
		list = session.selectList("notice.selectById",id);
		
		return list;
		
	}//end of searchNoticeById
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 */
	public boolean deleteByNoticeNum(int noticeNum) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("notice.deleteByNoticeNum", noticeNum)>0?true:false;
		
		return flag;
		
	}
	
	/** notice 데이터 추가(관리자 공지) */
	public boolean addFromAdmin(Notice n) {
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("notice.addFromAdmin2",n)>0 ? true : false ;
		
		return flag;
	}//end of addFromAdmin
	
	/** 친구 요청 데이터 추가 */
	public boolean addFriendRequest(Notice n) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("notice.addFriendRequest",n)>0?true:false;
		
		return flag;
		
	}//end of addFriendRequest
	
	/** noticeTarget(group_num)을 통한 notice 테이블 내의 데이터 삭제 (그룹 삭제 투표 취소) */
	public boolean deleteGroupNoticeByNoticeTarget(int noticeTarget) {
		session = getSqlSession();
		return session.delete("notice.deleteGroupNoticeByNoticeTarget", noticeTarget) > 0 ? true : false ;
	}
	
	/** notice 데이터 개수를 반환하는 함수 */
	public int getCount(String memberId) {
		
		int result = 0;
		
		session = getSqlSession();
		result = session.selectOne("notice.getCount",memberId);
		
		return result;
		
	}//end of getCont
	
}//end of NoticeDAO
