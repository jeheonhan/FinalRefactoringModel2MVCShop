<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    


<html>
<head>
<title>���� �����ȸ</title>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<script type="text/javascript">

	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/listPurchase?userId=${param.userId}").submit();
	}
	
	$(function(){
		
		$( ".ct_list_pop td:nth-child(1)" ).css("color" , "red");
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		$(".ct_list_pop td:nth-child(1)").on("click", function(){		
			
			//alert($(this).find("div").text().trim());			* find() ���
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
		
		$("td:contains('�����ϱ�')").on("click", function(){		
			
			var thisIndex = $("td:contains('�����ϱ�')").index($(this));
			//alert(thisIndex);
			var thisTranNo = $($("td:contains('�����ϱ�') div")[thisIndex]).text().trim();
			//alert("this tranNo : "+thisTranNo);
			
			self.location = "/purchase/updateTranCode?userId=${param.buyerId}&tranNo="+thisTranNo+"&currentPage=${param.currentPage}";
		});
		
	});

</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">���Ż�ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
	
	<tr class="ct_list_pop">
		<td align="center">${purchase.purchaseProd.prodName}
			<div style="display:none">${purchase.tranNo}</div>
		</td>
		<td></td>
		<td align="center">${purchase.buyer.userId}</td>
		<td></td>
		<td align="center">${purchase.receiverName}</td>
		<td></td>
		<td align="center">${purchase.receiverPhone}</td>
		<td></td>
		<td align="center">����
	<c:choose>
			<c:when test="${purchase.tranCode == '111'}" >	
						<span style="color:orange"><strong>���ſϷ�</strong></span>
			</c:when>
			<c:when test="${purchase.tranCode == '222'}">			
						<strong>��ۿϷ�</strong>			
			</c:when>
			<c:otherwise>
						<span style="color:red"><strong>���ɿϷ�</strong></span>
			</c:otherwise>
	</c:choose>
			���� �Դϴ�.		
		</td>
		<td></td>		
		<td align="center">
			<c:if test="${purchase.tranCode == '222'}">
				�����ϱ�
					<div style="display:none">${purchase.tranNo}</div>		
			</c:if>			
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
</c:forEach>	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>				
		</td>
	</tr>
</table>

</form>

<!--  ������ Navigator �� -->

</div>

</body>
</html>