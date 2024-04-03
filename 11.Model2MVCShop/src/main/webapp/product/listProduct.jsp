
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.*"%>

<%@ taglib prefix="c"	uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<%-- <%
//HashMap<String, Object> map = (HashMap<String,Object>)request.getAttribute("map");
List<Product> list = (List<Product>)request.getAttribute("list");
Search search = (Search)request.getAttribute("searchVO");
Page resultPage=(Page)request.getAttribute("resultPage");

String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());


%> --%>




<html>
<head>
<title>상품 목록조회</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<script type="text/javascript">

function fncGetList(currentPage){
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();
}

$(function() {
	$("td:nth-child(6) > i").on('click', function() {
		
		var selector = $(this).next().attr('value2');
		console.log(selector);
		
		if($('i[value2="'+selector+'"]').hasClass("glyphicon-triangle-bottom")){
			
			var prodNo = $(this).next().attr('value1');
			
			$('i[value2="'+selector+'"]').attr('class','glyphicon glyphicon-triangle-top');
			
			$.ajax(
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							console.log(JSONData);
							var displayValue ="<h6>"
													+"상품명 : "+JSONData.prodName+"<br/>"
													+"상품상세정보 : "+JSONData.prodDetail+"<br/>"
													+"</h6>";
							$("#"+selector+"").append(displayValue);
							
						}
			});//ajax end	
			
		}else{
			
			
			
			$('i[value2="'+selector+'"]').attr('class','glyphicon glyphicon-triangle-bottom');
			$("#"+selector).find('h6').remove();
		}
		
		
	});
});

var currPage = 1;

$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
      
     
      $.ajax(
    		  {
    			  url: "/product/json/listProduct",
    			  method : "POST",
    			  dataType : "json",
   				  headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
			 	  data: JSON.stringify({ // Convert data object to JSON string
			        currentPage: currPage
			      }),
				  success : function(JSONData, status) {
					  if(JSONData.product.length != 0){
						  console.log(++currPage);
						  console.log("complete")
						  console.log(JSONData);
						  
						 
						  
						  for(let i = 0; JSONData.product.length > i; i++){
							  var displayValue = "";
							  console.log(JSONData.product[i].prodName);
							  displayValue += '<div class="col-sm-6 col-md-4">' +
													    '<div class="thumbnail">'+
													      '<a href="#"><img  src="/images/uploadFiles/'+JSONData.product[i].fileName+'" alt="..."></a>'+
													      '<div class="caption">'+
													        '<h3>'+JSONData.product[i].prodName+'</h3>'+
													        '<p>...</p>'+
													      '</div>'+
													    '</div>'+
													  '</div>'
							$("#test").append(displayValue);
						  }
						  
						  
							  
						 
					  }else{
						  console.log("페이지 끝");
					  }
					  
											 
				  }
				
    		  });
      
      
    }
});


</script>

<style type="text/css">
	
body { padding-top:50px;}


	
</style>

</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">
		<div class="page-header text-left">
			<h3>
				<c:if test="${param.menu == 'search' }">
							상품 목록조회								
				</c:if>
				<c:if test="${param.menu == 'manage' }">
							상품 관리								
				</c:if>
			</h3>
		</div>
	
		<div class="row">
		
			<div class="col-md-6 pull-left">
				<div>전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지</div>
			</div>
		
			<div class="col-md-6 pull-right">
				<form class="form-inline" name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">
				
					<select name="searchCondition" class="form-control">
							<option value="0" ${! empty search.searchCondition && search.searchCondition == 0 ? "selected" : ""} >상품번호</option>
							<option value="1" ${search.searchCondition.trim().equals("1") ? "selected" : ""}>상품명</option>
							<option value="2" ${search.searchCondition.trim().equals("2") ? "selected" : ""}>상품가격</option>
					</select> 
							
					<div class="form-group">
						<input type="text" name="searchKeyword" value="${search.searchKeyword}" class="form-control" />
						<button type="button" class="btn btn-default">검색</button>
					</div>
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
			</div>
			
		</div>
	
		<table class="table table-hover table-striped">
				
				<thead>
				
				<tr>
					<td>No</td>
					<td>상품명</td>
					<td>가격</td>
					<td>등록일</td>
					<td>현재상태</td>
				</tr>
				
				</thead>
				

				<tbody>
				<c:set var="i" value="0"></c:set>
				<c:forEach var="product" items="${product}">
				<c:set var="i" value="${i+1}"></c:set>
					<tr>
					<td align="center">${i}</td>
					<td align="left" id="${i}">
					<c:url var="getProduct" value="/product/getProduct" >
						<c:param name="prodNo" value="${product.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					<c:url var="updateProductView" value="/product/updateProductView">
						<c:param name="prodNo" value="${product.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					<c:if test="${param.menu eq 'search' }">
					<a href="${getProduct}">${product.prodName}</a>
					</c:if>
					<c:if test="${param.menu eq 'manage' }">
					<a href="${updateProductView}">${product.prodName}</a>
					</c:if>
					
					
					</td>
					<td align="left">${product.price}</td>
					<td align="left">${product.regDate}</td>
					<td>
					<c:choose>
						<c:when test='${product.proTranCode.trim().equals("1") || product.proTranCode == null}'>판매중</c:when>
						<c:when test='${lproductist.proTranCode.trim().equals("2")}'>
							판매완료
							<c:if test='${param.menu.equals("manage") }'>
								<a href="/purchase/updateTranCodeByProd?tranNo=${product.proTranNo}&tranCode=3">
								(배송시작)
								</a>
							</c:if>
						</c:when>
						<c:when test='${product.proTranCode.trim().equals("3")}'>배송중</c:when>
						<c:when test='${product.proTranCode.trim().equals("4")}'>배송완료</c:when>
					</c:choose>
					</td>
					<td align="left">
					<i class="glyphicon glyphicon-triangle-bottom" value2="${i}"></i>
					<input type="hidden" value1="${product.prodNo}" value2="${i}"/>
					</td>
			
			</c:forEach>
			
				</tbody>
				
			</table>
			
			<jsp:include page="../common/pageNavigator_new.jsp"/>
		
	</div>



	<div class="container" >
	
	
	
		<div class="row" id="test">
		
		<c:set var="i" value="0"></c:set>
		<c:forEach var="product" items="${product}">
		<c:set var="i" value="${i+1}"></c:set>
		
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail">
		      <img src="/images/uploadFiles/${product.fileName}" alt="...">
		      <div class="caption">
		        <h3>${product.prodName}</h3>
		        <p>...</p>
		        <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
		      </div>
		    </div>
		  </div>
		  
	  	</c:forEach>
		  
		</div>
		
	
	
	</div>






</body>
</html>
