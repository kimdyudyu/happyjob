<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="value" value="${testList[0].problem}" />
<c:if test="${value != null}">
<div id="test_div2">
	<h3>정 규 시 험</h3>
</div>
</c:if>
<c:if test="${value == null}">
<div id="test_div2">
	<h3>등 록 되 어 있 는 문 제 가 없 습 니 다.</h3>
</div>
</c:if>
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
						<span style="margin-right: 50px"> <input type="radio"
							class="testlist" name="question${list.seq}" value="1" />
							${list.answer1}
					</span> <span style="margin-right: 50px"> <input type="radio"
							name="question${list.seq}" value="2" /> ${list.answer2}
					</span> <span style="margin-right: 50px"> <input type="radio"
							name="question${list.seq}" value="3" /> ${list.answer3}
					</span> <span style="margin-right: 50px"> <input type="radio"
							name="question${list.seq}" value="4" /> ${list.answer4}
					</span> <input type="hidden" id="no" value="${list.no}" /> <input
						type="hidden" id="re" value="${list.re}" />
					</td>
				</tr>
			</tbody>
		</c:forEach>

	</table>
	<button id="div_btn2" onclick="javascript:cancel_test()">취 소</button>
<c:if test="${value != null}">	
	<button id="div_btn1" onclick="javascript:submit_test()">제 출</button>
</c:if>	
</div>