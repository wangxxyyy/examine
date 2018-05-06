<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.Calendar"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <base href="<%=basePath%>" />
    <title>解答题评分</title>
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/button.css">
    <link rel="stylesheet" type="text/css" href="css/iframe.css">
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <style type="text/css">
        body{
            font-family:'Microsoft YaHei';
            background:url(images/exam_bg_1.png);
            margin:0px;
            padding:0px;
        }
        .wrap{
            width:89%;
            margin:15px auto;
        }
    </style>
    <script type="text/javascript">
    $(function () {
        $("#subject").combobox({
            url: 'paper/listSubject',
            valueField: 'subject',
            textField: 'subject',
            onChange: function (name) {
                 $.ajax({
                 type: "POST",
                 url: "paper/answerScore",
                 async: false,
                 dataType: "json",
                 data: {'name': name},
                 success: function (data) {
                    var questionsAnswerList = data.questionsAnswerList;
                    var answerSheetList = data.answerSheetList;
                    var html = "";
                    for(var i=0;i<questionsAnswerList.length;i++){
                        var questionsAnswer = questionsAnswerList[i];
                        var answerSheet = answerSheetList[i];
                        if(questionsAnswer!=null&&answerSheet!=null){
                            html += "<div class='wrap' data-type='3'>";
                            html += "<div class='info'>";
                            html += "<p class='title'>" + questionsAnswer.itemNumber + "&nbsp;&nbsp;" + questionsAnswer.testContent +  "</p>";
                            html += "<p class='xuanxiang' style='padding-top: 10px;'>";
                            html += "<textarea rows='5' cols='100' id='answerIds'  testId='" + answerSheet.questionsId + "'>" + answerSheet.examineeAnswer + "</textarea>";
                            html +="</p>";
                            html += "请输入你的评分:<input type='text' name='totalScore' id='score' style='margin-left: 10px'>" + "<br>";
                            html += "</div></div>";
                        }
                    }
                    $("#test1").html(html);
                    $("#submit").show();
                 },
                 });
            }
        })
    });


    //保存评分
        function isCorrect() {
            var answerQuestionsId = "";
            var score = "";
            var answerQuestionsIds = "";
            var scores = "";

            //获取题目id
            $("textarea[id='answerIds']").each(function () {
                answerQuestionsId += $(this).attr('testId') + ",";

            })

            //获取题目分数
            $("input[id='score']").each(function () {
                score += $(this).val() + ",";
            })

            if(answerQuestionsId!=null&&score!=null){
                answerQuestionsIds = answerQuestionsId.substring(0,answerQuestionsId.length-1);
                scores = score.substring(0,score.length-1);
            }

            $.ajax({
                type: "POST",
                url: "answerSheet/saveAnswerScore",
                async: false,
                dataType: "json",
                data: {'answerQuestionsIds': answerQuestionsIds, 'scores': scores },
                success: function (data) {
                    var _msg;
                    if (data == 1) {
                        _msg = "评分成功！"
                    } else if (data == 0) {
                        _msg = "评分失败！"
                    }
                    $.messager.show({
                        title: '消息提示',
                        msg: _msg,
                        timeout: 2000,
                        showType: 'slide'
                    });
                },
            });
        }
    </script>
</head>
<body>
    <div id="mainid" style="overflow: auto;">
        <div style="color: #0052A3;margin-left: 750px">
            <h2>欢迎阅卷解答题</h2>
        </div>
            <div class="fitem fitemBox">
                <label>请选择试卷:</label>
                <input id="subject" class="subjects" name="subject">
            </div>
    </div>
        <div id="test1">
        </div>
        <input id="submit" type='button' value='提交' style='margin-left: 400px;display: none' onclick='isCorrect()'/>
</body>
</html>
