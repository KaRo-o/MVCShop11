<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>



<html>
<head>
<title>상품등록</title>

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

<script type="text/javascript" src="../javascript/calendar.js">



</script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
var i = 0;

function fncAddProduct(){
	//Form 유효성 검증
 	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}

	document.detailForm.action='/product/addProduct';
	document.detailForm.submit();
}

function resetData(){
	document.detailForm.reset();
}

function appendImageSlot() {
	i++
	var newNode = '<div id='+i+'><input type="file" name="fileName" accept="image/*" class="pull-left" style="width:90%">'
						+'<button type="button" class="close pull-right" onclick="javascript:removeImageSlot('+i+');" >&times;</button></div>';
	
	$('.inputImageTd').append(newNode);
	
}

$(function() {
	$('#confirm').on('click', function() {
		fncAddProduct();
	});
});


function removeImageSlot(j) {

	/* $('.inputImageTd div:last-child').remove(); */
	/* $('.inputImageTd div input:button:last-child').remove(); */
	$('#'+j+'').remove();
	
}


$(function(){
		
	$('.addImageSlot').on('click',function(){
		appendImageSlot();
	});
	
	
	
	
	
});


</script>
<style type="text/css">
	body { padding-top:50px;}
</style>
</head>

<body bgcolor="#ffffff" text="#000000">

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">
	<div class="page-header text-center">
		<h3>상품등록</h3>
	</div>

	<form name="detailForm" method="post" enctype="multipart/form-data" class="form-horizontal">
	
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">상품명</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="prodName" placeholder="상품명">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">상품상세정보</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="prodDetail" placeholder="상품 상세정보">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">제조일자</label>
			<div class="col-sm-4">
				<input type="text" name="manuDate" readonly="readonly" class="form-control" placeholder="이곳을 클릭하여 날짜를 선택하세요"
				onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
			</div>
			<!-- <img src="../images/ct_icon_date.gif" width="26" height="26" 
							onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/> -->
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">가격</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="price" placeholder="가격">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">상품이미지</label>
			<input type="button" class="addImageSlot btn btn-info" value="이미지 추가">
			<div class="col-sm-4 inputImageTd" >
			</div>
		</div>
		
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="confirm" >등&nbsp;록</button>
			  <a class="btn btn-primary" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		
	
	</form>
	
</div>

</body>
</html>