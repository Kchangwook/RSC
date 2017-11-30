package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dao.BoardDAO;
import dao.ReplyDAO;
import domain.Board;
import ftp.FTPService;

@Transactional
/** board 데이터를 이용한 서비스 */
public class BoardService {

	/* 변수 */
	private BoardDAO boardDAO;
	private ReplyDAO replyDAO;
	private FTPService ftp;

	/* 프로퍼티 */
	public void setFTPService(FTPService ftp) {
		this.ftp = ftp;
	}

	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
	}
	public void setReplyDAO(ReplyDAO replyDAO) {
		this.replyDAO = replyDAO;
	}

	/* 함수 */

	/** 게시글 입력하는 함수 */
	public boolean addBoard(Board b, MultipartHttpServletRequest request) {
		
		boolean flag = true;

		System.out.println("1번 : " + b.getMemberId());
		System.out.println("2번 : " + b.getBoardFile());
		System.out.println(request.getFile("boardFile").getOriginalFilename());
		
		// 등록한 파일이 있으면
		if(!request.getFile("boardFile").getOriginalFilename().equals("")) {
			
			b = this.uploadFile(request, b, "boardFile");
			
			System.out.println("3번 : " + b.getBoardFile());
			
			System.out.println("5번 : " + b);

			
			if (!b.getBoardFile().equals(" ")) {
				String fileName[] = b.getBoardFile().split("/");

				// ftp에 파일 업로드
				ftp.upload("board", fileName[fileName.length - 1]);
			} 
			
		} 
		
		// DB에 데이터 추가
		flag = boardDAO.addBoard(b);

		return flag;
	}

	/** 게시글 파일 업로드 */
	private Board uploadFile(MultipartHttpServletRequest request, Board b, String mode) {
		
		MultipartFile file = request.getFile(mode);
		
		System.out.println("4번 fileName: " + file.getOriginalFilename());
		
		try {
			if (file.isEmpty()) { // 파일 유무 검사
			} else if (file.getSize() > (5 * 1024 * 1024)) {
				System.out.println("## 용량이 너무 큽니다. \n 5메가 이하로 해주세요.");
			}

			file.transferTo(new File("C:/0.IT/4.framework/RSC/src/main/webapp/info/board/" + b.getMemberId() + "_"
					+ file.getOriginalFilename()));

			System.out.println(file.getOriginalFilename());

			if (!file.getOriginalFilename().equals(""))
				b.setBoardFile("info/board/" + b.getMemberId() + "_" + file.getOriginalFilename());

		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}

		
		return b;
	} // end of uploadFile
	
	/** 게시글 일부만 불러오는 함수 */
	public List<Board> selectMoreBoard(Board board) {
		
		List<Board> list = boardDAO.selectMoreBoard(board);
		
		try {
			for (Board b : list) {
				// ftp에 존재하는 프로필 파일 다운로드
				if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
					String fileName[] = b.getMemberImg().split("/");
					ftp.download("member", fileName[fileName.length - 1], "member");
					
				}
				
				// ftp에 존재하는 게시판 파일 다운로드 
				if(!b.getBoardFile().equals(" ")) {
					String fileName[] = b.getBoardFile().split("/");
					ftp.download("board", fileName[fileName.length - 1], "board");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	} // end of selectMoreBoard

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

		List<Board> all = boardDAO.searchOrderByCount();

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
			for (Board b : all) {
				
				if (date.before(b.getBoardTime()) && count < 3) {
					count++;
					
					// ftp에 존재하는 프로필 파일 다운로드
					if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
						String fileName[] = b.getMemberImg().split("/");
						ftp.download("member", fileName[fileName.length - 1], "member");
					}
					
					// ftp에 존재하는 게시판 파일 다운로드 
					if(!b.getBoardFile().equals(" ")) {
						String fileName[] = b.getBoardFile().split("/");
						ftp.download("board", fileName[fileName.length - 1], "board");
					}
					
					list.add(b);
				} else if (count == 3)
					break;
			}
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
					
					// ftp에 존재하는 게시판 파일 다운로드 
					if(!b.getBoardFile().equals(" ")) {
						String fileName[] = b.getBoardFile().split("/");
						ftp.download("board", fileName[fileName.length - 1], "board");
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
					
					// ftp에 존재하는 게시판 파일 다운로드 
					if(!b.getBoardFile().equals(" ")) {
						String fileName[] = b.getBoardFile().split("/");
						ftp.download("board", fileName[fileName.length - 1], "board");
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
	public List<Board> getForAll(Board b){
		System.out.println(b);
		
		return boardDAO.searchForAll(b);
		
	}//end of getForAll
	
	/** 게시글 항목별 정렬 */
	public List<Board> searchAllOrder(Map map){
		List<Board> list = boardDAO.searchAllOrder(map);
		return list;
	}
	
	/** 그룹 번호로 게시글 검색 */
	public List<Board> searchByGroupNum(Board board){
		List<Board> list = boardDAO.searchByGroupNum(board);
		
		try {
			for (Board b : list) {
				// ftp에 존재하는 프로필 파일 다운로드
				if (!b.getMemberImg().equals("resources/img/profile.jpg")) {
					String fileName[] = b.getMemberImg().split("/");
					ftp.download("member", fileName[fileName.length - 1], "member");
					
				}
				
				// ftp에 존재하는 게시판 파일 다운로드 
				if(!b.getBoardFile().equals(" ")) {
					String fileName[] = b.getBoardFile().split("/");
					ftp.download("board", fileName[fileName.length - 1], "board");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
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
	
	/** 내가 쓴 게시글들 가져오기 */
	public List<Board> getMine(String memberId){
		
		return boardDAO.getMine(memberId);
		
	}//end of getMine
	
	/** 게시글 번호에 해당하는 게시글 삭제하기 */
	public boolean deleteByNum(int boardNum) {
		
		return boardDAO.deleteByNum(boardNum);
		//&& replyDAO.deleteByBoard(boardNum);
		
	}//end of deleteByNum
	
	/** 게시글 번호에 해당하는 게시글 수정하기 */
	public boolean updateContent(Board b) {
		
		return boardDAO.updateContent(b);
		
	}//end of updateContent
	
	/** 그룹에 게시글 추가 */
	public boolean addGroupBoard(Board board) {
		return boardDAO.addGroupBoard(board);
	}
	
} // end of BoardService
