<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<div class="resumeLecture" id="resumeLecture">					
		<div class="table-thead-box">
			<table class="col">
				<colgroup>
					<col width="5%">
					<col width="20%">
					<col width="10%">
					<col width="50">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th class="th_info" >번호</th>
						<th class="th_info" >강의명</th>
						<th class="th_info" >강사명</th>
						<th class="th_info" >기간</th>
						<th class="th_info" >출석률</th>
					</tr>
				</thead>
				<tbody>
					<!--<template v-for="(User, index) in vUserDatas">
						<tr @click="showDetail(User.loginID)">
							  <td class="hidden">{{ Message.msg_code }}</td>
							<td>{{ index + 1}}</td>									
							<td>{{ User.name }}</td>
							<td>{{ User.loginID }}</td>
							<td>{{ User.tel1 + "-" +  User.tel2 + "-" + User.tel3 }}</td>	
							<td>{{ User.joinDate }}</td>
							<td><a style="cursor:pointer" class="btnType blue" @click="UpdatePopup(User)"><span>수정</span></td>
						</tr>													
					</template>-->
				</tbody>
			</table>
		</div>	
	</div>