<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<html>
<head>
    <title></title>
    <style type="text/css">
        html,body {
            overflow:hidden;
            margin:0px;
            width:100%;
            height:100%;
        }
        .virtual_body {
            width:100%;
            height:100%;
            overflow-y:scroll;
            overflow-x:auto;
        }
        .fixed_div {
            position:absolute;
            z-index:2008;
            bottom:20px;
            width:100px;
            height:40px;
            border:1px solid red;
            background:#e5e5e5;
            right:  20px;
            top: 50%;
            transform: translateY(-50%); 
            
        }
    </style>
</head>
<body>
<div class="fixed_div">I am still here!</div>
<div class="virtual_body">
    <div style="height:888px;">
        I am content !
    </div>
</div>
</body>
</html>