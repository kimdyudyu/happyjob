<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="divEmpty">
	<div class="hiddenData">
		<span id="totalCntlist">${totalCntlist}</span>
	</div>
	<table class="col">
		<thead>
			<tr>
				<th scope="col">과정명</th>
				<th scope="col">이름</th>
				<th scope="col">주소</th>
				<th scope="col">이메일</th>
				<th scope="col">비고</th>
			</tr>
		</thead>
		<tbody id="cnsUserDtlList">
			<c:if test="${totalCntlist eq 0 }">
				<tr>
					<td colspan="12">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:set var="nRow" value="${pageSize*(currentPagelist-1)}" />
			<c:forEach items="${userList}" var="list">
				<tr>
					<td>${list.no}</td>
					<td>${list.title}</td>
					<td><a href="javascript:studentInfo('${list.no}','${list.loginID}');"
						id="compBtn" name="modal"><strong>${list.loginID}</strong></a></td>
					<td>${list.name}</td>
					<td>${list.attend}</td>
					<td>${list.startdate}</td>
					<td>${list.enddate}</td>
					<c:if test="${list.restyn eq 'y'}">
						<td><a class="btnType blue"
							href="javascript:restyn('${list.seq }','${list.restyn}');"><span>휴학취소</span></a></td>
					</c:if>
					<c:if test="${list.restyn ne 'y'}">
						<td><a class="btnType blue"
							href="javascript:restyn('${list.seq }','${list.restyn}');"><span>휴학신청</span></a></td>
					</c:if>
				</tr>
				<c:set var="nRow" value="${nRow + 1}" />
			</c:forEach>
		</tbody>
	</table>
</div>