<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>在线考试系统</title>
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/default/easyui.css">
    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <link href="css/login.css"  rel="stylesheet" />
    <script type="text/javascript">
        $(function(){
            $("#college").combobox({
                url:'test/listCollege',
                valueField:'major',
                textField:'major'
            })
        });
        function login(){
            var  name = $("#name").val();
            var  password = $("#password").val();
            var  number = $("#number").val();
            $("#nameDesc").text("");
            $("#passwordDesc").text("");
            $("#numberDesc").text("");
            if(name == ""){
                $("#nameDesc").text("请输入账号");
                return;
            }else if(password==""){
                $("#passwordDesc").text("请输入密码");
                return;
            }else if(number==""){
                $("#numberDesc").text("请输入学号")
                return;
            }
            $.ajax({
                type: "POST",
                url: "test/login",
                async: false,
                dataType:"json",
                data:$("#fm").serialize(),
                success: function(data){
                    if(data==1){
                        window.location.href="home/testIndex";
                    }else if(data==0){
                        $("#nameDesc").text("用户名或密码错误");
                    }
                },
                error:function(data){
                    alert("登录出错！");
                }
            });
        }
    </script>
</head>
<body>
<div class="logo_box">
    <h3>网络在线考试</h3>
    <form  id="fm" method="post">
        <div class="input_outer">
            <span class="u_user"></span>
            <input type="text" name="name" class="text" id="name" placeholder="输入ID或用户名登录" style="color: #FFFFFF !important" >
            <span style="width:110px;font-style:normal; line-height: 49px; color:red; padding-left:5px;font-size: 10px;" id="nameDesc"></span>
        </div>
        <div class="input_outer">
            <span class="us_uer"></span>
            <input  type="password" name="password" class="text" id="password" placeholder="请输入密码" style="color: #FFFFFF !important; position: absolute; z-index: 100;">
            <span  style="width:110px;font-style:normal; line-height: 33px; color:red; padding-left:5px;font-size: 10px" id="passwordDesc"></span>
        </div>
        <div class="input_outer">
            <span class="us_uer"></span>
            <input  type="text" name="number" class="text" id="number" placeholder="请输入学号" style="color: #FFFFFF !important; position: absolute; z-index: 100;">
            <span  style="width:110px;font-style:normal; line-height: 33px; color:red; padding-left:5px;font-size: 10px" id="numberDesc"></span>
        </div>

        <div class="fitem" style="height:50px">
            <label>请选择专业:</label>
            <input id="college" name="college">
            <%--<input id="cc" class="easyui-combobox" style="width:100px"
                   url="test/listCollege"
                   valueField="college" textField="college">
            </input>--%>
        </div>

        <div class="mb2">
            <a class="act-but submit" href="javascript:;" style="color: #FFFFFF" onclick="login()">登录</a>
        </div>

        <input name="savesid" value="0" id="check-box" class="checkbox" type="checkbox">
        <span>记住用户名</span>
        <span><a href="#" class="login-fgetpwd" style="color: #FFFFFF">忘记密码？</a></span>
    </form>
</div>
</body>
</html>
