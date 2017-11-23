package service;

import java.util.List;

import dao.ReplyDAO;
import domain.Reply;

/** reply 데이터를 이용한 서비스*/
public class ReplyService {

	/* 변수 */
	private ReplyDAO replyDAO;
	
	/* 프로퍼티 */
	public void setReplyDAO(ReplyDAO replyDAO) {
		this.replyDAO = replyDAO;
	}
	
	/* 함수 */
	/** 댓글 입력하는 함수 */
	public boolean addReply(Reply r) {
		return replyDAO.addReply(r);
	}

	/** 게시판 번호로 불러오는 함수 */
	public List<Reply> selectReply(int boardNum) {
		return replyDAO.searchReply(boardNum);
	}
	
	/** 댓글 번호로 검색하는 함수 */
	public Reply searchReply1(int replyNum) {
		return replyDAO.searchReply1(replyNum);
	}
	
	/** 댓글 번호로 삭제하는 함수 */
	public boolean deleteByNum(int replyNum) {
		
		return replyDAO.deleteByNum(replyNum);
		
	}//end of deleteByNum
	
} // end of ReplyService
