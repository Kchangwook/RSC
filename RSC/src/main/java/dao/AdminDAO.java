package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Admin;

/** DB내의 admin 테이블과 데이터를 주고 받는 클래스 */
public class AdminDAO extends SqlSessionDaoSupport{

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** admin 테이블 내의 모든 데이터를 가져오는 함수 */
	public List<Admin> searchAll(){
		
		List<Admin> list = null;
		
		session = getSqlSession();
		list = session.selectList("admin.selectAll");
		
		return list;
		
	}//end of searchAll
	
	/** 아이디를 통한 admin 검색 */
	public Admin searchById(String id) {
		
		Admin a = null;
		
		session = getSqlSession();
		a = session.selectOne("admin.selectById",id);
		
		return a;
		
	}//end of searchById
	
	/** admin 데이터 삽입 */
	public boolean addAdmin(Admin a) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("admin.add",a)>0?true:false;
		
		return flag;
		
	}//end of addAdmin
	
	/** admin 테이블 내의 모든 데이터 삭제 */
	public void deleteAll() {
		
		session = getSqlSession();
		session.delete("admin.deleteAll");
		
	}//end of deleteAll
	
	/** admin 테이블 내의 데이터 수 가져오기 */
	public int getCount() {
		
		int count = 0;
		
		session = getSqlSession();
		count = session.selectOne("admin.getCount");
		
		return count;
		
	}//end of getCount
	
}//end of AdminDAO
