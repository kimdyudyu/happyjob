<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



            
      <!-- 갯수가 0인 경우  -->
      <c:if test="${totalCnt eq 0 }">
      
         <tr>
            <td colspan="6">공지사항이 없습니다.</td>
         </tr>
      </c:if>
      

      <!-- 갯수가 있는 경우  -->
      <c:if test="${totalCnt > 0 }">
         <c:set var="nRow" value="${pageSize*(currentPage-1)}" /> 
         <c:forEach items="${classList}" var="list">
            <tr onclick="javascript:fdetailModal(${list.no})" style="cursor: pointer;">

	                <td>${list.category}</a></td>
	                <td>${list.title}</a></td>
	                <td>${list.loginID}</td>
	                <td>${list.startdate}</td>
	                <td>${list.enddate}</td>
	                <td>${list.survey }</td>
	                <td>${list.tcnt }</td>

               <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
            </tr>
         </c:forEach>
      </c:if>
      
      <input type="hidden" id="totalCnt" value="${totalCnt}">
      <!-- 이거 중간에 있으면 table 안먹힘  -->


         

              












