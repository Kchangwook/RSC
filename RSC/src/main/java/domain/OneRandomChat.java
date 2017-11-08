package domain;

/** one_random_chat 테이블에 담을 정보 class */
public class OneRandomChat {

	/* 변수 */
	private int oneRandomNum; // col : one_random_num
	private String memberId; // col : member_id
	
	/* 생성자 */
	public OneRandomChat() {
	}	
	public OneRandomChat(int oneRandomNum, String memberId) {
		super();
		this.oneRandomNum = oneRandomNum;
		this.memberId = memberId;
	}

	/* Getter, Setter */
	public int getOneRandomNum() {
		return oneRandomNum;
	}
	public void setOneRandomNum(int oneRandomNum) {
		this.oneRandomNum = oneRandomNum;
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
		builder.append("OneRandomChat [oneRandomNum=");
		builder.append(oneRandomNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class OneRandomChat
