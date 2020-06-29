<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


   <!-- 글쓰기 -->
   <div id="writeLmm" class="layerPop layerType2" style="width: 1000px; hight: 1000px;">
       <form id="lmmWrtieForm" method="post">
       <input type="hidden" name="action" id="waction" value="">
       <input type="hidden" name="nt_note" id="wnt_contents"  value="">
       
      <dl>
         <dt>
			<h3 style="margin-left: 30px; margin-top: 5px; padding: 5px">
				자료게시판 글쓰기</h3>
         </dt>
         <dd class="content">
            <div id="wrtLmm">
               <table class="row">
                  <caption>caption</caption>
                  <colgroup>
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                     <col width="120px">
                     <col width="*">
                  </colgroup>
                  <tbody>
                     <tr>
                        <th scope="row">제 목 <span class="font_red">*</span></th>
                        <td>
                        <input type="text" class="inputTxt p100" name="nt_title" 
                        		id="wnt_title" v-model="nt_title" autofocus required/>
                        </td>
                        <th scope="row">구 분<span class="font_red">*</span></th>
                        <td>
                        	<select id="nt_no" name="nt_no" autofocus required>
                        		<template v-for="item in select">
                        			<option v-bind:value="item.no">{{item.no}}</option>
                        		</template>
                        	</select>
                        </td>
                        <th scope="row">작성자 </th>
                        <td><input type="text" class="inputTxt p100" name="loginId" 
                        		id="wenr_user" v-model="loginId" />
                        </td>
                     </tr>
                     <tr >
                        <th scope="row" >내 용
                        	<span class="font_red"> * </span></th>
                        <td colspan="5">      
                           <div style="width: 900px;" >                
                              <quill-editor id="quillEditor"
                                ref="quillEditor" class="editor" 
                                v-model="nt_note" :options="editorOption" 
                                
                                @blur="onEditorBlur($event)"
                                @focus="onEditorFocus($event)"
                                @ready="onEditorReady($event)" />
                              <br>
                           </div>
                        </td>
                     </tr>
                     <tr>
                        <th scope="row" >파 일
                        	<span class="font_red"> * </span></th>
                        <td colspan="5">
                           <!--multiple="multiple" -->
                           <input type="file" name="filename" id="wfilename" @change="setFileName" />
                           <img v-if="filename !=''" src="/images/treeview/minus.gif" @click="minusClickEvent">   
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>                  
            <div class="btn_areaC mt30" style="padding-bottom: 10px;">                  
               <a href="javascript:insertLmm()" class="btnType blue" ><span>저장</span></a>
               <a href="javascript:cancel()" class="btnType gray" ><span>취소</span></a>
            </div>
         </dd>
      </dl>
      <a href="javascript:cancel()" class="closePop" style="width: 60px"><span class="hidden">닫기</span></a>
      </form>
   </div>