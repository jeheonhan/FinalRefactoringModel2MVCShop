<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<title>구매정보 수정</title>

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


	function fncUpdatePurchase() {
		//Form 유효성 검증
		var name = $("input:text[name='receiverName']").val();
		var phone = $("input:text[name='receiverPhone']").val();
		var addr = $("input:text[name='divyAddr']").val();
		var date = $("input:text[name='divyDate']").val();
		var tranNo = $("input:hidden[name='tranNo']").val();

		if (name == null || name.length < 1) {
			alert("이름을 입력해 주세요.");
			return;
		}
		if (phone == null || phone.length < 1) {
			alert("연락처는 반드시 입력하셔야 합니다.");
			return;
		}
		if (addr == null || addr.length < 1) {
			alert("주소는 반드시 입력하셔야 합니다.");
			return;
		}
		if (date == null || date.length < 1) {
			alert("희망 배송일을 입력해 주세요.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo="+tranNo).submit();
	}
	
	$(function(){
		
		$("button:contains('수정')").on("click", function(){
			fncUpdatePurchase();
		});
		
		$("button:contains('취소')").on("click", function(){
			var userId = $($("input:text")[0]).val();			
			self.location="/purchase/listPurchase?userId="+userId;
		});
		
		$("input:text[name='divyDate']").datepicker({dateFormat:'yy/mm/dd'});
		
	});
	
</script>

</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">구매정보수정</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
			<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
			
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" value="${sessionScope.user.userId}" readonly>
		    </div>
		  </div>
			
		  <div class="form-group">
		    <label for="Option" class="col-sm-offset-1 col-sm-3 control-label">구 매 방 법</label>
		    <div class="col-sm-4">
		      <select class="form-control" name="paymentOption">
		      	<option value="100">현금구매</option>
				<option value="101">신용구매</option>
		      </select>
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverName" value="${purchase.receiverName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="phone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="receiverPhone" value="${purchase.receiverPhone}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="addr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="divyAddr" value="${purchase.divyAddr}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="request" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="divyRequest" value="${purchase.divyRequest}">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="calendar" name="divyDate"  value="" placeholder="클릭하여 날짜선택">
		    </div>
		  </div>	  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">수정</button>
			  <button type="button" class="btn btn-primary btn" >취소</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
</body>
</html>