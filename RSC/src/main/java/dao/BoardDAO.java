package dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Board;

/** DB내의 board 테이블과 데이터를 주고 받는 클래스 */
public class BoardDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	// 게시글 등록
	public void addBoard(Board board) {
		System.out.println("여기까지는 가겟지");
		getSqlSession().insert("addBoard", board);
	}
	
	
} // end of BoardDAO
