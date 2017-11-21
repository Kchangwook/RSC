package service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import dao.BoardDAO;
import domain.Board;
import ftp.FTPService;

@Transactional
/** board 데이터를 이용한 서비스 */
public class BoardService {

	/* 변수 */
	private BoardDAO boardDAO;
	private FTPService ftp;

	/* 프로퍼티 */
	public void setFTPService(FTPService ftp) {
		this.ftp = ftp;
	}

	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}

	/* 함수 */

	/** 게시글 입력하는 함수 */
	public void addBoard(Board b) {
		boardDAO.addBoard(b);
	}

	/** 게시글 불러오는 함수 */
	public List<Board> selectAllBoard(String memberId) {
		return boardDAO.selectAll(memberId);
	}

	/** 번호로 게시글 검색하는 함수 */
	public Board searchBoard(int boardNum) {
		return boardDAO.searchBoard(boardNum);
	}
	
	/** 번호로 게시글 검색하는 함수 */
	public Board searchBoard1(int boardNum) {
		return boardDAO.searchBoard1(boardNum);
	}

	/** 게시글을 시간 순서대로 가져오는 함수 */
	public Map<String, List<Board>> getLists() {

		Map<String, List<Board>> map = new HashMap<>();

		List<Board> all = boardDAO.searchOrderByTime();

		List<Board> day = getDays(all);
		List<Board> week = getWeeks(all);
		List<Board> month = getMonths(all);

		map.put("day", day);
		map.put("week", week);
		map.put("month", month);

		return map;

	}// end of getLists

	/** 일간 조회수별로 정렬하는 함수 */
	private List<Board> getDays(List<Board> all) {

		List<Board> list = new ArrayList<>();
		int count = 0;

		Date date = new Date();
		date.setDate(date.getDate() - 1);
		try {
			for (Board b : all)
				if (date.before(b.getBoardTime()) && count < 3) {
					count++;
					
					// ftp에 존재하는 프로필 파일 다운로드
					if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
						String fileName[] = b.getMemberImg().split("/");
						ftp.download("member", fileName[fileName.length - 1], "member");
					}

					list.add(b);
				} else if (count == 3)
					break;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;

	}// end of getDays

	/** 주간 조회수 별로 정리하는 함수 */
	private List<Board> getWeeks(List<Board> all) {

		List<Board> list = new ArrayList<>();
		int count = 0;

		Date date = new Date();
		date.setDate(date.getDate() - 7);

		try {
			for (Board b : all)
				if (date.before(b.getBoardTime()) && count < 3) {
					count++;
					
					// ftp에 존재하는 프로필 파일 다운로드
					if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
						String fileName[] = b.getMemberImg().split("/");
						ftp.download("member", fileName[fileName.length - 1], "member");
					}

					list.add(b);
				} else if (count == 3)
					break;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;

	}// end of getWeeks

	/** 월간 조회수 별로 정리하는 함수 */
	private List<Board> getMonths(List<Board> all) {

		List<Board> list = new ArrayList<>();
		int count = 0;

		Date date = new Date();
		date.setMonth(date.getMonth() - 1);
		try {
			for (Board b : all)
				if (date.before(b.getBoardTime()) && count < 3) {
					count++;
					
					// ftp에 존재하는 프로필 파일 다운로드
					if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
						String fileName[] = b.getMemberImg().split("/");
						ftp.download("member", fileName[fileName.length - 1], "member");
					}

					list.add(b);
				} else if (count == 3)
					break;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;

	}// end of getMonths
	
	/** 회원이 작성한 전체 게시글 불러오기 */
	public List<Board> getForAll(String id){
		
		return boardDAO.searchForAll(id);
		
	}//end of getForAll
	
	/** 게시글 항목별 정렬 */
	public List<Board> searchAllOrder(Map map){
		List<Board> list = boardDAO.searchAllOrder(map);
		return list;
	}
	
	/** 게시글 좋아요 */
	public Board plusLike(int boardNum) {
		return boardDAO.plusLike(boardNum);
	} // end of plusLike
	
	/** 게시글 좋아요 취소 */
	public Board minusLike(int boardNum) {
		return boardDAO.minusLike(boardNum);
	} // end of minusLike

} // end of BoardService
