package domain;

/** chat 테이블에 담을 정보 class */
public class Chat {

	/* 변수 */ 
	private int chatNum; // col : chat_num
	private String memberId; // col : member_id
	
	/* 생성자 */
	public Chat() {
	}
	public Chat(int chatNum, String memberId) {
		super();
		this.chatNum = chatNum;
		this.memberId = memberId;
	}


	/* Getter, Setter */
	public int getChatNum() {
		return chatNum;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Chat [chatNum=");
		builder.append(chatNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
	
	
} // end of class Chat
