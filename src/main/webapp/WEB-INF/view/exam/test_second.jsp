<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="test_div2">
	<h5>시 험 결 과 </h5>
</div>

<div id="scoreboard">

	<c:if test="${tscore eq null }">
	점수 : <strong> 데이터가 없음, 오류</strong>
	</c:if>
	<c:if test="${tscore != null }">
	점수 : <strong> ${tscore}</strong>
	</c:if>
		<table style="margin-top:10px; float:right; margin-right:100px">
			<tr>
			<td><span>제출한 선택지 :</span></td> 
			<c:forEach items="${tresult}" var="result">
				<td style="border:1px solid black; width:20px; text-align:center">${result.answer}</td>
			</c:forEach>
			</tr>
		</table>
</div>

<div id="test_div3">
		<table id="div3_table">
			<c:forEach items="${testList}" var="list">
				<thead>
					<tr>
						<th style="width: 150px">문제${list.seq}</th>
						<th style="width: 720px; text-align: left; font-weight: 700; height: 50px">${list.problem}</th>
					</tr>
				</thead>
				<tbody>

					<tr>
						<td></td>
						<td style="width: 720px; text-align: left; padding-left: 50px;">
						<span style="margin-right: 50px">
							<c:set var="i" value="${list.answer}" />
							<c:if test="${i == '1'}">
							<input type="radio" name="${list.seq}" checked="checked"/> ${list.answer1}
							</c:if>
							<c:if test="${i != '1'}">
							<input type="radio" name="${list.seq}" /> ${list.answer1}
							</c:if>
						</span> 
						<span style="margin-right: 50px">
							<c:if test="${i == '2'}">
							<input type="radio" name="${list.seq}" checked="checked"/> ${list.answer2}
							</c:if>
							<c:if test="${i != '2'}">
							<input type="radio" name="${list.seq}" /> ${list.answer2}
							</c:if>
						</span> 
						<span style="margin-right: 50px">
							<c:if test="${i == '3'}">
							<input type="radio" name="${list.seq}" checked="checked"/> ${list.answer3}
							</c:if>
							<c:if test="${i != '3'}">
							<input type="radio" name="${list.seq}" /> ${list.answer3}
							</c:if>
						</span> 
						<span style="margin-right: 50px">
							<c:if test="${i == '4'}">
							<input type="radio" name="${list.seq}" checked="checked"/> ${list.answer4}
							</c:if>
							<c:if test="${i != '4'}">
							<input type="radio" name="${list.seq}" /> ${list.answer4}
							</c:if>
						</span>
						</td>
					</tr>
				</tbody>
			</c:forEach>	
		</table>
	<button id="div_btn2" onclick="javascript:cancel_test()">취 소</button>
</div>