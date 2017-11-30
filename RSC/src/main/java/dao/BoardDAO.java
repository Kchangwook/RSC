package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Board;

/** DB내의 board 테이블과 데이터를 주고 받는 클래스 */
public class BoardDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 게시글 등록 */
	public boolean addBoard(Board b) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("addBoard", b) > 0 ? true : false;
		
		return flag;
	}
	
	/* 게시글 아이디로 검색 후 리스트로 반환 */
	public List<Board> selectAll(String memberId) {
		session = getSqlSession();
		return session.selectList("selectBoardByIdDesc", memberId);
	}
	
	/* 게시글 일부만 검색 */
	public List<Board> selectMoreBoard(Board b) {
		session = getSqlSession();
		return session.selectList("selectMoreBoard", b);
	}
	
	/* 게시글 번호로 검색& 조회수 증가*/
	public Board searchBoard(int boardNum) {
		session = getSqlSession();
		session.update("addReadNum", boardNum);
		return session.selectOne("selectBoardByNum", boardNum);
	}
	
	/* 게시글 번호로 검색 */
	public Board searchBoard1(int boardNum) {
		session = getSqlSession();
		return session.selectOne("selectBoardByNum", boardNum);
	}
	
	/** 게시글 시간 조회수대로 가져오기 */
	public List<Board> searchOrderByCount(){
		
		session = getSqlSession();
		List<Board> list = session.selectList("board.selectOrderByCount");
		
		return list;
		
	}//end of searchOrderByTime
	
	/** 친구가 작성한 게시글 불러오기 */
	public List<Board> searchForAll(Board b){
		
		List<Board> list = null;
		
		session = getSqlSession();
		list = session.selectList("board.selectForAll",b);
		
		return list;
		
	}//end of searchByFriendId
	
	/** 게시글 항목별 오름차순 정렬 */
	public List<Board> searchAllOrder(Map map){
		session = getSqlSession();
		List<Board> list = session.selectList("board.selectAllOrder",map);
		return list;
	}
	/** 그룹번호로 게시글 가져오기 */
	public List<Board> searchByGroupNum(Board board){
		session = getSqlSession();
		return session.selectList("board.selectByGroupNum",board);
	}
	
	/** 게시글 좋아요 */
	public Board plusLike(int boardNum) {
		getSqlSession().update("board.plusLike", boardNum);
		return getSqlSession().selectOne("selectBoardByNum", boardNum);
	} // end of plusLike
	
	/** 게시글 좋아요 취소 */
	public Board minusLike(int boardNum) {
		getSqlSession().update("board.minusLike", boardNum);
		return getSqlSession().selectOne("selectBoardByNum", boardNum);
	} // end of minusLike
	
	/** 내가 쓴 게시글들만 가져오기 */
	public List<Board> getMine(Board b){
		
		List<Board> list = null;
		
		session = getSqlSession();
		list = session.selectList("board.getMine",b);
		
		return list;
		
	}//end of getMine
	
	/** 게시글 삭제하기 */
	public boolean deleteByNum(int boardNum) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("board.deleteByNum",boardNum)>0?true:false;
		
		return flag;
		
	}//end of deleteByNum
	
	/** 게시글 수정하기 */
	public boolean updateContent(Board b) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.update("board.updateContent",b)>0?true:false;
		
		return flag;
		
	}//end of updateContent
	
	/** 그룹에 게시글 추가 */
	public boolean addGroupBoard(Board board) {
		session = getSqlSession();
		return session.insert("board.addGroupBoard",board) > 0 ? true : false ;
	}
	
} // end of BoardDAO
