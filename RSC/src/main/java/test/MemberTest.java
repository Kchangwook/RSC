package test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.MemberDAO;
import domain.Member;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class MemberTest {

	/* 변수 */
	@Autowired private MemberDAO memberDAO;
	List<Member> list;
	
	/* 함수 */
	/** 사전 설정을 하는 함수 */
	@Before
	public void setUp() {
		list = Arrays.asList(new Member("wjdrb", "1234", "갓규", "음악", 0, 0),
		new Member("ckddnr", "1234", "PM", "게임", 1, 0),
		new Member("dydwls", "1234", "yong", "게임", 0, 0),
		new Member("wlstjs", "1234", "jin", "영화", 1, 0));
	}
	
	/** addAndGet을 테스트 */
	@Test
	public void addAndGet() {
		
		memberDAO.deleteAll();
		assertThat(memberDAO.getCount(),is(0));
		
		for(Member m:list) memberDAO.addMember(m);
		assertThat(memberDAO.getCount(),is(list.size()));
		
		Member m = memberDAO.searchById("wjdrb");
		m.setMemberImg("");
		checkSameMember(m,list.get(0));
		
		Member m1 = memberDAO.searchByNick("jin");
		m1.setMemberImg("");
		checkSameMember(m1,list.get(3));
		
	}//end of addAndGet
	
	/** 같은 맴버인지 확인하는 함수 */
	private void checkSameMember(Member m1, Member m2) {
		
		assertThat(m1.getMemberId(),is(m2.getMemberId()));
		assertThat(m1.getMemberImg(),is(m2.getMemberImg()));
		assertThat(m1.getMemberInfoOpen(),is(m2.getMemberInfoOpen()));
		assertThat(m1.getMemberInterest(),is(m2.getMemberInterest()));
		assertThat(m1.getMemberLogin(),is(m2.getMemberLogin()));
		assertThat(m1.getMemberLogout(),is(m2.getMemberLogout()));
		assertThat(m1.getMemberNick(),is(m2.getMemberNick()));
		assertThat(m1.getMemberPresentLogin(),is(m2.getMemberPresentLogin()));
		assertThat(m1.getMemberPw(),is(m2.getMemberPw()));
		
	}//end of checkSameMember
	
	
}//end of MemberTest
