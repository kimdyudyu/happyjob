<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData">
		<span id="totalCntComnDtlCod">${toolCount}</span>
	</div>
	<table class="col">
		<tbody id="listComnDtlCod">
			<c:if test="${toolCount eq 0 }">
				<tr>
					<td colspan="12">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPageComnDtlCod-1)}" />
			<c:forEach items="${toolList}" var="list">
				<tr>
					<td>${list.room }</td>
					<td><a class="btnType3 color1"
						href="javascript:toolModal('${list.room}','${list.seq }');">${list.seq}</a></td>
					<td>${list.tool_name}</td>
					<td>${list.tool_ccount}</td>
					<td>${list.tool_etc}</td>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</tbody>
	</table>
</div>