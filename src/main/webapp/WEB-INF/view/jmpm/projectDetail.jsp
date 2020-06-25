<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 프로젝트 상세보기 모달팝업 -->
<form id="detailtable_p" action="">
<div id="noticeDetailvue_p" class="layerPop layerType2"
		style="width: 1300px; hight: 1000px; overflow-y: scroll;">
	
		<input type="hidden" name="action" id="daction" value=""> <input
			type="hidden" name="nt_seq" id="dnt_seq" value="">
		<dl>
			<dt>
				<strong>프로젝트 상세정보 </strong>
			</dt>
			<dd class="content">

				<div>
					<table class="row" id="">
						<!--  id="detailtable"  -->


						<caption>caption</caption>

						<colgroup>
							<col width="120px">
							<col width="120px">
							<col width="120px">
							<col width="120px">
						</colgroup>
						<!-- <tbody> -->

						<tbody>
							<tr>
								<th style="width: 800px;" colspan="4" scope="row">프로젝트 명</th>
								<td colspan="4"><input type="text" name="loginID"
									id="loginID" style="width: 100%; height: 20px;" class="idtxt" v-model="P_project_name"></td>
							</tr>
							<tr>
								<th scope="row" colspan="3" style="width: 300px;">지역</th>
									<td>
										<select id="p_searchareaDetail" name="p_searchareaDetail"
											style="width: 100px; height: 22px;" v-model="p_searchareaDetail">
										</select>
									</td>
								<th scope="row" colspan="1" style="width: 100px;">직무</th>
								<td><select id="p_searchjobDetail" name="p_searchjobDetail"
									style="width: 100px; height: 22px;" v-model="p_searchjobDetail">
								</select></td>
								<th>산업</th>
								<td>
									<select id="p_searchindDetail" name="p_searchindDetail"
										style="width: 100px; height: 22px;" v-model="p_searchindDetail">
									</select>
								</td>

							</tr>
							<tr>
								<th scope="row" colspan="3" style="width: 300px;">구분</th>
								<td><select id="p_searchSWCD" name="p_searchSWCD"
									style="width: 100px; height: 22px;" v-model="p_searchSWCD">

								</select></td>

							</tr>

					<tr>
								<th scope="row" style="width: 300px;" colspan="2">전문 기술</th>
								<td>
									<div id="Language">
										<span>
											<p>
												<label>Language</label>
											</p>
											<p>
												<input type="checkbox" id="as400Check" name="skill_P" value="as400"> 
												<label for="as400Check">AS400</label>
											</p>
											<p>
												<input type="checkbox" id="cCheck" name="skill_P" value="c"> <label
													for="cCheck">C</label>
											</p>
											<p>
												<input type="checkbox" id="cppCheck" name="skill_P" value="cpp"> <label
													for="cppCheck">C++</label>
											</p>
											<p>
												<input type="checkbox" id="csharpCheck" name="skill_P" value="cc"> <label
													for="csharpCheck">C#</label>
											</p>
											<p>
												<input type="checkbox" id="cobolCheck" name="skill_P" value="cobol"> <label
													for="cobolCheck">COBOL</label>
											</p>
											<p>
												<input type="checkbox" id="delphiCheck" name="skill_P" value="dp"> <label
													for="delphiCheck">Delphi</label>
											</p>
											<p>
												<input type="checkbox" id="javaCheck" name="skill_P" value="java"> <label
													for="javaCheck">JAVA</label>
											</p>
											<p>
												<input type="checkbox" id="vbCheck" name="skill_P" value="vb"> <label
													for="vbCheck">VB</label>
											</p>
											<p>
												<input type="checkbox" id="vcCheck" name="skill_P" value="vc"> <label
													for="vcCheck">VC</label>
											</p>
											<p>
												<input type="checkbox" id="netCheck" name="skill_P" value="datnet"> <label
													for="netCheck">.net</label>
											</p>
											<p>
												<input type="checkbox" id="pythonCheck" name="skill_P" value="python"> <label
													for="pythonCheck">python</label>
											</p>
											<p>
												<input type="checkbox" id="powerCheck" name="skill_P" value="PB"> <label
													for="powerCheck">Power Builder</label>
											</p>
											<p>
												<input type="checkbox" id="rCheck" name="skill_P" value ="r"> <label
													for="rCheck">R</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="WEB">
										<span>
											<p>
												<label>WEB</label>
											</p>
											<p>
												<input type="checkbox" id="aspCheck" name="skill_P" value="asp"> <label
													for="aspCheck">ASP</label>
											</p>
											<p>
												<input type="checkbox" id="jspCheck" name="skill_P" value="jsp"> <label
													for="jspCheck">JSP</label>
											</p>
											<p>
												<input type="checkbox" id="phpCheck" name="skill_P" value="php"> <label
													for="phpCheck">PHP</label>
											</p>
											<p>
												<input type="checkbox" id="xmlCheck" name="skill_P" value="xml"> <label
													for="xmlCheck">XML</label>
											</p>
											<p>
												<input type="checkbox" id="dhtmlCheck" name="skill_P" value="dhtml"> <label
													for="dhtmlCheck">DHTML</label>
											</p>
											<p>
												<input type="checkbox" id="miCheck" name="skill_P" value="mp"> <label
													for="miCheck">miPaltform</label>
											</p>
											<p>
												<input type="checkbox" id="xCheck" name="skill_P" value="xp"> <label
													for="xCheck">xPaltform</label>
											</p>
											<p>
												<input type="checkbox" id="nexaCheck" name="skill_P" value="nc"> <label
													for="nexaCheck">Necacro</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="OS">
										<span> 
											<label>OS</label>
											<p>
												<input type="checkbox" id="unixCheck" name="skill_P" value="unix"> <label
													for="unixCheck">UNIX</label>
											</p>
											<p>
												<input type="checkbox" id="linuxCheck" name="skill_P" value="linux"> <label
													for="linuxCheck">LINUX</label>
											</p>
											<p>
												<input type="checkbox" id="macCheck" name="skill_P" value="mac"> <label
													for="macCheck">MAC</label>
											</p>
											<p>
												<input type="checkbox" id="mvcCheck" name="skill_P" value="mvc"> <label
													for="mvcCheck">MVC</label>
											</p>
											<p>
												<input type="checkbox" id="solCheck" name="skill_P" value="sol"> <label
													for="solCheck">SOLARIS</label>
											</p>
											<p>
												<input type="checkbox" id="winCheck" name="skill_P" value="win"> <label
													for="winCheck">WINDOWS</label>
											</p>
											<p>
												<input type="checkbox" id="winServerCheck" name="skill_P" value="wins"> <label
													for="winServerCheck">WINDIWS SERVER</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="FrameWork">
										<span> 
										<label>FrameWork</label>
											<p>
												<input type="checkbox" id="springCheck" name="skill_P" value="spring"> <label
													for="springCheck">Spring</label>
											</p>
											<p>
												<input type="checkbox" id="egovCheck" name="skill_P" value="eg"> <label
													for="egovCheck">eGov</label>
											</p>
											<p>
												<input type="checkbox" id="strutsCheck" name="skill_P" value="st"> <label
													for="strutsCheck">Struts</label>
											</p>
											<p>
												<input type="checkbox" id="jqueryCheck" name="skill_P" value="jq"> <label
													for="jqueryCheck">jQuery</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="DB">
										<span> 
										<label>DB</label>
											<p>
												<input type="checkbox" id="accCheck" name="skill_P" value="ac"> <label
													for="accCheck">Access</label>
											</p>
											<p>
												<input type="checkbox" id="db2Check" name="skill_P" value="db2"> <label
													for="db2Check">DB2</label>
											</p>
											<p>
												<input type="checkbox" id="mixCheck" name="skill_P" value="informix"> <label
													for="mixCheck">Informix</label>
											</p>
											<p>
												<input type="checkbox" id="orclCheck" name="skill_P" value="oracle"> <label
													for="orclCheck">ORACLE</label>
											</p>
											<p>
												<input type="checkbox" id="msCheck" name="skill_P" value="mssql"> <label
													for="msCheck">MS SQL</label>
											</p>
											<p>
												<input type="checkbox" id="myCheck" name="skill_P" value="mysql"> <label
													for="myCheck">MY SQL</label>
											</p>
											<p>
												<input type="checkbox" id="sybaseCheck" name="skill_P" value="sybase"> <label
													for="sybaseCheck">Sybase</label>
											</p>
											<p>
												<input type="checkbox" id="mariaCheck" name="skill_P" value="mariadb"> <label
													for="mariaCheck">MariaDB</label>
											</p>
											<p>
												<input type="checkbox" id="tibCheck" name="skill_P" value="tibero"> <label
													for="tibCheck">Tibero</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="NetWork">
										<span> 
										<label>Network</label>
											<p>
												<input type="checkbox" id="routerCheck" name="skill_P" value="cr"> <label
													for="routerCheck">Cisco Router</label>
											</p>
											<p>
												<input type="checkbox" id="swCheck" name="skill_P" value="cs"> <label
													for="swCheck">Cisco S/W</label>
											</p>
											<p>
												<input type="checkbox" id="corbaCheck" name="skill_P" value="cobra"> <label
													for="corbaCheck">CORBA</label>
											</p>
											<p>
												<input type="checkbox" id="lanCheck" name="skill_P" value="lan"> <label
													for="lanCheck">LAN</label>
											</p>
											<p>
												<input type="checkbox" id="iotCheck" name="skill_P" value="iot"> <label
													for="iotCheck">iot</label>
											</p>
										</span>
									</div>
								</td>
								<td>
									<div id="webServer">
										<span> 
											<label>WebServer/WAS</label>
											<p>
												<input type="checkbox" id="tomCheck" name="skill_P" value="tomcat"> <label
													for="tomCheck">Tomcat</label>
											</p>
											<p>
												<input type="checkbox" id="jeusCheck" name="skill_P" value="jeus"> <label
													for="jeusCheck">JEUS</label>
											</p>
											<p>
												<input type="checkbox" id="sphereCheck" name="skill_P" value="websphere"> <label
													for="sphereCheck">WebSphere</label>
											</p>
											<p>
												<input type="checkbox" id="logicCheck" name="skill_P" value="weblogic"> <label
													for="logicCheck">WebLogic</label>
											</p>
											<p>
												<input type="checkbox" id="iisCheck" name="skill_P" value="iis"> <label
													for="iisCheck">IIS</label>
											</p>
											<p>
												<input type="checkbox" id="jbossCheck" name="skill_P" value="jboss"> <label
													for="jbossCheck">JBoss</label>
											</p>
										</span>
									</div>
								</td>

							</tr>
					

							<tr>
								<th scope="row" colspan="3" style="width: 300px;">기술등급</th>
								<td colspan="1">초급&nbsp; <input type="text" name="add"
									id="addB" class="add" style="width: 50px; height: 20px;" v-model="p_begin">
									&nbsp;명
								</td>
								<td colspan="1">중급&nbsp; <input type="text" name="add"
									id="addM" class="add" style="width: 50px; height: 20px;" v-model="p_middle">
									&nbsp;명
								</td>
								<td colspan="1">고급&nbsp; <input type="text" name="add"
									id="addH" class="add" style="width: 50px; height: 20px;" v-model="p_high">
									&nbsp;명
								</td>
								<td colspan="1">특급&nbsp; <input type="text" name="add"
									id="addS" class="add" style="width: 50px; height: 20px;" v-model="p_special">
									&nbsp;명
								</td>
							</tr>

							<tr>
								<th colspan="3" style="width: 300px;">근무기간</th> 
								<td colspan="3">
									<input type="text" id="pService" data-date-format='yyyy-mm-dd' > ~ <input type="text" id="pServiceEnd" data-date-format='yyyy-mm-dd'>
								</td>
								<th colspan="1" style="width: 300px;">접수기간</th> 
								<td colspan="2">
									<input type="text" id="pSign" data-date-format='yyyy-mm-dd'> ~ <input type="text" id="pSignEnd" data-date-format='yyyy-mm-dd'>
								</td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;" colspan="2">상세설명</th>
								<td colspan="7"><input type="text" class="add" name="add"
									id="add" style="width: 800px; height: 20px;"
									v-model="p_notoDetail" /></td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;" colspan="2">필수우대사항</th>
								<td colspan="7"><input type="text" class="career"
									name="career" id="career" style="width: 1180px; height: 50px;"
									v-model="p_option_order" /></td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;" colspan="2">특이사항</th>
								<td colspan="7"><input type="text" class="speciality"
									name="speciality" id="speciality"
									style="width: 1180px; height: 50px;" v-model="p_singular_facts" />
								</td>
							</tr>
							<tr>
								<th scope="row" style="width: 300px;" colspan="2">근무장소</th>
								<td colspan="2">
									<select id="p_searcharea_Detail_2" name="p_searcharea_Detail_2" style="width: 100px; height: 22px;" v-model="p_searcharea_Detail_2">
									</select>
								</td>
								<td colspan="5">
									<input type="text" class="career" name="career" id="career" style="width: 180px; height: 25px;"
										v-model="address_de" /> 구/읍/면</td>	
							</tr>
							
							
							<tr>
								<th scope="row" colspan="3" style="width: 300px;">장비지원</th>
									<td colspan="2">
										<input type="radio" id="support_p" name="support_equip_p" value="0">지원 
										<input type="radio" id="noSupport_p" name="support_equip_p" value="1">미지원 
										<input type="radio" id="laterConsider_p" name="support_equip_p" value="2">추후협의
									</td>
								<th colspan="1">식사제공</th>
								<td colspan="2">
									<input type="radio" id="mealSupport_p" name="mealSupport_pYN"  value="0">지원 
									<input type="radio" id="noMealSupport_p" name="mealSupport_pYN" value="1">미지원
									<input type="radio" id="mealLater_p" name="mealSupport_pYN" value="2">추후협의
								</td>
							</tr>
							<tr>
								<th colspan="3" style="width: 300px;">숙박제공</th>
								<td colspan="2">
									<input type="radio" id="supportDorm" name="supportDormYN" value="0">지원 
									<input type="radio" id="noSupportDorm" name="supportDormYN" value="1">미지원 
									<input type="radio" id="DormLater" name="supportDormYN" value="2">추후협의
								</td>
							</tr>

							<tr>
								<th colspan="3" style="width: 300px;">면접형태</th>
								<td colspan="2">
									<input type="checkbox" name="interCheck" id="telYn" >전화면접 
									<input type="checkbox" name="interCheck" id="dictYn" >직접면접
								</td>
							</tr>

						</tbody>

						<!-- </tbody> -->
					</table>
				</div>
				<div class="btn_areaC mt30" id="updateoption">

					<a class="btnType blue" id="delete_p" @click="delete_pFunc">
						<span>삭제</span>
					</a> 

					<a class="btnType blue" href="javascript:modifyProject()"
					id="modify_p">
						<span>수정</span>
					</a>


					<a href="javascript:cancle()" class="btnType gray"><span>취소</span></a>
				</div>
			</dd>

		</dl>
		<a href="" class="closePop">
			<span class="hidden">닫기</span>
		</a>
	
	</div>
</form>
