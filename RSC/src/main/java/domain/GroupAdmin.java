package domain;

/** group_admin 테이블에 담을 정보 class */
public class GroupAdmin {

	/* 변수 */
	private String memberId; // col : member_id
	private int groupNum; // col : group_num
	
	/* 생성자 */
	public GroupAdmin() {
	}
	public GroupAdmin(String memberId, int groupNum) {
		super();
		this.memberId = memberId;
		this.groupNum = groupNum;
	}
	
	/* Getter, Setter */
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("GroupAdmin [memberId=");
		builder.append(memberId);
		builder.append(", groupNum=");
		builder.append(groupNum);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class GroupAdmin
