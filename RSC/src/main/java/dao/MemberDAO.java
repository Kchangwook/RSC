package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import domain.Member;

/** DB내의 member 테이블과 데이터를 주고 받는 클래스 */
public class MemberDAO extends SqlSessionDaoSupport {

	/* 변수 */
	private SqlSession session;
	
	/* 함수 */
	/** 데이터를 추가하는 함수 */
	public boolean addMember(Member m) {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.insert("member.add",m)>0?true:false;
		
		return flag;
		
	}//end of addMember
	
	/** 아이디를 통해 데이터를 가져오는 함수 */
	public Member searchById(String id) {
		
		Member m = null;
		
		session = getSqlSession();
		m = session.selectOne("member.selectById",id);
		
		return m;
		
	}//end of searchMemberById
	
	/** 모든 데이터를 가져오는 함수 */
	public List<Member> searchAll(){
		
		List<Member> list = null;
		
		session = getSqlSession();
		list = session.selectList("member.selectAll");
		
		return list;
		
	}//end of searchAll
	
	/** 테이블 내의 모든 데이터 삭제 */
	public boolean deleteAll() {
		
		boolean flag = true;
		
		session = getSqlSession();
		flag = session.delete("member.deleteAll")>0?true:false;
		
		return flag;
		
	}//end of deleteAll
	
	/** 테이블 내의 데이터 수 가져오기 */
	public int getCount() {
		
		int count = 0;
		
		session = getSqlSession();
		count = session.selectOne("member.getCount");
		
		return count;
		
	}//end of getCount;
	
	/** 닉네임으로 데이터가져오기 */
	public Member searchByNick(String nick) {
		
		Member m = null;
		
		session = getSqlSession();
		m = session.selectOne("member.selectByNick",nick);
		
		return m;
		
	}//end of nick
	
}//end of MemberDAO