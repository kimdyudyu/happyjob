package kr.happy.jobkorea.jmli.model;

import java.util.Date;

public class developerModel {

	private String loginID;			// 아이디
	private String user_type;		// 유저 타입  C : 기업회원, D : 일반회원, A : 관리자
	private String password;		// 비밀번호
	private String name;			// 이름
	private String email;			// 이메일 ID
	private String email_cop;		// 이메일 도메인
	private String sex;				// 성별
	private String birthday;		// 생년월일
	private String area;			// 지역
	private String tel1;			// 번호 앞 3자리
	private String tel2;			// 중간 번호
	private String tel3;			// 끝 번호
	private String user_position;	// 참여 구분 
	private int salary;				// 희망 연봉
	private String consult_yn;		// 연봉 협의 여부
	private String career_year;		// 경력기간 연차
	private String career_mm;		// 경력기간 월
	private String skill_add;		// 전무기술 여부
	private String singular_facts;	// ???
	private String comp_name;		// 회사명
	private String mgr_name;		// 담당자명
	private String comp_birthday;	// 창립일
	private String mgr_tel;			// 담당자 번호
	private String comp_info;		// 회사정보
	private Date join_date;			// 가입일
	private String updateId;		// 변경자 아이디
	private Date update_date;		// 변경일
	private String skill;				// 기술
	private String career_contents; //경력사항
	
	public String getCareer_contents() {
		return career_contents;
	}
	public void setCareer_contents(String career_contents) {
		this.career_contents = career_contents;
	}
	private int currentPage;		
	private int pageSize;			
	private int pageindex;			
	private int tot_cnt;
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String eamil) {
		this.email = eamil;
	}
	public String getEmail_cop() {
		return email_cop;
	}
	public void setEmail_cop(String email_cop) {
		this.email_cop = email_cop;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getUser_position() {
		return user_position;
	}
	public void setUser_position(String user_position) {
		this.user_position = user_position;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getConsult_yn() {
		return consult_yn;
	}
	public void setConsult_yn(String consult_yn) {
		this.consult_yn = consult_yn;
	}
	public String getCareer_year() {
		return career_year;
	}
	public void setCareer_year(String career_year) {
		this.career_year = career_year;
	}
	public String getCareer_mm() {
		return career_mm;
	}
	public void setCareer_mm(String career_mm) {
		this.career_mm = career_mm;
	}
	public String getSkill_add() {
		return skill_add;
	}
	public void setSkill_add(String skill_add) {
		this.skill_add = skill_add;
	}
	public String getSingular_facts() {
		return singular_facts;
	}
	public void setSingular_facts(String singular_facts) {
		this.singular_facts = singular_facts;
	}
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public String getMgr_name() {
		return mgr_name;
	}
	public void setMgr_name(String mgr_name) {
		this.mgr_name = mgr_name;
	}
	public String getComp_birthday() {
		return comp_birthday;
	}
	public void setComp_birthday(String comp_birthday) {
		this.comp_birthday = comp_birthday;
	}
	public String getMgr_tel() {
		return mgr_tel;
	}
	public void setMgr_tel(String mgr_tel) {
		this.mgr_tel = mgr_tel;
	}
	public String getComp_info() {
		return comp_info;
	}
	public void setComp_info(String comp_info) {
		this.comp_info = comp_info;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getUpdateId() {
		return updateId;
	}
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageindex() {
		return pageindex;
	}
	public void setPageindex(int pageindex) {
		this.pageindex = pageindex;
	}
	public int getTot_cnt() {
		return tot_cnt;
	}
	public void setTot_cnt(int tot_cnt) {
		this.tot_cnt = tot_cnt;
	}
	
	
	
	
	
}
