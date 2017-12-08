<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="edge" />
<link rel="shortcut icon" href="favicon.ico" />

<title>佰仟租赁牵台车管理系统</title>
<link rel="shortcut icon" href="${webResourceRoot}/favicon.ico" />
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/plugin/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!-- <link href="${webResourceRoot}/static/css/swiper.min.css" rel="stylesheet" type="text/css"> -->

<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/jquery.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/js/common-utils.js"></script>
<!-- <script type="text/javascript" src="${webResourceRoot}/static/js/swiper.jquery.min.js"></script> -->

<style type="text/css">
#theme-login-form {padding: 40px 0 40px; margin: 200px auto 50px auto;opacity:0.5;}
</style>
</head>

<body class="theme-login-layout" style="background:url(${webResourceRoot}/static/images/carousel_01.jpg) no-repeat !important;overflow:hidden; ">
		<div id="theme-login-form" style="width: 400px;">
            <form id="form" class="theme-login-form" method="post">  
	            <dl>
	                <dt><img src="${webResourceRoot}/static/images/logo-color.png" style="display:block"></dt>
	                  <dd><input id="username" name="userAccount" value="caradmin" class="theme-login-text"  style="width:100%;"/></dd>
	                  <dd><input id="password" name="password" value="000000" class="theme-login-text"  style="width:100%;"/></dd>
	                  <dd>
	                    <a class="submit" href="javascript:void(0)" onclick="submitForm()">登录</a>
	                    <!-- <a class="easyui-linkbutton button" href="index.html">forgotten ?</a> -->
	                  </dd>
	            </dl>
            </form>
        </div>

    	<div class="theme-login-footer" style="width: 400px;color:white;text-align:center;">
        	<dl>
        		<dd>&copy <script>var year = new Date();document.write(year.getFullYear());</script> 佰仟融资租赁有限公司.版权所有</dd>
        	</dl>
        </div>

    <script>
    	$(function(){		
			$.extend($.fn.validatebox.defaults.tipOptions, {
				onShow: function() {
					$(this).tooltip("tip").css({backgroundColor:"#ff7e00", border: "none",color: "#fff"});
					
				}
			})

			/*布局部分*/
			$('#theme-login-layout').layout({
				fit:true/*布局框架全屏*/
			});   
			
			$('#username').textbox({    
				prompt:'请输入用户名',
				required:true
				//,missingMessage:"请输入用户名"
			});
			$('#password').textbox({    
				type:"password",
				prompt:'请输入密码',
				required:true
				//,missingMessage:"请输入密码"
			});
			
			$('.submit').linkbutton({    
				
			}); 
			
			/*验证码tooltip*/
			
			$('#form').form({
				url:"${basePath}/admin/loginCheck",
				onSubmit:function(){
					var res=$(this).form('enableValidation').form('validate');
					//res?$.messager.progress():"";
					//$.messager.progress();
					return res;
				},
				success: function(data){ 
					var data = eval( '(' + data + ')' );
					if(data.code == 0){
						window.location.href = '${basePath }/admin/main';
					}else {
						$.messager.alert('提示', data.msg);
					}
				    //$.messager.progress('close');
					/* try 
					{ alert(2);
						var data = eval('(' + data + ')');
						if (!data.success){    
							$.messager.alert('提示',data.message,'error',function(){
								$('#username,#password').textbox('clear');
							});
						}else{
							window.location.reload();
						}
					} 
					catch (e) 
					{ 
						$.insdep.error(data);
					} */ 

				}
			});	
			
			/*验证码tooltip*/
			
		});
    	
    	function submitForm(){
            $('#form').form('submit');
        }
    	
    </script>
</body>
</html>

