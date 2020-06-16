<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<table id="vueListtable" class="col2 mb10" style="width: 100%;">
	<colgroup>
	
		<col width="50px">
		<col width="200">
		<col width="100px">
		<col width="100px">
		<!-- <col width="50px">
		 -->
	</colgroup>
	<thead>
		<tr>
			<th  class="hidden" data-field="loginID"></th>
			<th data-field="name">구분</th>
			<th data-field="nt_title">이름</th>
			<th data-field="enr_user">아이디</th>
			<th data-field="enr_date">가입일자</th>
			<!-- <th data-field="nt_cnt">전문기술</th>
			 -->
		</tr>
	</thead>
	<!-- vue 적용.  -->
	<tbody>
		<template v-for="(item, index) in items" v-if="items.length">
		<tr @click="showDetail(item)">
		<td>{{ item.user_type }}</td>
		<td>{{ item.name }}</td>
			<td>{{ item.loginID }}</td>
			<td>{{ item.join_date }}</td>
			<!-- 
			<td>{{ item.area }}</td>
			<td>{{ item.consult_yn }}</td>
			<td>{{ item.skill_add }}</td>
			 -->
		</tr>
		</template>
	</tbody>
</table>
