<!doctype html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="edge" />

<title>佰仟租赁业务管理系统</title>
<link rel="shortcut icon" href="${webResourceRoot}/favicon.ico" />
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/easyui.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/insdep_theme_default.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/themes/insdep/icon.css" rel="stylesheet" type="text/css">
<link href="${webResourceRoot}/static/ui/insdep/plugin/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/jquery.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/ui/insdep/themes/insdep/jquery.insdep-extend.min.js"></script>
<script type="text/javascript" src="${webResourceRoot}/static/js/common-utils.js"></script>
<script type="text/javascript">
	var webResourceRoot = "${webResourceRoot}", basePath = "${basePath}";
</script>

<!-- CSS BEGIN -->
<style type="text/css">
  .theme-left-user-panel {
    padding: 30px 20px 12px;
    background-image: url('${webResourceRoot}/static/images/nav-profile.png');
    background-size: cover;
   }
  .theme-header-layout { height:46px !important; background:#263238 url(${webResourceRoot}/static/images/logo00.png) left center no-repeat;}
  .theme-left-layout{background:#263238;}
  .theme-left-layout .datagrid-row-selected, .theme-left-layout .datagrid-row-over, .theme-left-layout .accordion-header-selected .accordion .accordion-collapse:link, .accordion .accordion-collapse:visited, .accordion .accordion-collapse:hover, .accordion .accordion-collapse:active, .accordion .accordion-collapse:focus, .accordion .accordion-expand:link, .accordion .accordion-expand:visited, .accordion .accordion-expand:hover, .accordion .accordion-expand:active, .accordion .accordion-expand:focus {
    background-color: #263238;
  }
  /* 菜单样式 by xiangxin.zou */
  .tree-node-hover, .tree-node-selected {text-decoration:none; background-color: #1E1E1E;}
  div.panel > div.panel-body.accordion-body > div {padding:10px 0px !important;}
</style>
<!-- CSS END -->

</head>

<body>
	<div id="master-layout">
        <div data-options="region:'north',border:false,bodyCls:'theme-header-layout'">
        	<div class="theme-navigate">
                <div class="left">
                    <a class="easyui-linkbutton left-control-switch" style="cursor: pointer;"><i class="fa fa-bars fa-lg" title="伸缩左菜单"></i></a>
                </div>
                
                <div class="right">
                	<a class="easyui-linkbutton a-cursor-pointer">展厅选择</a>
                	<a class="easyui-linkbutton a-cursor-pointer">修改密码</a>
                	<a class="easyui-linkbutton a-cursor-pointer" onclick="logout()">退出系统</a>
                    <a class="easyui-menubutton theme-navigate-more-button" data-options="menu:'#more',hasDownArrow:false"></a>
                    <div id="more" class="theme-navigate-more-panel">
                    	<div>联系我们</div>
                        <div>参与改进计划</div>
                        <div>检测更新</div>
                        <div>关于</div>
                    </div>
                </div>
            </div>
        
        </div>

        <!--开始左侧菜单-->
        <div data-options="region:'west',border:false,bodyCls:'theme-left-layout'" style="width:220px;">
            <!--正常菜单--> 
            <div class="theme-left-normal">
                <!--start class="easyui-layout"-->
                <div class="easyui-layout" data-options="border:false,fit:true"> 
                    <!--start region:'north'-->
                    <div data-options="region:'north',border:false" style="height:100px;">
                        <!--start theme-left-user-panel-->
                        <div class="theme-left-user-panel">
                            <dl>
                                <dt>
                                    <img src="${webResourceRoot}/static/ui/insdep/themes/insdep/images/portrait86x86.png" width="43" height="43">
                                </dt>
                                <dd>
                                    <b class="badge-prompt"><@shiro.principal/></b>
                                    <span>系统管理员</span>
                                </dd>

                            </dl>
                        </div>
                        <!--end theme-left-user-panel-->
                    </div>   
                    <!--end region:'north'-->

                    <!--start region:'center'-->
                    <div data-options="region:'center',border:false">

                        <!--start easyui-accordion--> 
                        <div id="left_content" class="easyui-accordion" data-options="border:false,fit:true">   
                        </div>
                        <!--end easyui-accordion--> 

                    </div>
                    <!--end region:'center'-->
                </div>  
                <!--end class="easyui-layout"-->

            </div>
            <!--最小化菜单--> 
            <div class="theme-left-minimal">
                <ul class="easyui-datalist" data-options="border:false,fit:true">
                    <li><i class="fa fa-home fa-2x"></i><p>主题</p></li>
                    <li><i class="fa fa-book fa-2x"></i><p>组件</p></li>
                    <li><i class="fa fa-pencil fa-2x"></i><p>编辑</p></li>
                    <li><i class="fa fa-cog fa-2x"></i><p>设置</p></li>
                    <li><a class="left-control-switch"><i class="fa fa-chevron-right fa-2x"></i><p>打开</p></a></li>
                </ul>
            </div>

        </div>
        <!--结束左侧菜单--> 

        <div data-options="region:'center',border:false"  id="control" style="background:#ECF0F5;margin:0px;padding:0px;">
             <div id="content_tabs" class="easyui-tabs" data-options="plain:true,iconCls:'icon-reload'" style="margin:0px;padding:0px;width:100%;height:100%;">
				<div title="主页">
					<img src="${webResourceRoot}/static/images/workpage.png"/>
				</div>
			</div>
        </div>
    </div>
    
    <!-- JAVASCRIPT BEGIN -->
    <script type="text/javascript" src="${webResourceRoot }/static/js/json2.js"></script>

    <script type="text/javascript">
    $(function(){
		/*布局部分*/
		$('#master-layout').layout({
			fit:true/*布局框架全屏*/
		});   

            /*右侧菜单控制部分*/

            var left_control_status=true;
            var left_control_panel=$("#master-layout").layout("panel",'west');

        $(".left-control-switch").on("click",function(){
            if(left_control_status){
                left_control_panel.panel('resize',{width:70});
                left_control_status=false;
                $(".theme-left-normal").hide();
                $(".theme-left-minimal").show();
            }else{
                left_control_panel.panel('resize',{width:220});
                left_control_status=true;
                $(".theme-left-normal").show();
                $(".theme-left-minimal").hide();
            }
            $("#master-layout").layout('resize', {width:'100%'})
        });
        
        /*右侧菜单控制结束*/
        
      //加载菜单
		$.ajax({  
            type : 'POST',  
            dataType : "json",  
            url : '${basePath }/sys/resource/getParentMenu',  
            success : function(data) {  
                $.each(data, function(i, n) {//加载父类节点即一级菜单  
                    if (i == 0) {//显示第一个一级菜单下的二级菜单  
                        $('#left_content').accordion('add', {
                            title : n.resourceName,  
                            //iconCls : n.icon,  
                            selected : true,  
                            content : '<div style="padding:10px"><ul name="'+n.resourceName+'"></ul></div>',  
                        });  
                    } else {  
                        $('#left_content').accordion('add', {  
                            title : n.resourceName,  
                            iconCls : n.icon,  
                            selected : false,  
                            content : '<div style="padding:10px"><ul name="'+n.resourceName+'"></ul></div>',  
                        });  
                    }
                    // 屏蔽左下角出现"javascript:;;"
                    $("#left_content>.panel .panel-tool>a").removeAttr("href");
        			//alert($("#left_content>.panel .panel-tool>a").length);
  
                });  
            }  
        }); 
        
		//异步加载子节点，即二级菜单  
        $('#left_content').accordion({  
            onSelect : function(title, index) {  
                $("ul[name='" + title + "']").tree({  
                    url : '${basePath}/sys/resource/getMenuTree',  
                    queryParams : {
                        title : title  
                    },  
                    animate : true,  
                    //lines : true,//显示虚线效果    
                    onClick: function(node){  
                    	if(node.url){//判断url是否存在，存在则创建tabs  
                    		openTab(node.text,'${basePath}/'+node.url)
                        }  
                    }  
                });  
            }  
        }); 
        
     }); 
    
		function doSearch(value,name){
			alert('You input: ' + value+'('+name+')');
		}
		
		/*
			添加选项卡
		     
		*/
		function openTab(title, url){
			if ($('#content_tabs').tabs('exists', title)){
				$('#content_tabs').tabs('select', title);
				var currentTab = $('#content_tabs').tabs('getSelected')
				var panel_content = currentTab.panel('options');
				var ifram_content = $(panel_content).attr("content");
				var origUrl = $(ifram_content).attr("src");
				
				//console.log("====>"+ifram_content);
				console.log("\n==>url:"+origUrl);
				
				if(origUrl != url){
					refreshTab(title, url);
				}
			} else {
				var content = null;
				if(url == null || url == '') {
					content = "页面无信息...";
				}else{
					content = '<iframe scrolling="auto" frameborder="0" src="'+url+'" style="margin:0px;padding:0px;width:100%;height:100%;"></iframe>';
				}
				
				$('#content_tabs').tabs('add',{
					title:title, content:content, closable:true,tools:[{
						iconCls:'icon-mini-refresh',
						handler:function(){
							$('#content_tabs').tabs('select', title);
							refreshTab();
						}
					}]
				});
			}
		}
		/**
	     * 刷新选中tab; 
		 * @param  distTabObj   为空表示刷新本身；
		 * @param  url：为空表示刷新本身，不为空则更新目标tab中的内容
		*/
		function refreshTab(distTabTitle, url) {
	        var currentTab = null;
	        if(isUndefined(distTabTitle) || isBlank(distTabTitle)) {
	        	currentTab = $('#content_tabs').tabs('getSelected');
	        } else {
	        	currentTab = $('#content_tabs').tabs("getTab", distTabTitle);
	        }
			
			var tabOptions = {};
			if(!isUndefined(url) && !isBlank(url)){
				tabOptions = {
						href: url
				};
			}
	        $('#content_tabs').tabs('update', {
	            tab: currentTab,
	            options: tabOptions
	        });
	        currentTab.panel('refresh');
		}
		
		/**
		关闭Tab
		*/
		function closeTab(title){
			$('#content_tabs').tabs('close', title || $('#content_tabs').tabs('getSelected').panel('options').title);
		}
	 function logout(){
		 $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
             if (r) {
                 location.href = '${basePath}/admin/logout';
             }
         });
     }	 
    </script>
</body>
</html>
