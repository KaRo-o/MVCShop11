
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
	
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-hover">
				
				<thead>
				
					<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>
				
				</thead>
				

				<tr>
				<c:set var="i" value="0"></c:set>
				<c:forEach var="list" items="${list}">
					<c:set var="i" value="${i+1}"></c:set>
					<tr class="ct_list_pop">
					<td align="center">${i}</td>
					<td></td>
					<td align="left">
					
					
					<c:url var="getProduct" value="/product/getProduct" >
						<c:param name="prodNo" value="${list.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					<c:url var="updateProductView" value="/product/updateProductView">
						<c:param name="prodNo" value="${list.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					
					
					<c:if test="${param.menu eq 'search' }">
					<a href="${getProduct}">${list.prodName}</a>
					</c:if>
					<c:if test="${param.menu eq 'manage' }">
					<a href="${updateProductView}">${list.prodName}</a>
					</c:if>
					
					
					</td>
					<td></td>
					<td align="left">${list.price}</td>
					<td></td>
					<td align="left">${list.regDate}</td>
					<td></td>
					<td>
					<c:choose>
						<c:when test='${list.proTranCode.trim().equals("1") || list.proTranCode == null}'>판매중</c:when>
						<c:when test='${list.proTranCode.trim().equals("2")}'>
							판매완료
							<c:if test='${param.menu.equals("manage") }'>
								<a href="/purchase/updateTranCodeByProd?tranNo=${list.proTranNo}&tranCode=3">
								(배송시작)
								</a>
							</c:if>
						</c:when>
						<c:when test='${list.proTranCode.trim().equals("3")}'>배송중</c:when>
						<c:when test='${list.proTranCode.trim().equals("4")}'>배송완료</c:when>
					</c:choose>
					</td>
				
				</tr>
				
			</c:forEach>

			</table>
			
			<jsp:include page="../common/pageNavigator_new.jsp"/>
		
	</div>









<!-- ------------------------기존 코드 -------------------------------- -->
	<%--  <div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/product/listProduct?menu=${param.menu }"
			method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
								
								<c:if test="${param.menu == 'search' }">
											상품 목록조회								
								</c:if>
								<c:if test="${param.menu == 'manage' }">
											상품 관리								
								</c:if>
								</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

					<td align="right"><select name="searchCondition" class="ct_input_g" style="width: 80px">
							<option value="0" ${! empty search.searchCondition && search.searchCondition == 0 ? "selected" : ""} >상품번호</option>
							<option value="1" ${search.searchCondition.trim().equals("1") ? "selected" : ""}>상품명</option>
							<option value="2" ${search.searchCondition.trim().equals("2") ? "selected" : ""}>상품가격</option>
					</select> <input type="text" name="searchKeyword" value="${search.searchKeyword}" class="ct_input_g"
						style="width: 200px; height: 19px" /></td>


					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetProductList(1);">검색</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
					</td>
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
					<td class="ct_list_b">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>

				<tr>
				<c:set var="i" value="0"></c:set>
				<c:forEach var="list" items="${list}">
					<c:set var="i" value="${i+1}"></c:set>
					<tr class="ct_list_pop">
					<td align="center">${i}</td>
					<td></td>
					<td align="left">
					
					
					<c:url var="getProduct" value="/product/getProduct" >
						<c:param name="prodNo" value="${list.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					<c:url var="updateProductView" value="/product/updateProductView">
						<c:param name="prodNo" value="${list.prodNo}"/>
						<c:param name="name" value="${param.menu}"/>
					</c:url>
					
					
					<c:if test="${param.menu eq 'search' }">
					<a href="${getProduct}">${list.prodName}</a>
					</c:if>
					<c:if test="${param.menu eq 'manage' }">
					<a href="${updateProductView}">${list.prodName}</a>
					</c:if>
					
					
					</td>
					<td></td>
					<td align="left">${list.price}</td>
					<td></td>
					<td align="left">${list.regDate}</td>
					<td></td>
					<td>
					<c:choose>
						<c:when test='${list.proTranCode.trim().equals("1") || list.proTranCode == null}'>판매중</c:when>
						<c:when test='${list.proTranCode.trim().equals("2")}'>
							판매완료
							<c:if test='${param.menu.equals("manage") }'>
								<a href="/purchase/updateTranCodeByProd?tranNo=${list.proTranNo}&tranCode=3">
								(배송시작)
								</a>
							</c:if>
						</c:when>
						<c:when test='${list.proTranCode.trim().equals("3")}'>배송중</c:when>
						<c:when test='${list.proTranCode.trim().equals("4")}'>배송완료</c:when>
					</c:choose>
					</td>
				
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>

			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value=""/>
						<jsp:include page="../common/pageNavigator.jsp"/>	
						
					</td>
				</tr>
			</table>
			<!--  페이지 Navigator 끝 -->

		</form>

	</div> --%> 
</body>
</html>
