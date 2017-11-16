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
	
} // end of ReplyDAO
