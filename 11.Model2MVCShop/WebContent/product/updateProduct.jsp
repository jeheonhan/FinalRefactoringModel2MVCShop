<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html>
<head>
<title>��ǰ��������</title>

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

	function fncUpdateProduct(){
		//Form ��ȿ�� ����
	 	var name = $("input:text[name='prodName']").val();
		var detail = $("input:text[name='prodDetail']").val();
		var manuDate = $("input:text[name='manuDate']").val();
		var price = $("input:text[name='price']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
	
		//document.detailForm.action='/product/addProduct';
		//document.detailForm.submit();
		
		$("form").attr("method", "POST").attr("action", "/product/updateProduct").submit();
	}
	
	function resetData(){
		//document.detailForm.reset();
		$("form").reset();
	}
	
	$(function(){
		
		$("button:contains('����')").on("click", function(){			
			fncUpdateProduct();
		});
		
		$("a:contains('���')").on("click", function(){			
			history.go(-1);
		});
		
		$("#calendar").datepicker({dateFormat:'yy/mm/dd'});
		/*
										datepicher(); ��ȣ�ȿ� ��¥���� ��������
										{dateFormat:'yymmdd'} JSON����
		*/
	});

</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">��ǰ��������</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
			<input type="hidden" name="prodNo" value="${pvo.prodNo}"/>
			
		  <div class="form-group">
		    <label for="prodname" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="prodName" value="" placeholder="${pvo.prodName}" >
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="Detail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="prodDetail" placeholder="${pvo.prodDetail}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" name="price" placeholder="${pvo.price}">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="calendar" name="manuDate"  value="" placeholder="Ŭ���Ͽ� ��¥����">
		    </div>
		  </div>	  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">����</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
</body>
</html>