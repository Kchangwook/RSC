package domain;

/** groups 테이블에 담을 정보 class */
public class Groups {
	
	/* 변수 */
	private int groupNum; // col : group_num
	private String groupName; // col : group_name
	private String groupImg; // col : group_img
	private String groupInfo; // col : group_info
	private int groupInfoOpen; // col : group_info_open
	private String groupInterest; // col : group_interest
	private int groupSingoCnt; // col : group_singo_cnt
	
	/* 생성자 */
	public Groups() {
	}
	public Groups(int groupNum, String groupName, String groupImg, String groupInfo, int groupInfoOpen,
			String groupInterest, int groupSingoCnt) {
		super();
		this.groupNum = groupNum;
		this.groupName = groupName;
		this.groupImg = groupImg;
		this.groupInfo = groupInfo;
		this.groupInfoOpen = groupInfoOpen;
		this.groupInterest = groupInterest;
		this.groupSingoCnt = groupSingoCnt;
	}
	public Groups(String groupName, String groupInfo, int groupInfoOpen,
			String groupInterest) {
		super();
		this.groupName = groupName;
		this.groupImg = "resources/img/group.jpg";
		this.groupInfo = groupInfo;
		this.groupInfoOpen = groupInfoOpen;
		this.groupInterest = groupInterest;
	}
	
	/* Getter, Setter */
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getGroupImg() {
		return groupImg;
	}
	public void setGroupImg(String groupImg) {
		this.groupImg = groupImg;
	}
	
	public String getGroupInfo() {
		return groupInfo;
	}
	public void setGroupInfo(String groupInfo) {
		this.groupInfo = groupInfo;
	}
	
	public int getGroupInfoOpen() {
		return groupInfoOpen;
	}
	public void setGroupInfoOpen(int groupInfoOpen) {
		this.groupInfoOpen = groupInfoOpen;
	}
	
	public String getGroupInterest() {
		return groupInterest;
	}
	public void setGroupInterest(String groupInterest) {
		this.groupInterest = groupInterest;
	}
	
	public int getGroupSingoCnt() {
		return groupSingoCnt;
	}
	public void setGroupSingoCnt(int groupSingoCnt) {
		this.groupSingoCnt = groupSingoCnt;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Group [groupNum=");
		builder.append(groupNum);
		builder.append(", groupName=");
		builder.append(groupName);
		builder.append(", groupImg=");
		builder.append(groupImg);
		builder.append(", groupInfo=");
		builder.append(groupInfo);
		builder.append(", groupInfoOpen=");
		builder.append(groupInfoOpen);
		builder.append(", groupInterest=");
		builder.append(groupInterest);
		builder.append(", groupSingoCnt=");
		builder.append(groupSingoCnt);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class Group
