package domain;

/** master 테이블에 담을 정보 class */
public class Master {

	/* 변수 */
	private String masterId; // col : master_id
	private String masterPw; // col : master_pw
	
	/* 생성자 */
	public Master() {
	}
	public Master(String masterId, String masterPw) {
		super();
		this.masterId = masterId;
		this.masterPw = masterPw;
	}
	
	/* Getter, Setter */
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	
	public String getMasterPw() {
		return masterPw;
	}
	public void setMasterPw(String masterPw) {
		this.masterPw = masterPw;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Master [masterId=");
		builder.append(masterId);
		builder.append(", masterPw=");
		builder.append(masterPw);
		builder.append("]");
		return builder.toString();
	}

} // end of class Master
