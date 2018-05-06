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
    <script type="text/jav ascript" src="js/zDialog.js"></script>
    <script type="text/javascript" src="js/jedate/jedate.js"></script>
    <script type="text/javascript" src="js/formValidate.js"></script>
    <script type="text/javascript">
        function doSearch(){
            $('#dg').datagrid('load',{
                answerName: $('#answerName').val(),
            });
        }

        //下载方法
        $(function () {
            var html = "";
            $("#change").combobox({
                onChange:function (obj) {
                    if(obj==0){
                        html += "<select id='score' class='easyui-combobox' name='dept' style='width:100px;'>";
                        html += "<option>" + "请选择" + "</option>";
                        html += "<option  value='1'>" +"60分以下" + "</option>";
                        html += "<option  value='2'>" + "60-70分" + "</option>";
                        html += "<option  value='3'>" + "71-79分" + "</option>";
                        html += "<option  value='4'>" + "80-90分" + "</option>";
                        html += "<option  value='5'>" + "91-100分" + "</option>";
                        html += "</select>"
                        $("#change").after(html);
                    }else {
                        html += "<table class='sou_tab' width='100%' border='0' cellspacing='0' cellpadding='0'>";
                        html += "<tr>";
                        html += "<td class='td_1'>"+ "考试开始时间:" + "</td>";
                        html += "<td class='td_2' style='padding-right: 270px'>";
                        html += "<input class='datainp' id='datebut'  type='text' placeholder='请选择'>";
                        html += "<input class=\"tex_1 must\" id=\"time\"  name=\"time\" type=\"image\" src=\"images/icon_calendar.png\"  style=\"width:20px;height:20px\" onblur=\"validateBlur(this,true,10)\" onclick=\"jeDate({dateCell:'#datebut',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})\">";
                        html += "</td>";
                        html += "<td class='td_1'>" + "考试结束时间:" + "</td>";
                        html += "<td class='td_2'>";
                        html += "<input class='datainp' id='datebuts'  type='text' placeholder='请选择'>";;
                        html += "<input class=\"tex_1 must\" id=\"times\"  name=\"times\" type=\"image\" src=\"images/icon_calendar.png\"  style=\"width:20px;height:20px\" onblur=\"validateBlur(this,true,10)\" onclick=\"jeDate({dateCell:'#datebuts',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})\">";
                        html += "</td></tr> </table>"
                        $("#change").after(html);
                    }
                }
            })
        });

        //下载方法
       function downloades(){
           var type = $("#change").combobox("getValue");
           if(type==0){
               var val = $("#score option:selected").val();
               $("#option").val(val);
               $("#type").val(type);
               $("#submits").submit()
           }else{
               var startTime = $("#datebut").val();
               var endTime = $("#datebuts").val();
               $("#startTime").val(startTime);
               $("#endTime").val(endTime);
               $("#type").val(type);
               $("#submits").submit();
           }
       }
    </script>
</head>
<body>
<div id="tb" style="padding:3px">
    <span>考试人:</span>
    <input id="answerName" name="answerName" style="line-height:22px;border:1px solid #ccc">
    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查询</a>
    <a id="downloads" href="javascript:void(0);"  class="easyui-linkbutton" iconCls="icon-reload" onclick="downloades()">下载</a>
    <select id="change" class="easyui-combobox" name="dept" style="width:100px;">
        <option>请选择</option>
        <option value="0">按分数段</option>
        <option value="6">按时间段</option>
    </select>
    <form id="submits" action="answerSheet/download"  method="post">
        <input id="type" type="text" name="type" style="display: none">
        <input id="option" type="text" name="option" style="display: none">
        <input id="startTime" type="text" name="startTime" style="display: none">
        <input id="endTime" type="text" name="endTime" style="display: none">
    </form>
</div>
<div>
    	<table id="dg" title="" class="easyui-datagrid" style="width:99%;height:300px;"
                url="answerSheet/list" toolbar="#tb" rownumbers="false" fitColumns="true"
                singleSelect="false" pagination="true">
            <thead>
                <tr>
                    <th field="id" checkbox="true"></th>
                    <th field="answerName" width="5" align="center">考试人</th>
                    <th field="totalScore" width="5" align="center">总分</th>
                    <th field="createDate" width="5" align="center">考试日期</th>
                </tr>
            </thead>
        </table>
</div>
</body>
</html>
