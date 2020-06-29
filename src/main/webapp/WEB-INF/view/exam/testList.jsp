<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 수강 중인 과목이 없을 경우  -->
<c:if test="${totalCnt eq 0 }">
	<tr>
		<td colspan="4">수강 중인 강의가 없습니다.</td>
	</tr>
</c:if>

<!-- 수강 중인 과목이 있는 경우  -->
<c:if test="${totalCnt > 0}">
	<c:forEach items="${examList}" var="list">
		<tr onclick="vm.rowClicked(this)">
			<td>${list.no}</td>
			<td>${list.testname}</td>
			<c:set var="standard" value="${list.re}" />
			<c:if test="${standard == 're'}">
				<td>재시험</td>

				<c:set var="point" value="${list.point}" />
				<c:choose>
					<c:when test="${point==101}">
						<td>미응시</td>
					</c:when>
					<c:when test="${point>=60}">
						<td>합격 [${list.point}]</td>
					</c:when>
					<c:when test="${point<60}">
						<td>과락 [${list.point}]</td>
					</c:when>
				</c:choose>
			</c:if>

			<c:if test="${standard == 'main'}">
				<td>본시험</td>

				<c:set var="point" value="${list.point}" />
				<c:choose>
					<c:when test="${point == 101 }">
						<td>미응시</td>
					</c:when>				
					<c:when test="${point >= 60 }">
						<td>합격 [${list.point}]</td>
					</c:when>
					<c:when test="${point < 60 }">
						<td>과락 [${list.point}]</td>
					</c:when>
				</c:choose>

			</c:if>


		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCnt" value="${totalCnt}">