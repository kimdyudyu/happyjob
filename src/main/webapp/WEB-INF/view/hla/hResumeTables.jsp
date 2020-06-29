<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<div class="resumeLecture" id="resumeLecture">
		<template v-if=" vIsUse === 'Y' ">	
			<div class="table-thead-box">
				<h1 class="conTitle">
					<span>강의 정보</span>
				</h1>		
				<table class="col">
					<colgroup>
						<col width="10%">
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
						<template v-for="(Lecture, index) in vLectures" v-if="vLectures.length">
							<tr>
								<td>{{ index + 1}}</td>									
								<td>{{ Lecture.title }}</td>
								<td>{{ Lecture.teachername }}</td>
								<td>{{ Lecture.startdate + '~' + Lecture.enddate }}</td>
								<td>{{ Lecture.attendRate }}</td>
							</tr>													
						</template>
					</tbody>
				</table>
			</div>					
			<div class="table-thead-box">
				<h1 class="conTitle">
					<span>시험 정보</span>
				</h1>
				<table class="col">
					<colgroup>
						<col width="10%">
						<col width="40%">
						<col width="40%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th class="th_info" >번호</th>
							<th class="th_info" >강의명</th>
							<th class="th_info" >시험명</th>
							<th class="th_info" >점수</th>
						</tr>
					</thead>
					<tbody>
						<template v-for="(Test, index) in vTestList" v-if="vTestList.length">
							<tr>
								<td>{{ index + 1}}</td>									
								<td>{{ Test.title }}</td>
								<td>{{ Test.testname }}</td>
								<td>{{ Test.totalScore }}</td>
							</tr>													
						</template>
					</tbody>
				</table>
			</div>
		</template>
	</div>