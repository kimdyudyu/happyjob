<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${CTX_PATH}/css/khcss/gridsetting.css" />
		<div id="divUserInfoVue" class="regcontainer">
		   <div id="divpicture" class="divpicture">
		   		<!-- <img  src="/images/mpm/사쿠라.jpg"> -->
		   	<template v-if="vUploadImageData != null ">
		   		{{ vUploadImageData }}
		   		<img width="200" :src="vCurrentImage"><!--  :src="'/images/userImage/'+vUploadImageData" > -->
	   		</template>
	   		<template v-if="vformUseType != 'R'">
		   		<input type="file" @change="ImageChange" ref="vUploadImageData">
		   	</template>		   		
		   </div>
		   <div class="box2">아이디<br>
		   		<template v-if="vformUseType === 'I'">
			   		<input id="iuserId" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="userId" v-model="vUserId">
			   		<a style="cursor:pointer" class="btnType blue" v-on:click="hidCheck()"><span>중복 체크</span></a>
			   	</template>
			   	<template v-if="vformUseType === 'U'  || vformUseType === 'R'">
			   		<input id="suserId" class="hidden" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="userId" v-model="vUserId">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserId }}</span>
			   	</template>
		   </div>
		   <template v-if="vformUseType != 'R'">
			   <div class="box3">비밀번호<br>		   
			   		<input id="userPw" style="height: 30px; width: 200px; font-size: 20px;" type="text" name="userPw" v-model="vUserPw">
			   </div>
		   </template>
		   <div class="box4">이름<br>
		   		<template v-if="vformUseType != 'R'">
		   			<input id="iuserName" style="height: 30px; width: 200px; font-size: 20px;" type="text" name="userName" v-model="vUserName">
		   		</template>
		   		<template v-if="vformUseType === 'R'">
		   			<input id="suserName" class="hidden" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="userName" v-model="vUserName">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserName }}</span>
		   		</template>
		   </div>
		   <div class="box5">성별<br>
		   		<template v-if="vformUseType != 'R'">
			   		<select style="height: 30px; width: 100px; font-size: 20px;" v-model="vUserGender"> <!--  v-model="selected" --> 
						<option disabled value="">Please select one</option>
						<option>남</option>
						<option>여</option>
				    </select>
			    </template>
			    <template v-if="vformUseType === 'R'">
			    	<input id="sUserGender" class="hidden" style="height: 30px; width: 150px; font-size: 20px;" type="text" name="UserGender" v-model="vUserGender">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserGender }}</span>
			    </template>
		   </div>
		   <div class="box6">연락처<br>
		   		<template v-if="vformUseType != 'R'">
			   		<input id="iuserPhone1" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone1" v-model="vUserPhone1">
			   		<span>-</span>
			   		<input id="iuserPhone2" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone2" v-model="vUserPhone2">
			   		<span>-</span>
			   		<input id="iuserPhone3" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone3" v-model="vUserPhone3">
		   		</template>
		   		<template v-if="vformUseType === 'R'">
		   			<input id="suserPhone1" class="hidden" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone1" v-model="vUserPhone1">
		   			<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserPhone1 }}</span>
			   		<span>-</span>
			   		<input id="suserPhone2" class="hidden" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone2" v-model="vUserPhone2">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserPhone2 }}</span>
			   		<span>-</span>
			   		<input id="suserPhone3" class="hidden" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="userPhone3" v-model="vUserPhone3">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserPhone3 }}</span>
		   		</template>
		   </div>
		   <div class="box7">거주지<br>
		   		<template v-if="vformUseType != 'R'">   
				   <select style="height: 30px; width: 200px; font-size: 20px;" v-model="vUserAddress"> <!--  v-model="selected" --> 
						<option disabled value="">Please select one</option>
						<option v-for = "address in vAddressCombo" v-bind:value="address.dtl_cod_nm">
							{{ address.dtl_cod_nm }}
						</option>
				   </select>	
			    </template>
			    <template v-if="vformUseType === 'R'">
			    	<input id="sUserAddress" class="hidden" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="UserAddress" v-model="vUserAddress">
			   		<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserAddress }}</span>
			    </template>
		   </div>
		   <div class="box9 hidden">등록일자<br>
		   		<input type="text" style="height: 30px; width: 200px" id="userjoinDate" name="userjoinDate" data-date-format='yyyy-mm-dd' autocomplete=off v-model="vUserJoinDate">
		   </div>
		   <div class="box10">생년월일<br>
		   		<template v-if="vformUseType != 'R'">
		   			<input type="text" style="height: 30px; width: 200px" id="userBirth" name="userBirth" data-date-format='yyyy-mm-dd' autocomplete=off v-model="vUserBirthDate">
	   			</template>
	   			<template v-if="vformUseType === 'R'">
	   				<input id="sUserBirthDate" class="hidden" style="height: 30px; width: 70px; font-size: 20px;" type="text" name="UserBirthDate" v-model="vUserBirthDate">
	   				<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserBirthDate }}</span>
	   			</template>
		   </div>
		   <div class="box11">이메일<br>
		   		<template v-if="vformUseType != 'R'">
			   		<input id="iuserEmail1" style="height: 30px; width: 100px; font-size: 20px;" type="text" name="userEmail1" v-model="vUserEmail1">
			   		<span>@</span>
			   		<select style="height: 30px; width: 100px; font-size: 20px;" v-model="vUserEmail2"> <!--  v-model="selected" --> 
						<option disabled value="">Please select one</option>
						<option v-for = "vDomain in vDomainCombo" v-bind:value="vDomain.dtl_cod">
							{{ vDomain.dtl_cod }}
						</option>					
				    </select>
			    </template>
			    <template v-if="vformUseType === 'R'">
			    	<input id="suserEmail1" class="hidden" style="height: 30px; width: 100px; font-size: 20px;" type="text" name="userEmail1" v-model="vUserEmail1">
			    	<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserEmail1 }}</span>
			    	<span>@</span>
			    	<input id="suserEmail2" class="hidden" style="height: 30px; width: 100px; font-size: 20px;" type="text" name="userEmail2" v-model="vUserEmail2">
			    	<span style="height: 30px; width: 150px; font-size: 20px;">{{ vUserEmail2 }}</span>
			    </template>
		   </div>
		</div>
