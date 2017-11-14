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
	public void addReply(Reply r) {
		getSqlSession().insert("addReply", r);
	}

	/* 댓글을 아이디로 검색 후 list에 담기 & 시간순 정렬 */
	public List<Reply> selectAll(int boardNum) {
		return getSqlSession().selectList("selectReplyByIdDesc", boardNum);
	}
	
} // end of ReplyDAO
