<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head lang="ko">

<meta charset="EUC-KR">
	
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	
	<!--   jQuery , Bootstrap CDN  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- jQuery Lib import(CDN) -->
<script type="text/javascript">	

	function fncGetList(currentPage) {
// 	document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage);
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
//    	document.detailForm.submit();		
	}
	
	
	$(function(){
		
		$("input:text[name='searchKeyword']").on("keydown", function(event){			
			if(event.keyCode==13){
				fncGetList('1');
			}			
		});
		
		$(".ct_btn01:contains('검색')").on("click", function(){
			fncGetList('1');			
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			
			var thisIndex = $(".ct_list_pop td:nth-child(3)").index(this);
			//alert(thisIndex);
			var prodNo = $($(".ct_list_pop td:nth-child(3) div")[thisIndex]).text().trim();
			//alert(prodNo);
			self.location ="/product/getProduct?menu=${param.menu}&prodNo="+prodNo+"&currentPage=${param.currentPage}";
		});
		
		$(".ct_list_pop td:nth-child(11):contains('배송하기')").on("click", function(){
// 			self.location ="/product/getProduct?menu=${param.menu}&prodNo="+$("#prodNo").text().trim();
			var thisIndex = $(".ct_list_pop td:nth-child(11):contains('배송하기')").index(this);
			//alert(thisIndex);
			var thisProdNo = $($(".ct_list_pop td:nth-child(11) div")[thisIndex]).text().trim();
			alert(thisProdNo);			
			self.location ="/purchase/updateTranCode?menu=${param.menu}&prodNo="+thisProdNo+"&currentPage=${param.currentPage}";
			
			
		});
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		
		$("input:text[name='searchKeyword']").on("click", function(){
			$.ajax(
					{
						url :"/product/json/listProduct" ,
						method : "POST" ,
						data : JSON.stringify({								
									'searchCondition' : '1',
									'searchKeyword' : ''
								}),
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData){						
							
							//alert("JSONData : \n"+JSONData);
							//Debug..
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							//var prodNameList = JSON.stringify(JSONData);
							
							$("input:text[name='searchKeyword']").autocomplete({
							      source : JSONData
							  });
													
						}
					});
			});
		
});
	

</script>

	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${param.menu == 'manage'}">
							판매상품 관리
						</c:if>
						<c:if test="${param.menu == 'search'}">						
							판매상품 조회
						</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">					
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>							
			</select>
		
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px"
					value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
					class="ct_input_g" style="width:200px; height:20px">
		</td>
		
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
											검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">제조일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />			
			<tr class="ct_list_pop">
				<td align="center">${i}</td>
				<td></td>				
				<td align="center">
					${product.prodName}
				<div  style="display:none">${product.prodNo}</div>					
				</td>		
				<td></td>
				<td align="center">${product.price}</td>
				<td></td>
				<td align="center">${product.regDate}</td>
				<td></td>
				<td align="center">${product.manuDate}</td>
				<td></td>
				<td align="center">
				
			<c:choose>
				<c:when test="${product.proTranCode == '000'}">
							<span style="color:green"><strong>판매중</strong></span>
				</c:when>
				<c:when test="${product.proTranCode == '111'}">				
							<span style="color:orange"><strong>구매완료</strong></span>
				</c:when>
				<c:when test="${product.proTranCode == '222'}">				
							<strong>배송중</strong>
				</c:when>
				<c:otherwise>				
							<span style="color:red"><strong>재고없음</strong></span>
				</c:otherwise>				
			</c:choose>
				<c:if test="${param.menu eq'manage' and product.proTranCode eq '111'}">
				--> 배송하기
					<div  style="display:none">${product.prodNo}</div>
				</c:if>	
				
				</td>	
			</tr>
			<tr>
				<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			</tr>
	</c:forEach>	
</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
						<jsp:include page="../common/pageNavigator.jsp"/>				
					</td>
				</tr>
			</table>
				
 <!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
    