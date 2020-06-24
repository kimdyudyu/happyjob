<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData">
		<span id="totalCntComnGrpCod">${toolCount}</span>
	</div>
	3435353534535345
	<table class="col">
		<tbody id="listComnGrpCod">
			<c:if test="${toolCount eq 0 }">
				<tr>
					<td colspan="9">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPageComnGrpCod-1)}" />
			<c:forEach items="${toolList}" var="list">
				<tr>
					<td><a href="javascript:toolList(1, '${list.room}')">${list.room}</a></td>
					<td>${list.name}</td>
					<td>${list.room_size}</td>
					<td>${list.ccount}</td>
					<td>${list.etc}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</tbody>
	</table>
</div>
