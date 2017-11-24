package test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.ChatDAO;
import domain.Member;

/** Chat DAO를 테스트 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class ChatTest {

	private @Autowired ChatDAO dao;
	
	/** 채팅방 번호로 맴버들 가져오기 */
	@Test
	public void getChat() {
		
		List<Member> list = dao.getMembers(1);
		assertThat(list.size(),is(2));
		
		System.out.println(list);
		
		assertThat(list.get(0).getMemberId(),is("wjdrb"));
		
	}//end of getChat
	
}//end of ChatTest
