<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.alert_wrap .show{
		position:fixed;
		right:-100%;
		top:10%;
		background-color:#ccc;
		display:inline-block;
		padding:10px 20px;
		z-index:1002;
		border-radius:10px;
	}
	.alert_wrap .show.warning{
		background-color:#ff4b25;
		color:#fff;
		font-weight:700;
		right:50px;
	}
	
	.alert_wrap .show.success{
		background-color:#377cd2;
		color:#fff;
		font-weight:700;
		right:50px;
		opacity:1;
	}
</style>
<div class="alert_wrap">
	<ul>
		<li class="show">
		</li>
	</ul>
</div>
<script>
	function alertShow(txt){
		var txt = "";
		$(".alert_wrap .show").addClass("warning").text(txt);
		$(".alert_wrap .show").animate({right:"20px"},2000);
	}

	function alertWarning(){
		setTimeout(function(){
			$('.alert_wrap .show').fadeOut(500).removeClass('warning');
		},2000);
	}
	
	function alertSuccess(){
		setTimeout(function(){
			$('.alert_wrap .show').fadeOut(500).removeClass('success');
		},2000);
	}
</script>