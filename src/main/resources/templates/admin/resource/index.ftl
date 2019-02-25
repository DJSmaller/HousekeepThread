<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>资源列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${ctx!}/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="${ctx!}/assets/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">

    <link href="${ctx!}/assets/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/assets/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-title">
                        <h5>家政资源管理</h5>
                    </div>
                    <div class="ibox-content">
                        <p>
                        	<@shiro.hasPermission name="system:resource:add">
                        		<button class="btn btn-success " type="button" onclick="add();"><i class="fa fa-plus"></i>&nbsp;添加</button>
                        	</@shiro.hasPermission>
                        </p>
                        <hr>
                        <div class="row row-lg">
		                    <div class="col-sm-12">
		                        <!-- Example Card View -->
		                        <div class="example-wrap">
		                            <div class="example">
		                            	<table id="table_list"></table>
		                            </div>
		                        </div>
		                        <!-- End Example Card View -->
		                    </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 全局js -->
    <script src="${ctx!}/assets/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/assets/js/bootstrap.min.js?v=3.3.6"></script>


	<!-- Bootstrap table -->
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

    <!-- Peity -->
    <script src="${ctx!}/assets/js/plugins/peity/jquery.peity.min.js"></script>

    <script src="${ctx!}/assets/js/plugins/layer/layer.min.js"></script>

    <!-- 自定义js -->
    <script src="${ctx!}/assets/js/content.js?v=1.0.0"></script>

    <!-- Page-Level Scripts -->
    <script>
        $(document).ready(function () {
			//初始化表格,动态从服务器加载数据
			$("#table_list").bootstrapTable({
			    //使用get请求到服务器获取数据
			    method: "POST",
			    //必须设置，不然request.getParameter获取不到请求参数
			    contentType: "application/x-www-form-urlencoded",
			    //获取数据的Servlet地址
			    url: "${ctx!}/admin/resource/list",
			    //表格显示条纹
			    striped: true,
			    //启动分页
			    pagination: true,
			    //每页显示的记录数
			    pageSize: 10,
			    //当前第几页
			    pageNumber: 1,
			    //记录数可选列表
			    pageList: [5, 10, 15, 20, 25],
			    //是否启用查询
			    search: true,
			    //是否启用详细信息视图
			    detailView:true,
			    detailFormatter:detailFormatter,
			    //表示服务端请求
			    sidePagination: "server",
			    //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder
			    //设置为limit可以获取limit, offset, search, sort, order
			    queryParamsType: "undefined",
			    //json数据解析
			    responseHandler: function(res) {
			        return {
			            "rows": res.content,
			            "total": res.totalElements
			        };
			    },
			    //数据列
			    columns: [{
			        title: "ID",
			        field: "id",
			        sortable: true
			    },{
			        title: "客户名称",
			        field: "name"
			    },{
                    title: "客户电话",
                    field: "phoneNum"
                },{
                    title: "服务项",
                    field: "serviceItem",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">保姆</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">月嫂</span>';
                    }
                },{
                    title: "产品类型",
                    field: "type",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">住家</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">钟点</span>';
                    }
                },{
                    title: "服务内容",
                    field: "serviceContent",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">做饭</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">打扫卫生</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">照顾老人</span>';
                        else if(value == 3)
                            return '<span class="label label-primary">照顾小孩</span>';
                    }
                },{
                    title: "年龄要求",
                    field: "ageRange",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">35岁以下</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">36岁-40岁</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">41岁-45岁</span>';
                        else if(value == 3)
                            return '<span class="label label-primary">46岁及以上</span>';
                    }
                },{
                    title: "哪天要保姆",
                    field: "dayHk",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">7天内</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">30天内</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">30天以上</span>';
                        else if(value == 3)
                            return '<span class="label label-primary">待定</span>';
                    }
                },{
                    title: "要多久保姆",
                    field: "howLongHk",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">7天内</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">30天内</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">30天以上</span>';
                        else if(value == 3)
                            return '<span class="label label-primary">待定</span>';
                    }
                },{
                    title: "是否是目标客户",
                    field: "target",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">是</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">否</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">待定</span>';
                    }
                },{
                    title: "线索等级",
                    field: "level",
                    formatter: function(value,row,index){
                        if(value == 0)
                            return '<span class="label label-info">A</span>';
                        else if(value == 1)
                            return '<span class="label label-primary">B</span>';
                        else if(value == 2)
                            return '<span class="label label-primary">C</span>';
                    }
                },
                    {
                    title: "预算金额",
                    field: "money",

                },{
			        title: "下次跟进时间",
			        field: "sourceKey",
                    sortable: true

                },{
			        title: "创建时间",
			        field: "createTime",
			        sortable: true
			    },{
			        title: "更新时间",
			        field: "updateTime",
			        sortable: true
			    },
                    {
			        title: "操作",
			        field: "empty",
                    formatter: function (value, row, index) {
                    	var operateHtml = '<@shiro.hasPermission name="system:resource:add"><button class="btn btn-primary btn-xs" type="button" onclick="edit(\''+row.id+'\')"><i class="fa fa-edit"></i>&nbsp;修改</button> &nbsp;</@shiro.hasPermission>';
                    	operateHtml = operateHtml + '<@shiro.hasPermission name="system:resource:deleteBatch"><button class="btn btn-danger btn-xs" type="button" onclick="del(\''+row.id+'\')"><i class="fa fa-remove"></i>&nbsp;删除</button></@shiro.hasPermission>';
                        return operateHtml;
                    }
			    }]
			});
        });

        function edit(id){
        	layer.open({
        	      type: 2,
        	      title: '资源修改',
        	      shadeClose: true,
        	      shade: false,
        	      area: ['893px', '600px'],
        	      content: '${ctx!}/admin/resource/edit/' + id,
        	      end: function(index){
        	    	  $('#table_list').bootstrapTable("refresh");
       	    	  }
        	    });
        }
        function add(){
        	layer.open({
        	      type: 2,
        	      title: '资源添加',
        	      shadeClose: true,
        	      shade: false,
        	      area: ['893px', '600px'],
        	      content: '${ctx!}/admin/resource/add',
        	      end: function(index){
        	    	  $('#table_list').bootstrapTable("refresh");
       	    	  }
        	    });
        }
        function del(id){
        	layer.confirm('确定删除吗?', {icon: 3, title:'提示'}, function(index){
        		$.ajax({
    	    		   type: "POST",
    	    		   dataType: "json",
    	    		   url: "${ctx!}/admin/resource/delete/" + id,
    	    		   success: function(msg){
	 	   	    			layer.msg(msg.message, {time: 2000},function(){
	 	   	    				$('#table_list').bootstrapTable("refresh");
	 	   	    				layer.close(index);
	 	   					});
    	    		   }
    	    	});
       		});
        }

        function detailFormatter(index, row) {
	        var html = [];
	        html.push('<p><b>描述:</b> ' + row.description + '</p>');
	        return html.join('');
	    }
    </script>




</body>

</html>
