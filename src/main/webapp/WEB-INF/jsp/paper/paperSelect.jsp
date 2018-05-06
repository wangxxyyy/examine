<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/demo.css">
    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <title>Title</title>
</head>

<body>
<div>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="saveQuestion()">保存</a>
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="escQuestion()">取消</a>
</div>
<table id="dg" class="easyui-treegrid" style="width:800px;height: 400px;"
       url="questions/listQuestion?type=${type}" idField='id' treeField='title' toolbar='#tb' pagination="true"
       rownumbers="false" fitColumns="true" singleSelect="false">
    <thead>
    <tr>
        <th field="id" checkbox="true" id="questionId"></th>
        <th data-options="field:'testContent',width:150,align:'center'">试题名称</th>
        <th data-options="field:'subject',width:100,align:'center'">试题科目</th>
        <th data-options="field:'title',width:100,align:'center'">试题类型</th>
        <th data-options="field:'itemDifficulty',width:150,align:'center'">试题难度</th>
        <th data-options="field:'questionsType',width:150,align:'center',hidden:true" >试题类型</th>
        <th data-options="field:'createDate',width:100,align:'center'">试题创建时间</th>
    </tr>
    </thead>
</table>
</body>
</html>
