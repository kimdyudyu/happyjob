<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData">
		<span id="lectureListAdminCount">${lectureListAdminCount }</span>
	</div>
	<table class="col">
		<tbody id="list">
			<c:if test="${lectureListAdminCount eq 0 }">
				<tr>
					<td colspan="9">강의목록이 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPagelist-1) }" />
			<c:forEach items="${lectureListAdminList }" var="list">
				<tr>
					<td><strong><a
							href="javascript:fcnsUserList('1','${list.no }')">${list.no}</a></strong></td>
					<td>${list.title }</td>
					<td>${list.name }</td>
					<td>${list.loginID }</td>
					<td>${list.room }</td>
					<td>${list.pcnt }</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1 }" />
			</c:forEach>

		</tbody>

	</table>
</div>