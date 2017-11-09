package service;

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
	public void addBoard(Board board) {
		System.out.println("여기는 오니??");
		boardDAO.addBoard(board);
	}
	
	
	
	
} // end of BoardService
