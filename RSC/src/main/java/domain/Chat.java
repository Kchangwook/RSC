package domain;

import java.util.List;

/** chat 테이블에 담을 정보 class */
public class Chat {

	/* 변수 */ 
	private int chatNum; // col : chat_num
	private List<Member> members; // col : member_id
	private String memberId;
	
	/* 생성자 */
	public Chat() {}
	public Chat(int chatNum, List<Member> members, String memberId) {
		super();
		this.chatNum = chatNum;
		this.members = members;
		this.memberId = memberId;
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
