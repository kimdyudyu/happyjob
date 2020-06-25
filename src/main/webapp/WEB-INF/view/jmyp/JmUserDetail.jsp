<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<!-- 일반 회원가입 -->
	<form id="RegisterForm" action="" method="post">
		<input type="hidden" name="action" id="action" value="">
		<input type="hidden" name="skillcode" id="skillcode" value="">
		<div id="layer1" class="layerPop layerType2" style="width: 1400px; overflow:auto;">
			<dl>
				<dt>
					<strong>회원 정보</strong>
				</dt>
				<dd class="content" overflow:auto;>
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>

						<tbody>
						<h1>기본 정보</h1>
							<tr>
								<th scope="row" style="width:100px;">아이디 <span class="font_red">*</span></th>
								<td><input type="text" class="idtxt" name="loginId" id="registerId" style="width:100px; height:20px;"/></td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">이름<span class="font_red">*</span></th>
								<td><input type="text" class="nmtxt" name="name" id="registerName" style="width:100px; height:20px;"/></td>
								<th scope="row" style="width:100px;">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="mailtxt" name="user_email" id="registerEmail" style="width:80px; height:20px;"/>
									@
									<input type="text" class="domaintxt" name="user_email" id="registerEmail2" style="width:100px; height:20px;"/>
									<!-- <select name="email" style="width:100px; height:22px;">
									    <option value="">이메일 선택</option>
									    <option value="네이버">naver.com</option>
									    <option value="구글">gmail.com</option>
									    <option value="다음">daum.net</option>
									</select> -->
								</td>
								<th scope="row" style="width:100px;">성별<span class="font_red">*</span></th>
								<td colspan="3">
									<select name="gender" id="userSex" style="width:100px; height:22px;">
									    <option value="">성별 선택</option>
									    <option value="남">남자</option>
									    <option value="여">여자</option>
									</select>	
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:80px;">등급<span class="font_red">*</span></th>
								<td colspan="1">
									<select name="level" style="width:100px; height:22px;">
									    <option value="">등급 선택</option>
									    <option value="초급">초급</option>
									    <option value="중급">중급</option>
									    <option value="고급">고급</option>
									    <option value="특급">특급</option>
									</select>
								</td>
								<th scope="row">참여 구분</th>
								<td>
									<!-- <p><input type="checkbox" id="siCheck"> <label for="siCheck">SI(상주프로젝트)</label></p>
									<p><input type="checkbox" id="smCheck"> <label for="smCheck">SM(상주프로젝트)</label></p>
									<p><input type="checkbox" id="solCheck"> <label for="solCheck">솔루션개발</label></p> -->
									<select id="selectDb" disabled>
										<option value="">
										선택
										</option>
										<option value="si">
										si
										</option>
										<option value="sm">
										sm
										</option>
										
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">생년 월일<span class="font_red">*</span></th>
								<td>
									<input type="text" class="date" name="date" id="date" style="width:100px; height:20px;"/>
								</td>
								<th scope="row">거주 지역<span class="font_red">*</span></th>
								<td>
									<select name="live" style="width:100px; height:22px;" id="area">
									    <option value="">지역 선택</option>
									    <option value="2">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
								</td>
								<th scope="row" style="width:100px;">연락처<span class="font_red">*</span></th>
								<td>
									<select name="phone" style="width:90px; height:22px;" id="tel1">
									    <option value="">번호 선택</option>
									    <option value="010">010</option>
									    <option value="011">011</option>
									    <option value="019">017</option>
									    <option value="017">019</option>
									</select>
									<input type="text" class="midNum" name="midNum" id="tel2" style="width:80px; height:20px;"/>
									<input type="text" class="lastNum" name="" id="tel3" style="width:80px; height:20px;"/>
								</td>
							</tr>

						</tbody>
					</table>
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						
						<tbody>
						<h1>경력 정보</h1>
							<tr>
								<th scope="row" style="width:100px;">제목</th>
								<td colspan="7">
									<input type="text" class="title" name="title" id="title" style="width:1180px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">희망 근무</th>
								
								<td>
									<input type="text" class="title" name="title" id="title" style="width:100px; height:20px;"/>
								</td>
								<!-- <td colspan="1">
									<select name="region1" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option 1value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
									<select name="region2" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
									<select name="region3" style="width:90px; height:22px;">
									    <option value="">지역 선택</option>
									    <option value="서울">서울</option>
									    <option value="경기">경기</option>
									    <option value="인천">인천</option>
									    <option value="강원도">강원도</option>
									    <option value="대전">대전</option>
									    <option value="광주">광주</option>
									    <option value="대구">대구</option>
									    <option value="부산">부산</option>
									</select>
								</td> -->
								<th scope="row" style="width:100px;">희망 연봉</th>
								<td colspan="2">
									<input type="text" class="price" name="price" id="salary" style="width:100px; height:20px;"/>
									<input type="checkbox" id="priceCheck"> <label for="priceCheck">협의 가능</label>
								</td>
							</tr>
							<tr>							
								<th scope="row" style="width:100px;">경력 기간</th>
								<!-- <td colspan="3">
									<select name="skillYear" style="width:90px; height:22px;">
									    <option value="">경력 선택</option>
									    <option value="없음">없음</option>
									    <option value="1~3">1~3</option>
									    <option value="3~5">3~5</option>
									    <option value="5~10">5~10</option>
									    <option value="10~15">10~15</option>
									    <option value="15~20">15~20</option>
									    <option value="20+">20+</option>
									</select>
									<label> 년</label>
									<select name="skillMon" style="width:90px; height:22px;">
									    <option value="">경력 선택</option>
									    <option value="없음">없음</option>
									    <option value="1">1</option>
									    <option value="2">2</option>
									    <option value="3">3</option>
									    <option value="4">4</option>
									    <option value="5">5</option>
									    <option value="6">6</option>
									    <option value="7">7</option>
									    <option value="8">8</option>
									    <option value="9">9</option>
									    <option value="10">10</option>
									    <option value="11">11</option>
									    <option value="12">12</option>
									</select>
									<label> 개월</label>
								</td> -->
								<td colspan="2">
									<input type="text" class="price" name="price" id="career" style="width:100px; height:20px;"/>
								</td>
								
							</tr>
							<tr>
								<th scope="row" style="width:100px;">전문 기술</th>
								<td colspan="3">
									<div class="abc">
										<span>
											<label>Language</label>
											<p><input type="checkbox" id="as400Check" value="AS400" name="skill_P"> <label for="as400Check">AS400</label></p>
											<p><input type="checkbox" id="cCheck" value="C" name="skill_P"> <label for="cCheck">C</label></p>
											<p><input type="checkbox" id="cppCheck" value="Cpp" name="skill_P"> <label for="cppCheck">C++</label></p>
											<p><input type="checkbox" id="csharpCheck" value="CSharp" name="skill_P"> <label for="csharpCheck">C#</label></p>
											<p><input type="checkbox" id="cobolCheck" value="COBOL" name="skill_P"> <label for="cobolCheck">COBOL</label></p>
											<p><input type="checkbox" id="delphiCheck" value="Delphi" name="skill_P"> <label for="delphiCheck">Delphi</label></p>
											<p><input type="checkbox" id="javaCheck" value="JAVA" name="skill_P"> <label for="javaCheck">JAVA</label></p>
											<p><input type="checkbox" id="vbCheck" value="VB" name="skill_P"> <label for="vbCheck">VB</label></p>
											<p><input type="checkbox" id="vcCheck" value="VC" name="skill_P"> <label for="vcCheck">VC</label></p>
											<p><input type="checkbox" id="netCheck" value="net" name="skill_P"> <label for="netCheck">.net</label></p>
											<p><input type="checkbox" id="pythonCheck" value="python" name="skill_P"> <label for="pythonCheck">python</label></p>
											<p><input type="checkbox" id="powerCheck" value="Power_Builder" name="skill_P"> <label for="powerCheck">Power Builder</label></p>
											<p><input type="checkbox" id="rCheck" value="R" name="skill_P"> <label for="rCheck">R</label></p>
										</span>
										<span>
											<label>WEB</label>
											<p><input type="checkbox" id="aspCheck" value="ASP" name="skill_P"> <label for="aspCheck">ASP</label></p>
											<p><input type="checkbox" id="jspCheck" value="JSP" name="skill_P"> <label for="jspCheck">JSP</label></p>
											<p><input type="checkbox" id="phpCheck" value="PHP" name="skill_P"> <label for="phpCheck">PHP</label></p>
											<p><input type="checkbox" id="xmlCheck" value="XML" name="skill_P"> <label for="xmlCheck">XML</label></p>
		 									<p><input type="checkbox" id="dhtmlCheck" value="DHTML" name="skill_P"> <label for="dhtmlCheck">DHTML</label></p>
											<p><input type="checkbox" id="miCheck" value="miPaltform" name="skill_P"> <label for="miCheck">miPaltform</label></p>
											<p><input type="checkbox" id="xCheck" value="xPaltform" name="skill_P"> <label for="xCheck">xPaltform</label></p>
											<p><input type="checkbox" id="nexaCheck" value="Nexacro" name="skill_P"> <label for="nexaCheck">Nexacro</label></p>
										</span>
										<span>
											<label>OS</label>
											<p><input type="checkbox" id="unixCheck" value="UNIX" name="skill_P"> <label for="unixCheck">UNIX</label></p>
											<p><input type="checkbox" id="linuxCheck" value="linux" name="skill_P"> <label for="linuxCheck">LINUX</label></p>
											<p><input type="checkbox" id="macCheck" value="MAC" name="skill_P"> <label for="macCheck">MAC</label></p>
											<p><input type="checkbox" id="mvcCheck" value="MVC" name="skill_P"> <label for="mvcCheck">MVC</label></p>
		 									<p><input type="checkbox" id="solCheck" value="SOLARIS" name="skill_P"> <label for="solCheck">SOLARIS</label></p>
											<p><input type="checkbox" id="winCheck" value="WINDOWS" name="skill_P"> <label for="winCheck">WINDOWS</label></p>
											<p><input type="checkbox" id="winServerCheck" value="WINDIWS_SERVER" name="skill_P"> <label for="winServerCheck">WINDIWS SERVER</label></p>
										</span>
										<span>
											<label>FrameWork</label>
											<p><input type="checkbox" id="springCheck" value="Spring" name="skill_P"> <label for="springCheck">Spring</label></p>
											<p><input type="checkbox" id="egovCheck" value="eGov" name="skill_P"> <label for="egovCheck">eGov</label></p>
											<p><input type="checkbox" id="strutsCheck" value="Struts" name="skill_P"> <label for="strutsCheck">Struts</label></p>
											<p><input type="checkbox" id="jqueryCheck" value="jQuery" name="skill_P"> <label for="jqueryCheck">jQuery</label></p>
										</span>
										<span>
											<label>DB</label>
											<p><input type="checkbox" id="accCheck" value="Access" name="skill_P"> <label for="accCheck">Access</label></p>
											<p><input type="checkbox" id="db2Check" value="DB2" name="skill_P"> <label for="db2Check">DB2</label></p>
											<p><input type="checkbox" id="mixCheck" value="Informix" name="skill_P"> <label for="mixCheck">Informix</label></p>
											<p><input type="checkbox" id="orclCheck" value="ORACLE" name="skill_P"> <label for="orclCheck">ORACLE</label></p>
											<p><input type="checkbox" id="msCheck" value="MS_SQL" name="skill_P"> <label for="msCheck">MS SQL</label></p>
											<p><input type="checkbox" id="myCheck" value="MY_SQL" name="skill_P"> <label for="myCheck">MY SQL</label></p>
											<p><input type="checkbox" id="sybaseCheck" value="Sybase" name="skill_P"> <label for="sybaseCheck">Sybase</label></p>
											<p><input type="checkbox" id="mariaCheck" value="MariaDB" name="skill_P"> <label for="mariaCheck">MariaDB</label></p>
											<p><input type="checkbox" id="tibCheck" value="Tibero" name="skill_P"> <label for="tibCheck">Tibero</label></p>
										</span>
										<span>
											<label>Network</label>
											<p><input type="checkbox" id="routerCheck" value="Cisco_Router" name="skill_P"> <label for="routerCheck">Cisco Router</label></p>
											<p><input type="checkbox" id="swCheck" value="Cisco_SW" name="skill_P"> <label for="swCheck">Cisco S/W</label></p>
											<p><input type="checkbox" id="corbaCheck" value="CORBA" name="skill_P"> <label for="corbaCheck">CORBA</label></p>
											<p><input type="checkbox" id="lanCheck" value="LAN" name="skill_P"> <label for="lanCheck">LAN</label></p>
											<p><input type="checkbox" id="iotCheck" value="iot" name="skill_P"> <label for="iotCheck">iot</label></p>
										</span>
										<span>
											<label>WebServer/WAS</label>
											<p><input type="checkbox" id="tomCheck" value="tom" name="skill_P"> <label for="tomCheck">Tomcat</label></p>
											<p><input type="checkbox" id="jeusCheck" value="jeus" name="skill_P"> <label for="jeusCheck">JEUS</label></p>
											<p><input type="checkbox" id="sphereCheck" value="sphere" name="skill_P"> <label for="sphereCheck">WebSphere</label></p>
											<p><input type="checkbox" id="logicCheck" value="logic" name="skill_P"> <label for="logicCheck">WebLogic</label></p>
											<p><input type="checkbox" id="iisCheck" value="iis" name="skill_P"> <label for="iisCheck">IIS</label></p>
											<p><input type="checkbox" id="jbossCheck" value="jboss" name="skill_P"> <label for="jbossCheck">JBoss</label></p>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">추가기술</th>
								<td colspan="7">
									<input type="text" class="add" name="add" id="add" style="width:800px; height:20px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">경력내용</th>
								<td colspan="7">
									<input type="text" class="career" name="career" id="career" style="width:1180px; height:50px;"/>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width:100px;">특이사항</th>
								<td colspan="7">
									<input type="text" class="speciality" name="speciality" id="speciality" style="width:1180px; height:50px;"/>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="btn_areaC mt30">
						<!-- <a href="javascript:CompleteRegister();" class="btnType blue"
							id="RegisterCom" name="btn"> <span>회원가입 완료</span></a> --> <a href=""
							class="btnType gray" id="btnCloseLsmCod" name="btn">
							<span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
	