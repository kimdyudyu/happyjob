<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<table id="vueListtable" class="col2 mb10" style="width: 100%;">
	<colgroup>
		<col width="1fr">
		<col width="1fr">
		<col width="1fr">
		<col width="1fr">
		<col width="1fr">
	</colgroup>
	<thead>
		<tr>
			<th  class="hidden" data-field="loginID"></th>
			<th data-field="name">성명</th>
			<th data-field="user_position">직군</th>
			<th data-field="area">희망지역</th>
			<th data-field="level">등급</th>
			<th data-field="skill">전문기술</th>

		</tr>
	</thead>
	<!-- vue 적용.  -->
	<tbody>
		<template v-for="(item, index) in items" v-if="items.length">
		<tr @click="showDetail(item)">
			<td class="hidden">{{ item.loginID }}</td>
			<td>{{ item.name }}</td>
			<td>{{ item.user_position }}</td>
			<td>{{ item.area }}</td>
			<td>{{ item.skill }}</td>
			<td>{{ item.skill_add }}</td>

		</tr>
		</template>
	</tbody>
</table>
