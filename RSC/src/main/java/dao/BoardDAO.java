package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Board;

/** DB내의 board 테이블과 데이터를 주고 받는 클래스 */
public class BoardDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	// 게시글 등록
	public void addBoard(Board b) {
		getSqlSession().insert("addBoard", b);
	}
	
	public List<Board> selectAll(String memberId) {
		return getSqlSession().selectList("selectBoardByIdDesc", memberId);
	}
	
	/** 게시글 시간 순서대로 가져오기 */
	public List<Board> searchOrderByTime(){
		
		session = getSqlSession();
		List<Board> list = session.selectList("board.selectOrderByTime");
		
		return list;
		
	}//end of searchOrderByTime
	
	
} // end of BoardDAO
