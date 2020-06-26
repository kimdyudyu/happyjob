<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<table id="vueListtable" class="col2 mb10" style="width: 100%;">
   <colgroup>
      <col width="0px">
      <col width="200px">
      <col width="250px">
      <col width="150px">
      <col width="150px">
   </colgroup>
   <thead>
      <tr>
         <th data-field="title">제목</th>
         <th data-field="red_date">작성일</th>
         <th data-field="regId">작성자</th>
         <th class="hidden" data-field="note">내용</th>
         <th class="hidden" data-field="wno">글번호</th>
      </tr>
   </thead>

   <tbody>
      <template v-for="item in items">
         <tr @click="showDetail(item)">
            <!-- <td class="hidden">{{ item.no }}</td> -->
            <td>{{ item.title }}</td>
            <td>{{ item.reg_date }}</td>
            <td>{{ item.regId }}</td>
            <td class="hidden">{{ item.note }}</td>
            <td class="hidden">{{ item.wno }}</td>
         </tr>
      </template>
   </tbody>
</table>