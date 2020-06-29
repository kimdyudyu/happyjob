<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<table id="vueListtable" class="col2 mb10" style="width: 100%;">
	<colgroup>
		<col width="0px">
		<col width="200px">
		<col width="250px">
		<col width="150px">
		<col width="150px">
	</colgroup>
	<thead>
		<tr>
			<th data-field="nt_title">과목명</th>
			<th data-field="loginID">작성자</th>
			<th data-field="nt_note">내용</th>
			<th data-field="reg_date">작성일자</th>
			<th data-field="teacherID">강사명</th>
			<th class="hidden" data-field="filename">파일명</th>
			<th class="hidden" data-field="nt_no">no</th>
		</tr>
	</thead>
	<!-- vue 적용.  -->

	<tbody>
		<template v-if="items[0] == null">
		<tr>
			<td colspan="5"><strong>현 재 수 강 중 인 과 목 이 없 습 니 다. </strong></td>
		</tr>
		</template>
		<template v-else v-for="(item, index) in items">
		<tr @click="showDetail(item)">
			<td>{{ item.nt_title }} 
			<img v-if="item.filename !='' & item.filename != null" src="/images/treeview/file.gif"></td>
			<td>{{ item.loginID }}</td>
			<td>{{ item.nt_note }}</td>
			<td>{{ item.reg_date }}</td>
			<td>{{ item.teacherID }}</td>
			<td class="hidden">{{ item.nt_no }}</td>
			<td class="hidden">{{ item.filename }}</td>
		</tr>
		</template>
	</tbody>
</table>