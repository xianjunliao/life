<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<style>
body {
	margin: 0;
	padding: 0;
}

.stand-main {
	width: 210mm;
	height: 297mm;
}

.stand-img {
	width: 210mm;
	height: 297mm;
}
</style>
<script type="text/javascript">
	
</script>

</head>
<body>
	<div class="stand-main" id="stand-main">
		<div class='stand-img'>
			<img id="${sf.id}" title="${sf.filename}" name='attachment' src='${sf.url}' width='100%' height='100%' />
		</div>
	</div>
</body>
</html>
