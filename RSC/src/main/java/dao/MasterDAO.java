package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Master;

/** DB내의 master 테이블과 데이터를 주고 받는 클래스 */
public class MasterDAO extends SqlSessionDaoSupport {

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** master 데이터 모두를 가져오는 함수 */
	public List<Master> searchAll(){
		
		List<Master> list = null;
		
		session = getSqlSession();
		list = session.selectList("master.selectAll");
		
		return list;
		
	}//end of searchAll
	
	/** 아이디를 통한 master 검색 */
	public Master selectById(String id) {
		
		Master m = null;;
		
		session = getSqlSession();
		m = session.selectOne("master.selectById",id);
		
		return m;
		
	}//end of selectById
	
	/** master 데이터 삽입 */
	public boolean addMaster(Master m) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("master.add",m)>0?true:false;
		
		return flag;
		
	}//end of addMaster
	
	/** master 테이블 내의 모든 데이터 삭제 */
	public void deleteAll() {
		
		session = getSqlSession();
		session.delete("master.deleteAll");
		
	}//end of deleteAll
	
	/** master 테이블 내의 데이터 수 가져오기 */
	public int getCount() {
		
		int count = 0;
		
		session = getSqlSession();
		count = session.selectOne("master.getCount");
		
		return count;
		
	}//end of getCount
	
}//end of MasterDAO
