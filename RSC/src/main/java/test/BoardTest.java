package test;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.BoardDAO;
import domain.Board;

/** Board DAO를 테스트 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class BoardTest {
	
	private @Autowired BoardDAO dao;
	
	@Test
	/** 모든 게시글을 시간 순서대로 가져오기 */
	public void getAllByTime() {
		
		List<Board> list = dao.searchOrderByTime();	
		
		assertThat(list.size(),is(3));
		
	}//end of getAllByTime

}//end of BoardTest
