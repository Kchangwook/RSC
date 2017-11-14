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
	public void addReply(Reply r) {
		replyDAO.addReply(r);
	}

	/** 댓글 불러오는 함수 */
	public List<Reply> selectAllReply(int boardNum) {
		return replyDAO.selectAll(boardNum);
	}
	
} // end of ReplyService
