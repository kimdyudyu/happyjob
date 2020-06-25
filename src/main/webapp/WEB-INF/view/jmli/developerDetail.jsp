<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 공지사항 상세보기 모달팝업 -->
	<form id="detailNotice" action="" >
	<div id="noticeDetailvue" class="layerPop layerType2" style="width: 1300px; hight: 1000px; overflow-y:auto;">
	
		<dl>
			<dt>
				<strong>개발자 정보 상세보기 </strong>
			</dt>
			<dd class="content">
			
				<div >
					<table class="row" id="detailtable"><!--  id="detailtable"  -->
					
					
						<caption>caption</caption>
						
						<colgroup>
							<col width="120px">
							<col width="120px">
							<col width="120px">
							<col width="120px">
						</colgroup>
						
                  <tbody>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">아이디</th>
                        <td><input type="text" class="idtxt" name="loginID" id="loginID" style="width:100px; height:20px;" v-model="loginID" readOnly/></td>
                        <th scope="row" style="width:300px;" colspan="2">성별</th>
                        <td>
                           <select id="gender" name="gender" style="width:100px; height:22px;" v-model="sex" disabled>
                               <option value="">성별 선택</option>
                               <option value="남">남자</option>
                               <option value="여">여자</option>
                           </select>   
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">이름<span class="font_red">*</span></th>
                        <td><input type="text" class="nmtxt" name="registerName" id="registerName" style="width:100px; height:20px;" v-model="name" readOnly/></td>
                        <th scope="row" style="width:300px;" colspan="2">이메일</th>
                        <td colspan="3">
                           <input type="text" class="mailtxt" name="email" id="email" style="width:80px; height:20px;" v-model="email" readOnly/>
                           @
                           <input type="text" class="domaintxt" name="email_cop" id="email_cop" style="width:100px; height:20px;" v-model="email_cop" readOnly/>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">등급</th>
                        <td colspan="1">
                           <select name="skill" style="width:100px; height:22px;" v-model="skill" disabled>
                               <option value="">등급 선택</option>
                               <option value="1">초급</option>
                               <option value="2">중급</option>
                               <option value="3">고급</option>
                               <option value="4">특급</option>
                           </select>
                        </td>
                        <th scope="row" colspan="2">직군 분류</th>
                        <td>
                           <select name="position" style="width:100px; height:22px;" v-model="user_position" disabled>
                               <option value="">등급 선택</option>
                               <option value="si">SI</option>
                               <option value="sm">SM</option>
                               <option value="Solution">솔루션개발</option>
                           </select>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" colspan="2">생년 월일</th>
                        <td>
                           <input type="text" class="date" name="date" id="date" style="width:100px; height:20px;" v-model="birthday" readOnly/>
                        </td>
                        <th scope="row" colspan="2">거주 지역<span class="font_red">*</span></th>
                        <td>
                           <select name="live" style="width:100px; height:22px;" v-model="area" disabled>
                               <option value="">지역 선택</option>
                               <option value="2">서울</option>
                               <option value="31">경기</option>
                               <option value="32">인천</option>
                               <option value="42">대전</option>
                               <option value="44">세종</option>
                               <option value="51">부산</option>
                               <option value="52">울산</option>
                               <option value="53">대구</option>
                               <option value="64">제주</option>
                           </select>
                        </td>
                        <th scope="row" colspan="2">연락처</th>
                        <td>
                           <input type="text" class="firstNum" name="firstNum" id="firstNum" style="width:80px; height:20px;" v-model="tel1" readOnly/>
                           <input type="text" class="midNum" name="midNum" id="midNum" style="width:80px; height:20px;" v-model="tel2" readOnly/>
                           <input type="text" class="lastNum" name="lastNum" id="lastNum" style="width:80px; height:20px;" v-model="tel3" readOnly/>
                        </td>
                     </tr>
                     
                       <tr>                     
                        <th scope="row" colspan="2">경력 기간</th>
                        <td colspan="3">
                        	<input type="text" class="career_year" name="career_year" id="career_year" style="width:80px; height:20px;" v-model="career_year" readOnly />
                            <label> 년</label>
                            <input type="text" class="career_mm" name="career_mm" id="career_mm" style="width:80px; height:20px;" v-model="career_mm" readOnly/>
                            <label> 개월</label>
                        </td>
                        <th scope="row" style="width:300px;" colspan="2">희망 연봉</th>
                        <td>
                           <input type="text" class="price" name="price" id="price" style="width:100px; height:20px;" v-model = "salary" readOnly/>
                           <input type="checkbox" name="priceCheck" id="priceCheck" value="1" disabled/> <label for="priceCheck">협의 가능</label>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">전문 기술</th>
                        <td>
                           <div class="abc">
                              <span>
                                 <p><label>Language</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="as400Check" value="Laas400" disabled> <label for="as400Check">AS400</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="cCheck" value="Lac" disabled> <label for="cCheck">C</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="cppCheck" value="Lacpp" disabled> <label for="cppCheck">C++</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="csharpCheck" value="Lacc" disabled> <label for="csharpCheck">C#</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="cobolCheck" value="Lacobol" disabled> <label for="cobolCheck">COBOL</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="delphiCheck" value="Ladp" disabled> <label for="delphiCheck">Delphi</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="javaCheck" value="Lajava" disabled> <label for="javaCheck">JAVA</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="vbCheck" value="Lavb" disabled> <label for="vbCheck">VB</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="vcCheck" value="Lavc" disabled> <label for="vcCheck">VC</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="netCheck" value="Ladatnet" disabled> <label for="netCheck">.net</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="pythonCheck" value="Lapython" disabled> <label for="pythonCheck">python</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="powerCheck" value="LaPB" disabled> <label for="powerCheck">Power Builder</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="rCheck" value="Lar" disabled> <label for="rCheck">R</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <p><label>WEB</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="aspCheck" value="WEasp" disabled> <label for="aspCheck">ASP</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="jspCheck" value="WEjsp" disabled> <label for="jspCheck">JSP</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="phpCheck" value="WEphp" disabled> <label for="phpCheck">PHP</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="xmlCheck" value="WExml" disabled> <label for="xmlCheck">XML</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="dhtmlCheck" value="WEdhtml" disabled> <label for="dhtmlCheck">DHTML</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="miCheck" value="WEmp" disabled> <label for="miCheck">miPaltform</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="xCheck" value="WExp" disabled> <label for="xCheck">xPaltform</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="nexaCheck" value="WEnc" disabled> <label for="nexaCheck">Necacro</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <label>OS</label>
                                 <p><input type="checkbox" name="skillcheck" id="unixCheck" value="OSunix" disabled> <label for="unixCheck">UNIX</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="linuxCheck" value="OSlinux" disabled> <label for="linuxCheck">LINUX</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="macCheck" value="OSmac" disabled> <label for="macCheck">MAC</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="mvcCheck" value="OSmvc" disabled> <label for="mvcCheck">MVC</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="solCheck" value="OSsol" disabled> <label for="solCheck">SOLARIS</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="winCheck" value="OSwin" disabled> <label for="winCheck">WINDOWS</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="winServerCheck" value="OSwins" disabled> <label for="winServerCheck">WINDIWS SERVER</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <label>FrameWork</label>
                                 <p><input type="checkbox" name="skillcheck" id="springCheck" value="frspring" disabled> <label for="springCheck">Spring</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="egovCheck" value="freg" disabled> <label for="egovCheck">eGov</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="strutsCheck" value="frst" disabled> <label for="strutsCheck">Struts</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="jqueryCheck" value="frjq" disabled> <label for="jqueryCheck">jQuery</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <label>DB</label>
                                 <p><input type="checkbox" name="skillcheck" id="accCheck" value="DBac" disabled> <label for="accCheck">Access</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="mixCheck" value="DBinfomix" disabled> <label for="mixCheck">Informix</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="orclCheck" value="DBoracle" disabled> <label for="orclCheck">ORACLE</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="msCheck" value="DBmssql" disabled> <label for="msCheck">MS SQL</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="myCheck" value="DBmysql" disabled> <label for="myCheck">MY SQL</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="sybaseCheck" value="DBsybase" disabled> <label for="sybaseCheck">Sybase</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="mariaCheck" value="DBmariadb" disabled> <label for="mariaCheck">MariaDB</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="tibCheck" value="DBtibero" disabled> <label for="tibCheck">Tibero</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <label>Network</label>
                                 <p><input type="checkbox" name="skillcheck" id="routerCheck" value="necr" disabled> <label for="routerCheck">Cisco Router</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="swCheck" value="necs" disabled> <label for="swCheck">Cisco S/W</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="corbaCheck" value="necorba" disabled> <label for="corbaCheck">CORBA</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="lanCheck" value="nelan" disabled> <label for="lanCheck">LAN</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="iotCheck" value="neiot" disabled> <label for="iotCheck">iot</label></p>
                              </span>
                              </div>
                              </td>
                              <td>
                               <div class="abc">
                              <span>
                                 <label>WebServer/WAS</label>
                                 <p><input type="checkbox" name="skillcheck" id="tomCheck" value="wetomcat" disabled> <label for="tomCheck">Tomcat</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="jeusCheck" value="wejeus" disabled> <label for="jeusCheck">JEUS</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="sphereCheck" value="wewebsphere" disabled> <label for="sphereCheck">WebSphere</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="logicCheck" value="weweblogic" disabled> <label for="logicCheck">WebLogic</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="iisCheck" value="weiis" disabled> <label for="iisCheck">IIS</label></p>
                                 <p><input type="checkbox" name="skillcheck" id="jbossCheck" value="wejboss" disabled> <label for="jbossCheck">JBoss</label></p>
                              </span>
                           </div>
                           </td>
                        
                     </tr>
                      <tr>
                        <th scope="row"  style="width:300px;" colspan="2">추가기술</th>
                        <td colspan="7">
                           <input type="text" class="add" name="add" id="add" style="width:800px; height:20px;" v-model="skill_add" readOnly/>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">경력내용</th>
                        <td colspan="7">
                           <input type="text" class="career" name="career" id="career" style="width:1180px; height:50px;" v-model="career_contents" readOnly/>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="2">특이사항</th>
                        <td colspan="7">
                           <input type="text" class="speciality" name="speciality" id="speciality" style="width:1180px; height:50px;" v-model="singular_facts" readOnly/>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" style="width:300px;" colspan="5">메시지 보내기</th>
                        <td colspan="7">
                           <input type="text" class="message" name="message" id="message" v-model="message" style="width:1180px; height:50px;"/>
                        </td>
                     </tr>
                  </tbody>
					
					</table>
				</div>
				<div class="btn_areaC mt30" id="updateoption">
					
						<a href="javascript:sendMessage()" class="btnType blue" ><span>메세지 보내기</span></a>
								
						<a href="javascript:cancle()" class="btnType gray" ><span>뒤로가기</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	</form>