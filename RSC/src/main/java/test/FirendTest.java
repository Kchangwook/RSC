package test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.FriendDAO;
import domain.Friend;

/** Friend 관련 정보들을 실험하는 테스트 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class FirendTest {

	@Autowired private FriendDAO dao;
	
	@Test
	public void getAllList() {
		
		List<Friend> list = dao.getList("ckddnr");
		
		assertThat(list.size(),is(2));
		
		assertThat(list.get(0).getFriendImg().equals(""),is(false));		
		
	}//end of getAllList
	
}//FriendTest
