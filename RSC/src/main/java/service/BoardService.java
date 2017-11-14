package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import dao.BoardDAO;
import domain.Board;

@Transactional
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

	/** 게시글을 시간 순서대로 가져오는 함수 */
	public Map<String, List<Board>> getLists() {

		Map<String, List<Board>> map = new HashMap<>();

		List<Board> all = boardDAO.searchOrderByTime();

		List<Board> day = getDays(all);
//		List<Board> week = getWeeks(all);
//		List<Board> month = getMonths(all);

		map.put("day", day);
//		map.put("week", week);
//		map.put("month", month);

		return map;

	}// end of getLists

	/** 일간 조회수별로 정렬하는 함수 */
	private List<Board> getDays(List<Board> all) {

		List<Board> list = new ArrayList<>();
		
		return list;
		
	}// end of getDays

//	private List<Board> getWeeks(List<Board> all) {
//
//		
//		
//	}// end of getWeeks
//
//	private List<Board> getMonths(List<Board> all) {
//
//		
//		
//	}// end of getMonths

} // end of BoardService
