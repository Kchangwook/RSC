package background;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import domain.Member;
import service.MemberService;

@WebListener
@Transactional
public class DeleteOldMemberListener implements ServletContextListener, Runnable {
	
	/** 작업을 수행할 thread */
	private Thread thread;
	private boolean isShutdown = false;
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private MemberService memberService = context.getBean("memberService", MemberService.class);
	
	/** context */
	private ServletContext sc;

	/** 작업을 수행한다 */
	public void startDaemon() {
		if (thread == null) {
			thread = new Thread(this, "Daemon thread for background task");
			// thread.setDaemon(true);
		}
		if (!thread.isAlive()) {
			thread.start();
		}
	}
	
	public void run() {
		Thread currentThread = Thread.currentThread();
		while (currentThread == thread && !this.isShutdown) {
			try {
				memberService.deleteOldMember();

				Thread.sleep(60 * 60 * 24 * 1000);
				
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("===================DaemonListener end.(deleteOldMember)===================");
		
	}

	/** 컨텍스트 초기화 시 데몬 스레드를 작동한다 */
	public void contextInitialized(ServletContextEvent event) {

		System.out.println("===================DaemonListener.contextInitialized has been called.(deleteOldMember)===================");
		sc = event.getServletContext();
		startDaemon();

	}

	/** 컨텍스트 종료 시 thread를 종료시킨다 */
	public void contextDestroyed(ServletContextEvent event) {

		System.out.println("===================DaemonListener.contextDestroyed has been called.(deleteOldMember)===================");
		this.isShutdown = true;
		try {
			thread.join();
			thread = null;
		} catch (InterruptedException ie) {
			ie.printStackTrace();
		}
	}
}
