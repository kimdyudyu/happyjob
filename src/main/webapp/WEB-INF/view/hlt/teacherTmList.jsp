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
			<th data-field="nt_title">제목</th>
			<th data-field="enr_user">학생명</th>
			<th data-field="enr_date">제출시간</th>
			<th data-field="filename">파일명</th>
			 <!-- <th data-field="nt_cnt">조회수</th>  -->
		</tr>
	</thead>
	<!-- vue 적용.  -->

	<tbody>
		<template v-for="item in items">
			<tr @click="showDetail(item)">
				<td class="hidden">{{ item.no }}</td>
				<td>{{ item.nt_title }} 
					<img v-if="item.filename !='' & item.filename != null" src="/images/treeview/file.gif">
				</td>
				<td>{{ item.loginID }}</td>
				<td>{{ item.reg_date }}</td>
				<td>{{ item.filename }}</td>
			</tr>
		</template>
	</tbody>
</table>