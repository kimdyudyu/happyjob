<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<table id="vueListtable" class="col2 mb10" style="width:100%">
	<colgroup>
		<col width="150px">
		<col width="100px">
		<col width="50px">		
	</colgroup>
	<thead>
		<tr>
			<th data-field="nt_title">제목</th>
			<th data-field="enr_date">작성일</th>
			<th data-field="enr_user">작성자</th>
		</tr>
	</thead>
	<tbody>
		<template v-for="(item,index) in items" v-if="items.length">
			<tr @click="showDetail(item)">
				<td class="hidden">{{item.noti_code}}</td>
				<td>{{item.noti_name}}</td>
				<td>{{item.noti_date}}</td>
				<td>{{item.notii_writer}}</td>
			</tr>
		</template>
	</tbody>
</table>