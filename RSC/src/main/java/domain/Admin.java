package domain;

/** admin 테이블에 담을 정보 class */
public class Admin {
	
	/* 변수 */ 
	private String adminId; // col : admin_id
	private String adminPw; // col : admin_pw
	
	/* 생성자 */
	public Admin() {
	}
	public Admin(String adminId, String adminPw) {
		super();
		this.adminId = adminId;
		this.adminPw = adminPw;
	}
	
	/* Getter, Setter */
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Admin [adminId=");
		builder.append(adminId);
		builder.append(", adminPw=");
		builder.append(adminPw);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class Admin
