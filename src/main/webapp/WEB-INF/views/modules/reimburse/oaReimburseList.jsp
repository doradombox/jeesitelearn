<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报销申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/reimburse/oaReimburse/">报销申请列表</a></li>
		<shiro:hasPermission name="reimburse:oaReimburse:edit"><li><a href="${ctx}/reimburse/oaReimburse/form">报销申请添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaReimburse" action="${ctx}/reimburse/oaReimburse/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>出差人：</label>
				<sys:treeselect id="user" name="user.id" value="${oaReimburse.user.id}" labelName="user.name" labelValue="${oaReimburse.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>出差天数：</label>
				<form:input path="businessDays" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>出差人</th>
				<th>月份</th>
				<th>报销日期</th>
				<th>报销类型</th>
				<th>出差天数</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>报销总和</th>
				<shiro:hasPermission name="reimburse:oaReimburse:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaReimburse">
			<tr>
				<td><a href="${ctx}/reimburse/oaReimburse/form?id=${oaReimburse.id}">
					${oaReimburse.user.name}
				</a></td>
				<td>
					${oaReimburse.month}
				</td>
				<td>
					${oaReimburse.reimburseDate}
				</td>
				<td>
					${fns:getDictLabel(oaReimburse.reimburseType, 'reimburseType', '')}
				</td>
				<td>
					${oaReimburse.businessDays}
				</td>
				<td>
					<fmt:formatDate value="${oaReimburse.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${oaReimburse.remarks}
				</td>
				<td>
					${oaReimburse.bxzh}
				</td>
				<shiro:hasPermission name="reimburse:oaReimburse:edit"><td>
    				<a href="${ctx}/reimburse/oaReimburse/form?id=${oaReimburse.id}">修改</a>
					<a href="${ctx}/reimburse/oaReimburse/delete?id=${oaReimburse.id}" onclick="return confirmx('确认要删除该报销申请吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>