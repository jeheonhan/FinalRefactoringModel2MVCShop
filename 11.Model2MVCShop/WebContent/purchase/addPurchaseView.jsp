<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>
<title>구매창</title>

<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">	
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
	<!--  ///////////////////////// CSS ////////////////////////// -->	
							<!-- jQuery Lib import(CDN) -->
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

						<!-- 달력UI CDN -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
		body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">

	function fncAddPurchase(){
		//Form 유효성 검증
	 	var name = $("input:text[name='receiverName']").val();
		var phone = $("input:text[name='receiverPhone']").val();
		var addr = $("input:text[name='divyAddr']").val();
		var date = $("input:text[name='divyDate']").val();
	
		if(name == null || name.length<1){
			alert("이름을 입력해 주세요.");
			return;
		}
		if(phone == null || phone.length<1){
			alert("연락처는 반드시 입력하셔야 합니다.");
			return;
		}
		if(addr == null || addr.length<1){
			alert("주소는 반드시 입력하셔야 합니다.");
			return;
		}
		if(date == null || date.length<1){
			alert("희망 배송일을 입력해 주세요.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
	}
	
	$(function(){
		
		$("button:contains('구매')").on("click", function(){
// 					alert($("input:hidden[name='buyerId']").val());

// 				var prodNo = $("div:contains('상품번호')").text();
//  					alert(prodNo);
 					fncAddPurchase();
		});
		
		$("button:contains('취소')").on("click", function(){
			self.location="/product/listProduct?menu=${param.menu}";
		});
		
		$("input:text[name='divyDate']").datepicker({dateFormat:'yy/mm/dd'});
		
	});
	
</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품 구매창</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">		

		<div class="container">		
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품 이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:choose>
					<c:when test="${!(pvo.fileName == null || pvo.fileName == '')}">
						<img style="width:470px; height:400px;" src = "/images/uploadFiles/${pvo.fileName}"/>
					</c:when>
					<c:otherwise>
						<img style="width:470px; height:400px;" src = "/images/no_detail_img.gif"/>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<hr/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodNo}</div>
			<input type="hidden" name="prodNo" value="${pvo.prodNo}"/>	
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>가     격 </strong></div>
			<div class="col-xs-8 col-md-4">${pvo.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.regDate}</div>		
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4" >${sessionScope.user.userId}</div>
			<input type="hidden" name="buyerId" value="${sessionScope.user.userId}"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법*</strong></div>
			<select class="col-xs-8 col-md-4" name="paymentOption" style="width: 140px; height: 19px" >
				<option value="100">현금구매</option>
				<option value="101">신용구매</option>
			</select>
			
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자이름*</strong></div>
			<input type="text" name="receiverName" value="${sessionScope.user.userName}"
					class="col-xs-4 col-md-2 "
					style="width: 140px; height: 19px"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자연락처*</strong></div>
			<input type="text" name="receiverPhone" value="${sessionScope.user.phone}"
					class="col-xs-4 col-md-2 "
					style="width: 140px; height: 19px"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자주소*</strong></div>
			<input type="text" name="divyAddr" value="${sessionScope.user.addr}"
					class="col-xs-4 col-md-2 "
					style="width: 140px; height: 19px"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매요청사항</strong></div>
			<input type="text" name="divyRequest" class="col-xs-4 col-md-2 "
					style="width: 200px; height: 19px"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일자*</strong></div>
			<input type="text" name="divyDate" class="col-xs-4 col-md-2 " placeholder="클릭하여 날짜선택"
					style="width: 150px; height: 19px"/>
		</div>
		
		<hr/>
		
	</div>
				  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >구매</button>
			  <button type="button" class="btn btn-primary">취소</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
</body>
</html>