package service;

import java.util.List;

import dao.BoardDAO;
import domain.Board;

/** board 데이터를 이용한 서비스 */
public class BoardService {

	/* 변수 */
	private BoardDAO boardDAO;
	
	/* 프로퍼티 */
	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	
	/* 함수 */
	/** 게시글 입력하는 함수*/
	public void addBoard(Board b) {
		boardDAO.addBoard(b);
	}
	
	/** 게시글 불러오는 함수 */
	public List<Board> selectAllBoard(String memberId) {
		return boardDAO.selectAll(memberId);
	}
	
	
	
} // end of BoardService
