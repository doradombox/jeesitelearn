<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报销申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/reimburse/oaReimburse/">报销申请列表</a></li>
		<li class="active"><a href="${ctx}/reimburse/oaReimburse/form?id=${oaReimburse.id}">报销申请<shiro:hasPermission name="reimburse:oaReimburse:edit">${not empty oaReimburse.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="reimburse:oaReimburse:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaReimburse" action="${ctx}/reimburse/oaReimburse/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">出差人：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${oaReimburse.user.id}" labelName="user.name" labelValue="${oaReimburse.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">月份：</label>
			<div class="controls">
				<form:input path="month" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报销日期：</label>
			<div class="controls">
				<form:input path="reimburseDate" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报销类型：</label>
			<div class="controls">
				<form:select path="reimburseType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('reimburseType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差天数：</label>
			<div class="controls">
				<form:input path="businessDays" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差补总和：</label>
			<div class="controls">
				<form:input path="travelAllowance" htmlEscape="false" class="input-xlarge required number"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交通费用总和：</label>
			<div class="controls">
				<form:input path="jtfyzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">餐费总和：</label>
			<div class="controls">
				<form:input path="zsfyzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">餐费总和：</label>
			<div class="controls">
				<form:input path="cfzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招待费总和：</label>
			<div class="controls">
				<form:input path="zdfzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">租赁费总和：</label>
			<div class="controls">
				<form:input path="zlfzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">福利费总和：</label>
			<div class="controls">
				<form:input path="flfzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">投标费总和：</label>
			<div class="controls">
				<form:input path="tbfzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">办公用品总和：</label>
			<div class="controls">
				<form:input path="bgypzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">其他总和：</label>
			<div class="controls">
				<form:input path="qtzh" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报销总和：</label>
			<div class="controls">
				<form:input path="bxzh" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">业务数据子表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>出差项目</th>
								<th>客户</th>
								<th>出差地点</th>
								<th>项目经理</th>
								<th>金额</th>
								<th>票计</th>
								<th>事由</th>
								<th>备注信息</th>
								<shiro:hasPermission name="reimburse:oaReimburse:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="oaReimburseDetailList">
						</tbody>
						<shiro:hasPermission name="reimburse:oaReimburse:edit"><tfoot>
							<tr><td colspan="10"><a href="javascript:" onclick="addRow('#oaReimburseDetailList', oaReimburseDetailRowIdx, oaReimburseDetailTpl);oaReimburseDetailRowIdx = oaReimburseDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="oaReimburseDetailTpl">//<!--
						<tr id="oaReimburseDetailList{{idx}}">
							<td class="hide">
								<input id="oaReimburseDetailList{{idx}}_id" name="oaReimburseDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="oaReimburseDetailList{{idx}}_delFlag" name="oaReimburseDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_targetProject" name="oaReimburseDetailList[{{idx}}].targetProject" type="text" value="{{row.targetProject}}" maxlength="128" class="input-small "/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_custom" name="oaReimburseDetailList[{{idx}}].custom" type="text" value="{{row.custom}}" maxlength="128" class="input-small "/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_tarPlace" name="oaReimburseDetailList[{{idx}}].tarPlace" type="text" value="{{row.tarPlace}}" maxlength="32" class="input-small "/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_projectManager" name="oaReimburseDetailList[{{idx}}].projectManager" type="text" value="{{row.projectManager}}" maxlength="32" class="input-small "/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_amount" name="oaReimburseDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small  number"/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_ticket" name="oaReimburseDetailList[{{idx}}].ticket" type="text" value="{{row.ticket}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="oaReimburseDetailList{{idx}}_cause" name="oaReimburseDetailList[{{idx}}].cause" type="text" value="{{row.cause}}" maxlength="1024" class="input-small "/>
							</td>
							<td>
								<textarea id="oaReimburseDetailList{{idx}}_remarks" name="oaReimburseDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="reimburse:oaReimburse:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#oaReimburseDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var oaReimburseDetailRowIdx = 0, oaReimburseDetailTpl = $("#oaReimburseDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(oaReimburse.oaReimburseDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#oaReimburseDetailList', oaReimburseDetailRowIdx, oaReimburseDetailTpl, data[i]);
								oaReimburseDetailRowIdx = oaReimburseDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="reimburse:oaReimburse:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>