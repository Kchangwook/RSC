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

import dao.AdminDAO;
import domain.Admin;

/** AdminDAO를 테스트하는 클래스 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "/applicationContext.xml")
public class AdminTest {
	
	/* 변수 */
	@Autowired private AdminDAO adminDAO;
	private List<Admin> list;
	
	/* 함수 */
	/** 사전 설정을 위한 함수 */
	@Before
	public void setUp() {
		
		list = Arrays.asList(new Admin("admin1", "1234"),
				new Admin("admin2","3333"));
		
	}//end of setUp
	
	/** add와 get을 테스트하는 함수 */
	@Test
	public void addAndGet() {
		
		adminDAO.deleteAll();
		assertThat(adminDAO.getCount(),is(0));
		
		for(Admin a:list) adminDAO.addAdmin(a);
		assertThat(adminDAO.getCount(),is(2));
		
		Admin a = adminDAO.searchById("admin1");
		checkSameAdmin(a,list.get(0));
		
	}//end of addAndGet
	
	/** 같은 admin인지 확인하는 함수 */
	private void checkSameAdmin(Admin a1,Admin a2) {
		
		assertThat(a1.getAdminId(),is(a2.getAdminId()));
		assertThat(a1.getAdminPw(),is(a2.getAdminPw()));
		
	}//end of checkSameAdmin
	
	
}//end of AdminTest
