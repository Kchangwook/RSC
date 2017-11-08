package domain;

/** group_delete 테이블에 담을 정보 class */
public class GroupDelete {

	/* 변수 */
	private int groupNum; // col : group_num
	private int groupDelYes; // col : group_del_yes
	private int groupDelNo; // col : group_del_no
	private int groupDelAll; // col : group_del_all

	/* 생성자 */
	public GroupDelete() {
	}
	public GroupDelete(int groupNum, int groupDelYes, int groupDelNo, int groupDelAll) {
		super();
		this.groupNum = groupNum;
		this.groupDelYes = groupDelYes;
		this.groupDelNo = groupDelNo;
		this.groupDelAll = groupDelAll;
	}
	
	/* Getter, Setter */
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	
	public int getGroupDelYes() {
		return groupDelYes;
	}
	public void setGroupDelYes(int groupDelYes) {
		this.groupDelYes = groupDelYes;
	}
	
	public int getGroupDelNo() {
		return groupDelNo;
	}
	public void setGroupDelNo(int groupDelNo) {
		this.groupDelNo = groupDelNo;
	}
	
	public int getGroupDelAll() {
		return groupDelAll;
	}
	public void setGroupDelAll(int groupDelAll) {
		this.groupDelAll = groupDelAll;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("GroupDelete [groupNum=");
		builder.append(groupNum);
		builder.append(", groupDelYes=");
		builder.append(groupDelYes);
		builder.append(", groupDelNo=");
		builder.append(groupDelNo);
		builder.append(", groupDelAll=");
		builder.append(groupDelAll);
		builder.append("]");
		return builder.toString();
	}

} // end of class GroupDelete
