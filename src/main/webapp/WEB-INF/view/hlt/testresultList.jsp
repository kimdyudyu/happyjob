<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 시험 모달팝업 -->
<div id="testresultList" class="layerPop layerType2"
	style="width: 1100px; hight: 1000px;">

	<div class="bootstrap-table">
		<div class="fixed-table-toolbar">
			<div class="bs-bars pull-left"></div>
			<div class="columns columns-right btn-group pull-right"></div>
		</div>
		<div class="fixed-table-container" style="padding-bottom: 0px;">
			<div class="fixed-table-body">

				<table id=testList class="col2 mb10" style="width: 1000px;">
					<colgroup>
						<col width="200px">
						<col width="200px">
						<col width="150px">
						<col width="200px">
					</colgroup>
					<thead>
						<tr>
							<th>과정명</th>
							<th>시험명</th>
							<th>구분</th>
							<th>대상자수</th>
						</tr>
					</thead>
					<tbody>
						<template v-for="(item, index) in items" v-if="items.length">
						<tr @click="testResultF(item)">
							<td>{{item.title}}</td>
							<td>{{item.testname}}</td>
							<td>{{item.status}}</td>
							<td>{{item.targetCount}}</td>

						</tr>
						</template>
					</tbody>
				</table>
				
			</div>
		</div>
	</div>
	<a href="" class="closePop"><span class="hidden">닫기</span></a>
</div>
