package domain;

/** group_member 테이블에 담을 정보 class */
public class GroupMember {

	/* 변수 */
	private int groupNum; // col : group_num
	private String memberId; // col : member_id
	
	/* 생성자 */
	public GroupMember() {
	}
	public GroupMember(int groupNum, String memberId) {
		super();
		this.groupNum = groupNum;
		this.memberId = memberId;
	}
	
	/* Getter, Setter */
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
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
		builder.append("GroupMember [groupNum=");
		builder.append(groupNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}

} // end of class GroupMember
