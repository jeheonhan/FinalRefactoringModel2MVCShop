<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>   

<html>
<head lang="ko">
<title>구매 목록조회</title>
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

<script type="text/javascript">

	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase?userId=${param.userId}").submit();
	}
	
	$(function(){
		
		$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		$(".ct_list_pop td:nth-child(1)").on("click", function(){		
			
			//alert($(this).find("div").text().trim());			* find() 방법
			var thisIndex = $(".ct_list_pop td:nth-child(1)").index($(this));
			//alert($($(".ct_list_pop td:nth-child(1) div")[index]).text());
			var tranNo = $($(".ct_list_pop td:nth-child(1) div")[thisIndex]).text().trim();
			self.location="/purchase/getPurchase?tranNo="+tranNo;			
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click", function(){
			
			var thisIndex = $(".ct_list_pop td:nth-child(3)").index($(this));
			var userId = $($(".ct_list_pop td:nth-child(3)")[thisIndex]).text().trim();
			alert(userId+" ("+thisIndex+")");
			//alert($(this).text().trim());
			self.location="/user/getUser?userId="+userId;			
		});
		
		$("button[role='update']").on("click", function(){
			
			var tranNo = $(this).children().text().trim();
			//alert(tranNo);
			self.location = "/purchase/updateTranCode?userId=${param.buyerId}&tranNo="+tranNo+"&currentPage=${param.currentPage}";
		});
		
		$("button:contains('구매상세정보')").on("click", function(){		
			
			var thisIndex = $("button:contains('구매상세정보')").index(this);
			//alert(thisIndex);
			var thisTranNo = $($("button:contains('구매상세정보') div")[thisIndex]).text().trim();
			//alert("this tranNo : "+thisTranNo);			
			self.location = "/purchase/getPurchase?tranNo="+thisTranNo;
		});
		
	});

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

		<div class="page-header text-info">
			<h3><strong>${sessionScope.user.userId}</strong>님의 구매목록</h3>
		</div>

<div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>    	
		</div>
		
		<form class="form-inline" name="detailForm">
		
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
		</form>

<br/><br/><br/>
				
	<c:set var="i" value="0" />
			<c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${ i+1 }" />
					<div class="column">
  						<div class="col-sm-6 col-md-4">		
		    			<div class="thumbnail">
			     			<c:choose>
								<c:when test="${!(purchase.purchaseProd.fileName == null || purchase.purchaseProd.fileName == '')}">
									<img style="width:300px; height:250px;" src = "/images/uploadFiles/${purchase.purchaseProd.fileName}" alt=""/>
								</c:when>
								<c:otherwise>
									<img style="width:300px; height:250px;" src = "/images/no_detail_img.gif" alt=""/>
								</c:otherwise>
							</c:choose>
							
		      				<div class="caption" align="center">
		      						<c:choose>					        				
					        				<c:when test="${purchase.tranCode == '111'}">
					        					<h5><span style="color:orange"><strong>(구매완료)</strong></span></h5>
					        				</c:when>
					        				<c:when test="${purchase.tranCode == '222'}">				
												<h5><strong>(배송완료)</strong></h5>
											</c:when>
											<c:otherwise>				
												<h5><span style="color:red"><strong>(수령완료)</strong></span></h5>
											</c:otherwise>
			        					</c:choose>
		        			<p></p>		      						       				
		      							
		      							<table>
		      								<tr>
		      									<td>상	품	명</td>
		      									<td>&ensp;:&ensp;</td>
		      									<td>&emsp;${purchase.purchaseProd.prodName}</td>
		      								</tr>
		      								<tr>
		      									<td>가&ensp;&emsp;격</td>
		      									<td>&ensp;:&ensp;</td>
		      									<td>&emsp;${purchase.purchaseProd.price}</td>
		      								</tr>
		      								<tr>
		      									<td>제 조 일 </td>
		      									<td>:</td>
		      									<td>&emsp;${purchase.purchaseProd.manuDate}</td>
		      								</tr>
		      								<tr>
		      									<td>주 문 일</td>
		      									<td>:</td>
		      									<td>&emsp;${purchase.orderDate}</td>
		      								</tr>
		      							</table><br/>
		      							
							<p>	
								<button class="btn btn-primary" role="button">										
											구매상세정보																									
						        	<div style="display:none">${purchase.tranNo}</div>
						        </button>&emsp;&emsp;
						        <c:if test="${purchase.tranCode == '222'}">
							        <button class="btn btn-primary" role="update">										
												수령하기																									
							        	<div style="display:none">${purchase.tranNo}</div>
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