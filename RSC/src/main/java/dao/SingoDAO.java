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

}
