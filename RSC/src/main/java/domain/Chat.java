package domain;

import java.sql.Date;
import java.util.List;

/** chat 테이블에 담을 정보 class */
public class Chat {

	/* 변수 */ 
	private int chatNum; // col : chat_num
	private List<Member> members; // col : member_id
	private String memberId;
	private Message recentMessage;
	
	/* 생성자 */
	public Chat() {}
	public Chat(int chatNum, List<Member> members, String memberId, Message recentMessage) {
		super();
		this.chatNum = chatNum;
		this.members = members;
		this.memberId = memberId;
		this.recentMessage = recentMessage;
	}
	
	/* 프로퍼티 */
	public int getChatNum() {
		return chatNum;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}
	public List<Member> getMembers() {
		return members;
	}
	public void setMembers(List<Member> members) {
		this.members = members;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public Message getRecentMessage() {
		return recentMessage;
	}
	public void setRecentMessage(Message recentMessage) {
		this.recentMessage = recentMessage;
	}
	
	/* 함수 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Chat [chatNum=");
		builder.append(chatNum);
		builder.append(", members=");
		builder.append(members);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class Chat
