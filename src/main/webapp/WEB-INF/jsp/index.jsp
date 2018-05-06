<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    String selAnswer =request.getParameter("selAnswer");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <base href="<%=basePath%>" />
    <title></title>
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
    <script type="text/javascript" src="js/ckplayer.js"></script>
    <script type="text/javascript" src="js/playerControlNoFullScreen.js"></script>
    <script type="text/javascript" src="js/boostor.js"></script>
    <script src="js/imgPlay.js"></script>
    <link rel="stylesheet" href="css/imgPlay.css"/>
    <style>
        body{
            font-size: 12px;
        }
        .title_1{
            margin-top:0px;
            margin-left:9px;
            font-size:20px;
            color:#939393;
        }
        .data-body-bg{
            width:650px;
            margin-top:35px;
            width:95%;
            height:50px;
        }
        #testTypeHead{
            float:left;
            width:300px;
        }
        #testType{
            margin-left:18px;
            font-size:23px;
            letter-spacing:1px;
            font-weight:bold;
            color:#CE2D25;
        }
        #standAnswer{
            font-size:14px;
            color:#CE2D25;
            font-weight:bold;
            letter-spacing:1px;
            letter-spacing:1px;
        }
        #testCount{
            float:left;
            width:220px;
            padding-top:10px;
            font-size:14px;
            text-align:right;
            color:#4871A5;
            font-weight:bold;
            letter-spacing:1px;
            margin-left:130px;
        }
        #title{
            font-size:18px;
            color:#91918F;
            font-weight:bold;
            margin:0 0 0 5px;
            letter-spacing:1px;
            word-break:break-all;
            word-wrap:break-word;
        }
        .xuanxiang-title{
            float:left;
            display:block;
            width:50px;
            margin-left:7px;
            margin-top:9px;
            font-size: 15px;
            font-weight:bold;
            letter-spacing:1px;
            color:#91918F;
            font-family:"microsoft yahei";
            line-height:26px;
        }
        .xuanxiang{
            float:left;
            font-size: 15px;
            font-weight:bold;
            letter-spacing:1px;
            color:#91918F;
            font-family:"microsoft yahei";
            margin-top:9px;
            letter-spacing:2px;
            line-height:26px;
            width:580px;
        }
        .but_1{
            width:138px;
            height:47px;
            background:url(.../images/but_7.png);
            border:0;
            color:#666;
            font-size:18px;
            font-weight:bold;
            cursor: hand;
        }
        #zhendiv{
            margin:0 auto;
        }
        a{
            font-size:14px;
            text-decoration:underline;
            color:#000000;
        }
        a:hover{
            text-decoration:underline;
        }
        .video_intotest{
            position: fixed;
            right: -60px;
            bottom:0px;
            z-index: 100;
            width: 51px;
            height: 112px;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript">
        function fun_mousover(){
            $(".ts").mouseover(function(){
                $(".video_intotest").stop().animate({"right":"0px"},1000);
            }).mouseleave(function(event){
                $(".video_intotest").stop().animate({"right":"-60px"},1000);
            });
        }
        $(document).ready(function(){
            $(".video_intotest").bind("click", function(){
                changeEveryDayTest();
            });
        });

    </script>



</head>

<body style="margin:0; font-family:'Microsoft YaHei';width:720px; height:548px;">
<div id="everyDayTest" style="width:700px;margin:0px auto;height:auto;display:block;">
    <div style="height:auto;width:700px;margin-top:20px;" align="center"><img id="images" src="images/everyDay.png" height="50px"/></div>
    <div class="data-body-bg" style="margin:0 auto;color:#555;">
        <div id="testTypeHead"><span id="testType"></span>&nbsp;&nbsp;<span id="standAnswer"></span></div>
        <div id="testCount"></div>
        <div align="center"><img src="images/line_15.png"/></div>
    </div>
    <div id="test" style="width:650px;margin:0px auto;">
        <p class="title_1" id="title"  style="padding-left:6px;" >${requestScope.testBase.title}<span id="standAnswers"></span></p>
    </div>

    <div id="data" style="float:both;height:auto;width:640px;overflow:hidden; border:1px #ddd solid; background:#f8f8f8; padding:10px;margin:0 auto;margin-top:30px;">
        <table class="relatedData" id="relatedData" style="margin-left:5px;font-size:14px;">
        </table>
    </div>
    <div id="send" style="width:700px;margin-top:50px;display:none">
        <table align="center">
            <tr>
                <td>
                    <input type="button" value="提交答案" onclick="sendAnswer();" class="but_1" id="savecombutton"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div id="hint" style="width:650px;margin:0px auto;display:none" align="right">
    <input type="hidden" id="flag" value="false"/>
    <input type="checkbox" id="zhenyanSelect" name="zhenyanSelect"/><span id="zhenyanSelectContent"></span>
</div>
</body>
</html>

