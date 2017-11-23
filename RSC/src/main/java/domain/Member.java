package domain;

/** member 테이블에 담을 정보 class */
public class Member {
	
	/* 변수 */
	private String memberId; // col : member_id
	private String memberPw; // col : member_pw
	private String memberNick; // col : member_nick
	private String memberImg; // col : member_img
	private String memberInterest; // col : member_interest
	private int memberInfoOpen; // col : member_info_open
	private String memberLogin; // col : member_login_time
	private String memberLogout; // col : member_logout_time
	private int memberPresentLogin; // col : member_present_login
	
	/* 생성자 */
	public Member() {
	}
	public Member(String memberId, String memberPw, String memberNick, String memberInterest, int memberInfoOpen,
			int memberPresentLogin) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberImg = "resources/img/profile.jpg";
		this.memberNick = memberNick;
		this.memberInterest = memberInterest;
		this.memberInfoOpen = memberInfoOpen;
		this.memberPresentLogin = memberPresentLogin;
	}
	public Member(String memberId, String memberPw, String memberNick, String memberImg, String memberInterest,
			int memberInfoOpen, String memberLogin, String memberLogout, int memberPresentLogin) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberNick = memberNick;
		this.memberImg = memberImg;
		this.memberInterest = memberInterest;
		this.memberInfoOpen = memberInfoOpen;
		this.memberLogin = memberLogin;
		this.memberLogout = memberLogout;
		this.memberPresentLogin = memberPresentLogin;
	}
	
	/* Getter, Setter */
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	
	public String getMemberInterest() {
		return memberInterest;
	}
	public void setMemberInterest(String memberInterest) {
		this.memberInterest = memberInterest;
	}
	
	public int getMemberInfoOpen() {
		return memberInfoOpen;
	}
	public void setMemberInfoOpen(int memberInfoOpen) {
		this.memberInfoOpen = memberInfoOpen;
	}
	
	public String getMemberLogin() {
		return memberLogin;
	}
	public void setMemberLogin(String memberLogin) {
		this.memberLogin = memberLogin;
	}
	
	public String getMemberLogout() {
		return memberLogout;
	}
	public void setMemberLogout(String memberLogout) {
		this.memberLogout = memberLogout;
	}
	
	public int getMemberPresentLogin() {
		return memberPresentLogin;
	}
	public void setMemberPresentLogin(int memberPresentLogin) {
		this.memberPresentLogin = memberPresentLogin;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Member [memberId=");
		builder.append(memberId);
		builder.append(", memberPw=");
		builder.append(memberPw);
		builder.append(", memberNick=");
		builder.append(memberNick);
		builder.append(", memberImg=");
		builder.append(memberImg);
		builder.append(", memberInterest=");
		builder.append(memberInterest);
		builder.append(", memberInfoOpen=");
		builder.append(memberInfoOpen);
		builder.append(", memberLogin=");
		builder.append(memberLogin);
		builder.append(", memberLogout=");
		builder.append(memberLogout);
		builder.append(", memberPresentLogin=");
		builder.append(memberPresentLogin);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class Member
