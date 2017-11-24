package domain;

import java.util.List;

/** chat 테이블에 담을 정보 class */
public class Chat {

	/* 변수 */ 
	private int chatNum; // col : chat_num
	private List<Member> members; // col : member_id
	
	/* 생성자 */
	public Chat() {
	}
	public Chat(int chatNum, List<Member> members) {
		super();
		this.chatNum = chatNum;
		this.members = members;
	}


	/* Getter, Setter */
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
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Chat [chatNum=");
		builder.append(chatNum);
		builder.append(", members=");
		builder.append(members);
		builder.append("]");
		return builder.toString();
	}
	
	
} // end of class Chat
