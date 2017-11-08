package domain;

/** group_random_chat 테이블에 담을 정보 class */
public class GroupRandomChat {
	
	/* 변수 */
	private int groupRandomNum; // col : group_random_num
	private String memberId; // member_id
	
	/* 생성자 */
	public GroupRandomChat() {
	}

	/* Getter, Setter */
	public int getGroupRandomNum() {
		return groupRandomNum;
	}
	public void setGroupRandomNum(int groupRandomNum) {
		this.groupRandomNum = groupRandomNum;
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
		builder.append("GroupRandomChat [groupRandomNum=");
		builder.append(groupRandomNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class GroupRandomChat
