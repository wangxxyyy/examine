<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>在线考试系统</title>
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="css/button.css" />
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <style type="text/css">
        body {
            font-family:'Microsoft YaHei';
            background:url(images/exam_bg_1.png);
            margin:0px;
            padding:0px;
        }
        .exam_div_1{
            width:901px;
            height:100%;
            margin:0px auto;
            background:url(images/exam_bg_2.png) repeat-y;
        }
        .exam_div_1 .but_1{
            width:138px;
            height:47px;
            background:url(images/but_7.png);
            border:0;
            color:#666;
            font-size:18px;
            font-weight:bold
        }
        .exam_div_2{
            width:89%;
            height:70px;
            margin:0px auto;
            margin-top:15px;
            padding:10px 0;
            text-align:center;
            font-size:30px;
            letter-spacing:5px;
            color:#333;
            font-weight:bold;
            background:url(images/line_7.png) no-repeat;
        }
        .exam_div_3{
            width:89%;
            height:15px;
            margin:0px auto;
            padding:10px 0;
            font-size:15px;
            color:#333;
            font-weight:;
            border-bottom:1px #ddd solid;
        }
        .exam_div_4{
            width:89%;
            margin:0px auto;
            margin-bottom:-10px;
            padding:0px 0;
            text-align:left;
            font-size:18px;
            color:#666;
            font-weight:bold;
            line-height:40px;
            letter-spacing:1px;
        }
        .exam_div_4 .span_1{
            font-size:18px;
            color:#666;
            font-weight: bold;
        }
        .wrap{
            width:89%;
            margin:15px auto;
        }
        .wrap .info{
            font: 14px/32px "microsoft yahei","sans serif";
        }
        .title{
            font-size:15;
            color:#666;
            margin-top:0px;
        }
        .xuanxiang{
            margin-top:-25px;
        }
        .xuanxiang-title{
            float:left;
            width:5%;
            margin-left:15px;
            font-size: 15px;
            color:#666;
            line-height:26px;
        }
        .xuanxiang_content{
            float:left;
            font-size: 15px;
            letter-spacing:1px;
            color:#666;
            letter-spacing:2px;
            line-height:26px;
            width:92%;
        }

        .relatedData{
            width: 96.5%;
            margin:0px auto;
        }
        .relatedData td{
            font-size:15;
            color:#000000;
        }
        .relatedData td a{
            font-size:15;
            color:#000000;
        }
        .clock_div{
            width:167px;
            height:73px;
            position:absolute;
            right:-190px;
            top:100px;
            background:url(images/clock.png);
            color:#FFFFFF;
            font-size:16px;
            font-weight:bold;
        }
        a{
            font-size:14px;
            text-decoration:underline;
        }
        a:hover{
            text-decoration:underline;
        }
        .countdown {
            background:#005DAC;
            text-align:center;
            position:absolute;
            top:80px;
            right:300px;
            width:161px;
            height:161px;
            border-radius:80px;
            -webkit-border-radius:80px;
            -moz-border-radius:80px;
        }
        .countdown .mtp {
            margin-top:50px;
        }
        .countdown .line_height34 {
            line-height:34px;
        }
        .countdown .countdown_text {
            color:white;
            margin-top:55px;
            font-size:20px;
            line-height:29px;
            letter-spacing:3px;
        }
        .countdown #countdown_time {
            color:#F8B62C;
            font-size:25px;
        }
    </style>

    <script type="text/javascript">

        $(function() {
            //设置时间倒计时
            setCountDown_time();
        })
        /*时间倒计时*/
        var sec = 60,min = 90;
        var format = function(str) {
            if(parseInt(str) < 10) {
                return "0" + str;
            }
            return str;
        };
        function setCountDown_time(){
            var idt = window.setInterval("ls();", 1000);
        }
        function ls() {
            sec--;
            if(sec == 0) {
                min--;
                sec = 59;
            }
            document.getElementById("countdown_time").innerHTML = format(min) + ":" + format(sec);
            if(parseInt(min) == 0 && parseInt(sec) == 0) {
                window.clearInterval(idt);
                alert('考试时间已到，试卷已提交，感谢您的使用！');
            }
        }

       function saveAnswer() {
           var options="";
           var testIds="";
           var answerContent="";
           var answerTestIds = "";
           var checkOptions = "";
           var checkTestIds = "";
           var typeIds = "";
           var checkTypeId = "";
           var answerTypeId = "";
           //单选题
           var paperId = $("#paperId").val();
           $('input:radio:checked').each(function () {
               options += $(this).val() + ",";
               testIds += $(this).attr('testId') + ",";
               typeIds += $(this).attr('typeId') + ",";
           });
          /* options = options.substring(0,options.length-1);
           options = options + ";";
           alert(options);*/

           //多选题
           var chekTestId = null;
           $('input:checkbox:checked').each(function () {
               if (chekTestId == null || chekTestId == $(this).attr('testId')) {
                   checkOptions += $(this).val();
               } else {
                   checkOptions += ','
                   checkOptions += $(this).val();
               }

               if (chekTestId != $(this).attr('testId')) {
                   checkTestIds += $(this).attr('testId') + ",";
               }
               if(chekTestId != $(this).attr('testId')){
                   checkTypeId += $(this).attr('typeId') + ","
               }
               chekTestId = $(this).attr('testId');

           });
           options = options + checkOptions + ",";
           testIds = testIds + checkTestIds;
           typeIds = typeIds + checkTypeId;

           //解答题
           $("textarea[id='answerIds']").each(function () {
               answerContent += $(this).val() + ",";
               answerTestIds += $(this).attr('testId') + ",";
               answerTypeId += $(this).attr('typeId') + ",";
           })

           options = options + answerContent;
           testIds = testIds + answerTestIds;
           typeIds = typeIds + answerTypeId;
           if (options!=null && testIds!=null && typeIds!=null) {
               options = options.substring(0, options.length-1);
               testIds = testIds.substring(0, testIds.length-1);
               typeIds = typeIds.substring(0,typeIds.length-1 );
           }

           $.ajax({
               type: "POST",
               url: "answerSheet/saveAnswerSheet",
               async: false,
               dataType: "json",
               data: {'options': options, 'testIds': testIds ,'paperId':paperId, 'typeIds':typeIds},
               success: function (data) {
                   var _msg;
                   if (data == 1) {
                       _msg = "提交试卷成功！"
                   } else if (data == 0) {
                       _msg = "提交试卷失败！"
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
<div class="exam_div_1" id="_maindiv">
    <div >
        <div class="exam_div_2">
            <div>每月一试</div>
        <%--    <div style='font-size:17px;margin-top:3px;letter-spacing:1px;'>${testHelp.title}</div>--%>
        </div>

        <div class="countdown" style="margin-left: 750px">
        <p class="mtp">
            <span class="countdown_text">答题倒计时</span></p>
        <p class="line_height34"><span id="countdown_time"></span><span class="countdown_text">分钟</span></p>
        </div>

        <div class="exam_div_3">
            <span style="width:150PX;display:block;float:left;">答题人&nbsp;&nbsp;${user.name}</span>
            <span style="width:*;float:right;text-align:right;">满分：${paper.radioScore + paper.checkboxScore + paper.answerScore}&nbsp;&nbsp;总题数：${fn:length(questionsRadioList)+fn:length(questionsAnswerList)}道&nbsp;&nbsp;
		  	   <c:choose>
                   <c:when test="${testHelp.isComplete==1}">
                       答题时间：${testHelp.answerTime}
                   </c:when>
                   <c:otherwise>
                       考试时间：${paper.time}分钟
                   </c:otherwise>
               </c:choose>
		  	   </span>
        </div>
    </div>

<c:if test="${! empty questionsRadioList}">
    <div id="radioId" class="exam_div_4">
        一、单选题（共${fn:length(questionsRadioList)}题，每题分：${paper.radioScore / fn:length(questionsRadioList)}，总分：${paper.radioScore}分）
    </div>
</c:if>
    <c:forEach var="questions" items="${questionsRadioList}" varStatus="questionsIndex">
    <div class="wrap" data-type="1">
        <div class="info">
            <p class="title">${questionsIndex.index+1}&nbsp;&nbsp;${questions.testContent}
            </p>
            <c:forEach var="answer" items="${questions.answer}">
            <p class="xuanxiang">
                <span class='xuanxiang-title'>
                    <input name="radio${questionsIndex.index+1}"  class="radioToplic" value="${answer.options}" type="radio"  testId="${questions.id}" typeId="0" />${answer.options}
                </span>
            <span class="xuanxiang_content">${answer.optinosContent}
            </span>
            </p>
            </c:forEach>
        </div>
    </div>
    </c:forEach>


    <c:if test="${!empty questionsCheckboxList}">
        <div id="checkId" class="exam_div_4">
            <c:choose>
                <c:when test="${empty questionsRadioList}">
                    一
                </c:when>
                <c:otherwise>
                    二
                </c:otherwise>
            </c:choose>
            、多选题（共${fn:length(questionsCheckboxList)}题，每题分：${paper.checkboxScore / fn:length(questionsCheckboxList)}，总分：${paper.checkboxScore}分）
        </div>
    </c:if>
    <c:forEach var="questionsCheckbox" items="${questionsCheckboxList}" varStatus="questionsCheckboxIndex">
        <div class="wrap" data-type="2">
            <div class="info">
                <p class="title">${questionsCheckboxIndex.index+1}&nbsp;&nbsp;${questionsCheckbox.testContent}
                </p>
                <c:forEach var="answerCheckbox" items="${questionsCheckbox.answer}">
                    <p class="xuanxiang">
                <span class='xuanxiang-title'>
                    <input name="check${questionsCheckboxIndex.index+1}" value="${answerCheckbox.options}" type="checkbox"  testId="${questionsCheckbox.id}" typeId="2" />${answerCheckbox.options}
                </span>
                        <span class="xuanxiang_content">${answerCheckbox.optinosContent}
                        </span>
                    </p>
                </c:forEach>
            </div>
        </div>
    </c:forEach>
    <c:if test="${!empty questionsAnswerList}">
        <div id="answerId" class="exam_div_4">
            <c:choose>
                <c:when test="${empty questionsRadioList && empty questionsCheckboxList}">
                    一
                </c:when>
                <c:when test="${empty questionsRadioList ||  empty tquestionsCheckboxList}">
                    二
                </c:when>
                <c:otherwise>
                    三
                </c:otherwise>
            </c:choose>
            、解答题（共${fn:length(questionsAnswerList)}题，每题分：${paper.answerScore / fn:length(questionsAnswerList)}，总分：${paper.answerScore}分）
        </div>
    </c:if>
    <c:forEach var="questionsAnswer" items="${questionsAnswerList}" varStatus="questionsAnswerIndex" >
        <div class="wrap" data-type="3">
            <div class="info">
                <p class="title">${questionsAnswerIndex.index+1}&nbsp;&nbsp;${questionsAnswer.testContent}
                </p>
                    <p class="xuanxiang" style="padding-top: 10px;">
                        <textarea rows="5" cols="100" id="answerIds"   testId="${questionsAnswer.id}" typeId="1"></textarea>
                    </p>
            </div>
        </div>
    </c:forEach>
    <input id="paperId" name="paperId" value="${paper.id}" type="hidden">
    <table width="100%">
        <tr>
        <tr>
            <td align="center">
                <input type="button" value="提交试卷" class="but_1" id="savecombutton" style="cursor:hand;display:block" onclick="saveAnswer()"/>
                <input type="button" value="关闭" onclick="window.close();" class="but_1" style="cursor:hand;display:block" id="guanbi"/>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
