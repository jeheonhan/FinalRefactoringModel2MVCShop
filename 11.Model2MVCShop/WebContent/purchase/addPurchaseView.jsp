<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>
<title>����â</title>

<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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

						<!-- �޷�UI CDN -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<style>
		body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">

	function fncAddPurchase(){
		//Form ��ȿ�� ����
	 	var name = $("input:text[name='receiverName']").val();
		var phone = $("input:text[name='receiverPhone']").val();
		var addr = $("input:text[name='divyAddr']").val();
		var date = $("input:text[name='divyDate']").val();
	
		if(name == null || name.length<1){
			alert("�̸��� �Է��� �ּ���.");
			return;
		}
		if(phone == null || phone.length<1){
			alert("����ó�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(addr == null || addr.length<1){
			alert("�ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(date == null || date.length<1){
			alert("��� ������� �Է��� �ּ���.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();
	}
	
	$(function(){
		
		$(".ct_btn01:contains('����')").on("click", function(){
					fncAddPurchase();
		});
		
		$(".ct_btn01:contains('���')").on("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
		});
		
		$("input:text[name='divyDate']").datepicker({dateFormat:'yy/mm/dd'});
		
	});
	
</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ ����â</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		<input type="hidden" name="prodNo" value="${pvo.prodNo}" />		
		
		<div class="container">		
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ �̹���</strong></div>
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
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ǰ ��</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��     �� </strong></div>
			<div class="col-xs-8 col-md-4">${pvo.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${pvo.regDate}</div>		
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�����ھ��̵�</strong></div>
			<input class="col-xs-8 col-md-4" name="buyerId" value="${sessionScope.user.userId}"/>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���Ź��</strong></div>
			<select class="col-xs-8 col-md-4" name="paymentOption">
				<option value="100">���ݱ���</option>
				<option value="101">�ſ뱸��</option>
			</select>
			
		</div>
		
		<hr/>
		
	</div>
				  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >���</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
</body>
</html>