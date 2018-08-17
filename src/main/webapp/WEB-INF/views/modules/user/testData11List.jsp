<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>user管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
		        top.$.jBox.confirm("确认要导出片区数据吗？","系统提示",function(v,h,f){
		            if(v=="ok"){
		                $("#searchForm").attr("action","${ctx}/user/testData11/export");
		                $("#searchForm").submit();
		            }
		        },{buttonsFocus:1});
		        top.$('.jbox-body .jbox-icon').css('top','55px');
		    });
		    $("#btnImport").click(function(){
		        $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
		            bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
		    });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
	    <form id="importForm" action="${ctx}/user/testData11/import" method="post" enctype="multipart/form-data"
	        class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
	        <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
	        <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
	        <a href="${ctx}/user/testData11/import/template">下载模板</a>
	    </form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/user/testData11/">user列表</a></li>
		<shiro:hasPermission name="user:testData11:edit"><li><a href="${ctx}/user/testData11/form">user添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testData11" action="${ctx}/user/testData11/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns">
			     <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			     <input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
			 </li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="user:testData11:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="testData11">
			<tr>
				<td><a href="${ctx}/user/testData11/form?id=${testData11.id}">
					${testData11.name}
				</a></td>
				<td>
					<fmt:formatDate value="${testData11.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${testData11.remarks}
				</td>
				<shiro:hasPermission name="user:testData11:edit"><td>
    				<a href="${ctx}/user/testData11/form?id=${testData11.id}">修改</a>
					<a href="${ctx}/user/testData11/delete?id=${testData11.id}" onclick="return confirmx('确认要删除该user吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>