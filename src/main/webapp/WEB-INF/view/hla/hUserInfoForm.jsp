<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

		<div id="hUserInfoVue" class="regcontainer">
		   <div class="divpicture">{{ vformUseType }}</div>
		   <div class="box2">아이디<br>
		   		<template v-if="vformUseType === 'I'">
			   		<input id="userId" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="userId" v-model="vUserId">
			   		<a href="" class="btnType blue" id="idCheck" name="btn"> <span>중복 체크</span></a></td>
			   	</template>
			   	<template v-if="vformUseType === 'U'">
			   		<input id="userId" class="hidden" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="userId" v-model="vUserId">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserId }}</span>
			   	</template>
		   </div>
		   <div class="box3">{{ vUserId }}<br>
		   		<input id="userPw" style="height: 30px; width: 200px; font-size: 20px;" type="text" name="userPw" v-model="vUserPw">
		   </div>
		   <div class="box4">이름<br>
		   		<input id="userName" style="height: 30px; width: 200px; font-size: 20px;" type="text" name="userName" v-model="vUserName">
		   </div>
		   <div class="box5">성별<br>
		   		<select style="height: 30px; width: 100px; font-size: 20px;" v-model="vUserGender"> <!--  v-model="selected" --> 
					<option disabled value="">Please select one</option>
					<option>남</option>
					<option>여</option>
			    </select>
		   </div>
		   <div class="box6">연락처<br>
		   		<input id="userPhone1" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone1" v-model="vUserPhone1">
		   		<span>-</span>
		   		<input id="userPhone2" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone2" v-model="vUserPhone2">
		   		<span>-</span>
		   		<input id="userPhone3" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone3" v-model="vUserPhone3">
		   </div>
		   <div class="box7">{{ vUserAddress }}<br>		   
			   <select style="height: 30px; width: 200px; font-size: 20px;" v-model="vUserAddress"> <!--  v-model="selected" --> 
					<option disabled value="">Please select one</option>
					<option v-for = "address in vAddressCombo" v-bind:value="address.dtl_cod_nm">
						{{ address.dtl_cod_nm }}
					</option>
			   </select>		  
		   </div>
		   <div class="box9 hidden">등록일자<br>
		   		<input type="text" style="height: 30px; width: 200px" id="userjoinDate" name="userjoinDate" data-date-format='yyyy-mm-dd' autocomplete=off v-model="vUserJoinDate">
		   </div>
		   <div class="box10">생년월일<br>
		   		<input type="text" style="height: 30px; width: 200px" id="userBirth" name="userBirth" data-date-format='yyyy-mm-dd' autocomplete=off v-model="vUserBirthDate">
		   </div>
		   <div class="box11">이메일<br>
		   		<input id="userEmail1" style="height: 30px; width: 100px; font-size: 20px;" type="text" name="userEmail1" v-model="vUserEmail1">
		   		<span>@</span>
		   		<select style="height: 30px; width: 100px; font-size: 20px;" v-model="vUserEmail2"> <!--  v-model="selected" --> 
					<option disabled value="">Please select one</option>
					<option v-for = "vDomain in vDomainCombo" v-bind:value="vDomain.dtl_cod">
						{{ vDomain.dtl_cod }}
					</option>					
			    </select>
		   </div>
		</div>