package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Reply;

/** DB내의 reply 테이블과 데이터를 주고 받는 클래스 */
public class ReplyDAO extends SqlSessionDaoSupport{
	
	/* 변수 */
	private SqlSession session;
	
	/* 댓글 등록 */
	public boolean addReply(Reply r) {
		return getSqlSession().insert("addReply", r) > 0 ? true : false;
	}

	/* 댓글을 아이디로 검색 후 list에 담기 & 시간순 정렬 */
	public List<Reply> selectAll(int boardNum) {
		return getSqlSession().selectList("selectReplyByIdDesc", boardNum);
	}
	
	/* 게시글 번호로 댓글 검색 후 객체로 반환 */
	public List<Reply> searchReply(int boardNum) {
		return getSqlSession().selectList("selectReplyByboardNum", boardNum);
	}
	
	/* 댓글 번호로 검색 후 객체로 반환 */
	public Reply searchReply1(int replyNum) {
		return getSqlSession().selectOne("selectReplyByReplyNum", replyNum);
	}
	
	/** 게시글 번호에 해당하는 댓글 삭제 */
	public boolean deleteByBoard(int boardNum) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("reply.deleteByBoard",boardNum)>0?true:false;
		
		return flag;
		
	}//end of deleteByBoard
	
	/** 댓글 번호에 해당하는 댓글 삭제 */
	public boolean deleteByNum(int replyNum) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("reply.deleteByNum",replyNum)>0?true:false;
		
		return flag;
		
	}//end deleteByBoard
	
} // end of ReplyDAO
