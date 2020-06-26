package kr.happy.jobkorea.manageC.model;

public class examModel {

	private String no ; // 강의번호
	private String re ; // 구분
	private String seq ; // 일련번호
	private String problem ; 
	
	private String answer ;
	
	private String answer1 ; // 보기가 answer...?
	private String answer2 ; 
	private String answer3 ; 
	private String answer4 ; 
	
	private String testname ; 
	private int testcnt ; 
	private int point ; 
	
	public examModel() {
		// 기본 생성자
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getRe() {
		return re;
	}

	public void setRe(String re) {
		this.re = re;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getProblem() {
		return problem;
	}

	public void setProblem(String problem) {
		this.problem = problem;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAnswer1() {
		return answer1;
	}

	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}

	public String getAnswer2() {
		return answer2;
	}

	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}

	public String getAnswer3() {
		return answer3;
	}

	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}

	public String getAnswer4() {
		return answer4;
	}

	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}

	public String getTestname() {
		return testname;
	}

	public void setTestname(String testname) {
		this.testname = testname;
	}

	public int getTestcnt() {
		return testcnt;
	}

	public void setTestcnt(int testcnt) {
		this.testcnt = testcnt;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}
}
