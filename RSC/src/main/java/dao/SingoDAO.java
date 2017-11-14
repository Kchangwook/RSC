package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.BoardSingo;
import domain.GroupSingo;
import domain.ReplySingo;

public class SingoDAO extends SqlSessionDaoSupport{
	
	private SqlSession session;
	
	public List<BoardSingo> searchAllBoardSingo(){
		session = getSqlSession();
		return session.selectList("singo.selectAllBoardSingo");
	}
	
	public List<ReplySingo> searchAllReplySingo(){
		session = getSqlSession();
		return session.selectList("singo.selectAllReplySingo");
	}
	
	public List<GroupSingo> searchAllGroupSingo(){
		session = getSqlSession();
		return session.selectList("singo.selectAllGroupSingo");
	}
	
	public boolean restoreBoardSingo(String boardSingoNum, String boardNum) {
		session = getSqlSession();
		int update = session.update("singo.updateBoardSingoFlag",boardNum);
		int delete = session.delete("singo.deleteBoardSingo",boardSingoNum);
		return (update*delete)>0 ? true : false;		
	}
	
	public boolean restoreReplySingo(String replySingoNum, String replyNum) {
		session = getSqlSession();
		int update = session.update("singo.updateReplySingoFlag",replyNum);
		int delete = session.delete("singo.deleteReplySingo",replySingoNum);
		return (update*delete)>0 ? true : false;	
	}
	
	public boolean restoreGroupSingo(String groupSingoNum, String groupNum) {
		session = getSqlSession();
		int update = session.update("singo.updateGroupsSingoCnt",groupNum);
		int delete = session.delete("singo.deleteGroupSingo",groupSingoNum);
		return (update*delete)>0 ? true : false;
	}
	
	public boolean deleteBoardBySingo(String boardNum) {
		session = getSqlSession();
		return session.delete("singo.deleteBoardBySingo",boardNum)>0 ? true : false;
	}
	
	public boolean deleteReplyBySingo(String replyNum) {
		session = getSqlSession();
		return session.delete("singo.deleteReplyBySingo",replyNum)>0 ? true : false;
	}
	
	public boolean deleteGroupBySingo(String groupNum) {
		session = getSqlSession();
		return session.delete("singo.deleteGroupBySingo",groupNum)>0 ? true : false;
	}

}
