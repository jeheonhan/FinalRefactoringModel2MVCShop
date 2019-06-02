<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<style>
	     body {
	         padding-top : 70px;
	     }
	     
	     table{
	     	text-align : center;
	     }     
	</style>

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
		
		$("button[role='update']").on("click", function(){
			
			var prodNo = $(this).children().text().trim();
			//alert(prodNo);			
			self.location ="/purchase/updateTranCode?menu=${param.menu}&prodNo="+prodNo+"&currentPage=${param.currentPage}";
			
			
		});
		
		$("button[role='button']").on("click", function(){
			
 			var prodNo = $(this).children().text().trim();
 			//alert(prodNo);
 			
 			self.location="/product/getProduct?menu=${param.menu}&prodNo="+prodNo;
			
 			//var thisIndex = $("div:style[display]").index(this);
 			//alert(thisIndex);
			
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
   	
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />



<div class="container">

		<div class="page-header text-info">
		<c:choose>
			<c:when test="${param.menu eq 'manage'}">
	       		<h3>판매상품관리</h3>
	       	</c:when>
	       	<c:otherwise>
	       		<h3>상 품 조 회</h3>
	       	</c:otherwise>
	    </c:choose>
	    </div>

<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>

<br/><br/><br/>
				
	<c:set var="i" value="0" />
			<c:forEach var="product" items="${list}">
				<c:set var="i" value="${ i+1 }" />
					<div class="column">
  						<div class="col-sm-6 col-md-4">		
		    			<div class="thumbnail" >
			     			<c:choose>
								<c:when test="${!(product.fileName == null || product.fileName == '')}">
									<img style="width:250px; height:200px;" src = "/images/uploadFiles/${product.fileName}" alt=""/>
								</c:when>
								<c:otherwise>
									<img style="width:250px; height:200px;" src = "/images/no_detail_img.gif" alt=""/>
								</c:otherwise>
							</c:choose>
							
		      				<div class="caption" align="center">		      					
		      						<c:choose>
					        				<c:when test="${product.proTranCode == '000'}">
					        					<h5><span style="color:green"><strong>(판매중)</strong></span></h5>		        				
					        				</c:when>
					        				<c:when test="${product.proTranCode == '111'}">
					        					<h5><span style="color:orange"><strong>(구매완료)</strong></span></h5>
					        				</c:when>
					        				<c:when test="${product.proTranCode == '222'}">				
												<h5><strong>(배송중)</strong></h5>
											</c:when>
											<c:otherwise>				
												<h5><span style="color:red"><strong>(재고없음)</strong></span></h5>
											</c:otherwise>
			        					</c:choose>
		      					<p></p>		      						       				
		      							
		      							<table>
		      								<tr>
		      									<td>상 품 명</td>
		      									<td>&ensp;:&ensp;</td>
		      									<td>&emsp;${product.prodName}</td>
		      								</tr>
		      								<tr>
		      									<td>가&emsp;&emsp;격</td>
		      									<td>&ensp;:&ensp;</td>
		      									<td>&emsp;${product.price}</td>
		      								</tr>
		      								<tr>
		      									<td>제 조 일 자</td>
		      									<td>:</td>
		      									<td>&emsp;${product.manuDate}</td>
		      								</tr>
		      								<tr>
		      									<td>등 록 일 자</td>
		      									<td>:</td>
		      									<td>&emsp;${product.regDate}</td>
		      								</tr>
		      							</table><br/>
		        			
							<p>	
								<button class="btn btn-primary" role="button">
									<c:choose>
										<c:when test="${param.menu eq 'manage'}">
											상품수정
										</c:when>
										<c:otherwise>
											상품상세정보
										</c:otherwise>
									</c:choose>																
						        	<div style="display:none">${product.prodNo}</div>
						        </button>
						        &emsp;&emsp;
						        <c:if test="${product.proTranCode == '111' and param.menu == 'manage'}">
							        <button class="btn btn-primary" role="update">
							        		배송하기
							        	<div style="display:none">${product.prodNo}</div>
							        </button>
						        </c:if>						        
					        </p>						        
				      </div>
				    </div>
			    </div>
		    </div>					
		</c:forEach>		
</div>
<jsp:include page="../common/pageNavigator_new.jsp"/>
</body>
</html>
    