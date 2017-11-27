package background;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import domain.GroupRandomChat;
import domain.Member;
import domain.Notice;
import domain.OneRandomChat;
import service.ChatService;
import service.NoticeService;
import service.RandomChatService;

@WebListener
@Transactional
public class RandomChatListener implements ServletContextListener, Runnable {

	/** 작업을 수행할 thread */
	private Thread thread;
	private boolean isShutdown = false;
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private RandomChatService randomChatService = context.getBean("randomChatService", RandomChatService.class);
	private ChatService chatService = context.getBean("chatService", ChatService.class);
	private NoticeService noticeService = context.getBean("noticeService", NoticeService.class);

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

	/** 스레드가 실제로 작업하는 부분 */
	public void run() {

		Thread currentThread = Thread.currentThread();
		while (currentThread == thread && !this.isShutdown) {
			try {

				List<OneRandomChat> oneList = randomChatService.getOne();
				List<GroupRandomChat> groupList = randomChatService.getGroup();

				Thread.sleep(1000);

				if (oneList.size() >= 2) {

					List<String> memberList = new ArrayList<>();
					List<Notice> noticeList = new ArrayList<>();

					for (int i = 0; i < 2; i++) {
						OneRandomChat orc = oneList.get(i);
						memberList.add(orc.getMemberId());
						randomChatService.deleteOneRandomChat(orc.getOneRandomNum());
					}

					Thread.sleep(1000);
					
					if (chatService.makeChatRoom(memberList)) {
						
						for(String s:memberList) {
							noticeList.add(new Notice(s,"랜덤채팅이 생성되었습니다.",3));
						}
						
						Thread.sleep(1000);
						for (Notice n : noticeList)
							noticeService.addNotice(n);
					}
					
					Thread.sleep(1000);
				}

				if (groupList.size() >= 4) {

					List<String> memberList = new ArrayList<>();
					List<Notice> noticeList = new ArrayList<>();

					for (int i = 0; i < 4; i++) {
						GroupRandomChat grc = groupList.get(i);
						memberList.add(grc.getMemberId());
						randomChatService.deleteGroupRandomChat(grc.getGroupRandomNum());
					}

					Thread.sleep(1000);
					
					if (chatService.makeChatRoom(memberList)) {
						
						for(String s:memberList) {
							noticeList.add(new Notice(s,"랜덤채팅이 생성되었습니다.",3));
						}
						
						Thread.sleep(1000);
						for (Notice n : noticeList)
							noticeService.addNotice(n);
					}
					
					Thread.sleep(1000);

				}

				Thread.sleep(50000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("===================DaemonListener end.===================");
	}

	/** 컨텍스트 초기화 시 데몬 스레드를 작동한다 */
	public void contextInitialized(ServletContextEvent event) {

		System.out.println("===================DaemonListener.contextInitialized has been called.===================");
		sc = event.getServletContext();
		startDaemon();

	}

	/** 컨텍스트 종료 시 thread를 종료시킨다 */
	public void contextDestroyed(ServletContextEvent event) {

		System.out.println("===================DaemonListener.contextDestroyed has been called.===================");
		this.isShutdown = true;
		try {
			thread.join();
			thread = null;
		} catch (InterruptedException ie) {
			ie.printStackTrace();
		}
	}
}
