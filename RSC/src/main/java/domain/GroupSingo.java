package domain;

/** group_singo 테이블에 담을 정보 class */
public class GroupSingo {
	
	/* 변수 */
	private int groupSingoNum; // col : group_singo_num
	private int groupNum; // col : group_num
	private String groupSingoReason; // col : group_singo_reason
	
	/* 생성자 */
	public GroupSingo() {
	}
	public GroupSingo(int groupSingoNum, int groupNum, String groupSingoReason) {
		super();
		this.groupSingoNum = groupSingoNum;
		this.groupNum = groupNum;
		this.groupSingoReason = groupSingoReason;
	}
	
	/* Getter, Setter */
	public int getGroupSingoNum() {
		return groupSingoNum;
	}
	public void setGroupSingoNum(int groupSingoNum) {
		this.groupSingoNum = groupSingoNum;
	}
	
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	
	public String getGroupSingoReason() {
		return groupSingoReason;
	}
	public void setGroupSingoReason(String groupSingoReason) {
		this.groupSingoReason = groupSingoReason;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("GroupSingo [groupSingoNum=");
		builder.append(groupSingoNum);
		builder.append(", groupNum=");
		builder.append(groupNum);
		builder.append(", groupSingoReason=");
		builder.append(groupSingoReason);
		builder.append("]");
		return builder.toString();
	}
	
} // end of  GroupSingo
