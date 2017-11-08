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

import dao.MasterDAO;
import domain.Master;

/** MasterDAO를 테스트하는 클래스 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class MasterTest {

	/* 변수 */
	@Autowired private MasterDAO masterDAO;
	private List<Master> list;
	
	/* 함수 */
	/** 사전 설정을 위한 함수 */
	@Before
	public void setUp() {
		
		list = Arrays.asList(new Master("master1", "1234"),
				new Master("master2","3333"));
		
	}//end of setUp
	
	/** add와 get을 테스트하는 함수 */
	@Test
	public void addAndGet() {
		
		masterDAO.deleteAll();
		assertThat(masterDAO.getCount(),is(0));
		
		for(Master a:list) masterDAO.addMaster(a);
		assertThat(masterDAO.getCount(),is(2));
		
	}//end of addAndGet
	
}//end of MasterTest
