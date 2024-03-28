<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>



<html>
<head>
<title>��ǰ���</title>

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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<script type="text/javascript" src="../javascript/calendar.js">



</script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
var i = 0;

function fncAddProduct(){
	//Form ��ȿ�� ����
 	var name = document.detailForm.prodName.value;
	var detail = document.detailForm.prodDetail.value;
	var manuDate = document.detailForm.manuDate.value;
	var price = document.detailForm.price.value;

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

	document.detailForm.action='/product/addProduct';
	document.detailForm.submit();
}

function resetData(){
	document.detailForm.reset();
}

function appendImageSlot() {
	i++
	var newNode = '<span id='+i+'><input type="file" name="fileName" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13">'
						+'<input type="button" class="btn btn-danger" onclick="javascript:removeImageSlot('+i+');" value="����"></span>';
	
	$('.inputImageTd').append(newNode);
	
}


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
		<h3>��ǰ���</h3>
	</div>

	<form name="detailForm" method="post" enctype="multipart/form-data" class="form-horizontal">
	
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">��ǰ��</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="prodName">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">��ǰ������</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="prodDetail">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">��������</label>
			<div class="col-sm-4">
				<input type="text" name="manuDate" readonly="readonly" class="form-control" 
				onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
			</div>
			<img src="../images/ct_icon_date.gif" width="26" height="26" 
							onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">����</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" name="price">
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-3 col-sm-offset-1 control-label">��ǰ�̹���</label>
			<div class="col-sm-4 inputImageTd">
				
			</div>
			<input type="button" class="addImageSlot btn btn-info" value="�̹��� �߰�">
		</div>
		
	
	</form>
	
</div>

</body>
</html>