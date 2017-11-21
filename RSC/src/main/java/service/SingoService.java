package service;

import java.util.List;

import dao.SingoDAO;
import domain.BoardSingo;
import domain.GroupSingo;
import domain.ReplySingo;

public class SingoService {
	
	private SingoDAO singoDAO;
	
	public void setSingoDAO(SingoDAO singoDAO) {
		this.singoDAO = singoDAO;
	}
	
	public List<BoardSingo> searchAllBoardSingo(){
		return singoDAO.searchAllBoardSingo();
	}
	
	public List<ReplySingo> searchAllReplySingo(){
		return singoDAO.searchAllReplySingo();
	}
	
	public List<GroupSingo> searchAllGroupSingo(){
		return singoDAO.searchAllGroupSingo();
	}
	
	public boolean restoreBoardSingo(String boardSingoNum, String boardNum) {
		return singoDAO.restoreBoardSingo(boardSingoNum, boardNum);
	}
	
	public boolean restoreReplySingo(String replySingoNum, String replyNum) {
		return singoDAO.restoreReplySingo(replySingoNum, replyNum);
	}
	
	public boolean restoreGroupSingo(String groupSingoNum, String groupNum) {
		return singoDAO.restoreGroupSingo(groupSingoNum, groupNum);
	}
	
	public boolean deleteBoardBySingo(String boardNum) {
		return singoDAO.deleteBoardBySingo(boardNum);
	}
	
	public boolean deleteReplyBySingo(String replyNum) {
		return singoDAO.deleteReplyBySingo(replyNum);
	}
	
	public boolean deleteGroupBySingo(String groupNum) {
		return singoDAO.deleteGroupBySingo(groupNum);
	}
	
	/* board_singo 테이블에 입력 */
	public void addBoardSingo(BoardSingo bs) {
		singoDAO.addBoardSingo(bs);
	} // end of addBoardSingo
	
	/* reply_singo 테이블에 입력 */
	public void addReplySingo(ReplySingo rs) {
		singoDAO.addReplySingo(rs);
	} // end of addReplySingo
	
} // end of SingoService
