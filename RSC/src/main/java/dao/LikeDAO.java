package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Like;

/** DB내의 like 테이블과 데이터를 주고 받는 클래스 */
public class LikeDAO extends SqlSessionDaoSupport{
		
	/* 변수 */
	private SqlSession session;
	
	/* 좋아요 등록 */
	public boolean addLike(Like l) {
		session = getSqlSession();
		return session.insert("addLike", l) > 0 ? true : false;
	}
	
	/* 좋아요 삭제 */
	public boolean delLike(Like l) {
		session = getSqlSession();
		return session.delete("delLike", l) > 0 ? true : false;
	}
	
	/* 좋아요 리스트를 번호와 아이디로 검색 후 리스트 반환 */
	public boolean searchLike(Like l) {
		boolean flag = false;
		
		session = getSqlSession();
		
		flag = session.selectOne("selectLike", l) != null ? true : false;
		return flag;
	}
	

} // end of LikeDAO
