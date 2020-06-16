<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<table id="projectvuetable" class="col2 mb10" style="width: 1000px;">
											<colgroup>
												<col width="25px">
												<col width="25px">
												<col width="60px">
												<col width="60px">
												<col width="50px">
												<col width="50px">
												<col width="50px">
											</colgroup>
											<thead>
												<tr>
													<th data-field="">프로젝트명</th>
													<th data-field="">지역</th>
													<th data-field="">직무</th>
													<th data-field="">산업</th>
													<th data-field="">작성일</th>
													<th data-field="">모집마감일</th>
													<th data-field="">작성회사</th>
												</tr>
											</thead>
											<tbody>
												<template v-for="(item, index) in items" v-if="items.length">
												<tr @click="projectDetail(item)">
													<td class="hidden">{{ item.loginID }}</td>
													<td>{{item.project_name}}</td>
													<td>{{item.area}}</td>
													<td>{{item.job}}</td>
													<td>{{item.industry}}</td>
													<td>{{item.boarding_date}}</td>
													<td>{{item.due_date}}</td>
													<td>{{item.name}}</td>
												</tr>
												</template>
											</tbody>
										</table>