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
}
