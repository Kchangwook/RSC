package domain;

/** group_join 테이블에 담을 정보 class */
public class GroupJoin {
	
	/* 변수 */
	private int groupNum; // col : group_num
	private String memberId; //  col : member_id

	/* 생성자 */
	public GroupJoin() {
	}	
	public GroupJoin(int groupNum, String memberId) {
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
		builder.append("GroupJoin [groupNum=");
		builder.append(groupNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append("]");
		return builder.toString();
	}
		
} // end of class GroupJoin
