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
	
	/** 아이디를 통해 데이터를 가져오는 함수 */
	public List<Notice> searchById(String id) {
		
		List<Notice> list = null;
		
		session = getSqlSession();
		list = session.selectList("notice.selectById",id);
		
		return list;
		
	}//end of searchNoticeById
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 */
	public boolean deleteByNoticeNum(String noticeNum) {
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("notice.deleteByNoticeNum")>0?true:false;
		
		return flag;
		
	}
}
