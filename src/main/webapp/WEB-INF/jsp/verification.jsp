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
    <link href="css/login.css"  rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/jquery.validate.js"></script>
    <script type="text/javascript">
        function validateBlur() {
            var name = $("#loginName").val();
            $("#demoFrom").validate({
                rules:{
                    loginName:{
                        remote:{
                            url:"user/resgter",
                            type:"post",
                            dataType:"json",
                            async: false,
                            data:{name:name}
                        },
                        required:true,
                        //email:true,
                        minlength:2,
                        maxlength:20,
                        //rangelength:[2,10]
                        //number:true,
                        //dateISO:true
                    },
                    loginPassword:{
                        required:true,
                        minlength:2,
                        maxlength:16
                    },
                    confirmPassword:{
                        equalTo:"#loginPassword"
                    }
                },
                messages:{
                    loginName:{
                        remote:"此用户名已注册",
                        required:"用户名必须填写",
                        minlength:"用户名至少超过2位",
                        maxlength:"用户名长度最大为10位"

                    },
                    loginPassword:{
                        required:"请必须输入密码",
                        minlength:"密码至少超过2位",
                        maxlength:"密码最大为16位"
                    },
                    confirmPassword:"两次输入的密码不一致"
                }
            });
        }
        
        
        function login(){
            var  loginName = $("#loginName").val();
            var  loginPassword = $("#loginPassword").val();
            $("#loginNameDesc").text("");
            $("#loginPasswordDesc").text("");
            if(loginName == ""){
                $("#loginNameDesc").text("请输入账号");
                return;
            }
            if(loginPassword==""){
                $("#loginPasswordDesc").text("请输入密码");
                return;
            }
            $.ajax({
                type: "POST",
                url: "user/login",
                async: false,
                dataType:"json",
                data: {'loginName':loginName,'loginPassword':loginPassword},
                success: function(data){
                    if(data==1){
                        window.location.href="home/index";
                    }else if(data==0){
                        $("#loginNameDesc").text("用户名或密码错误");
                    }
                },
                error:function(data){
                    alert("登录出错！");
                }
            });
        }
    </script>
</head>
<div class="logo_box">
    <h3>在线考试系统欢迎你</h3>
    <form action="#" name="f" id="demoFrom" method="post">
        <div class="input_outer" style="border:1px solid red;">
            <label style="margin: 15px 0px 0px -60px;">用户名</label>
            <input style="float: left" type="text" name="loginName" class="text" id="loginName"  style="color: #FFFFFF !important" onblur="validateBlur()" >
            <span style="width:110px;font-style:normal; line-height: 49px; color:red; padding-left:5px;font-size: 10px;" id="loginNameDesc"></span>
        </div>
        <div class="input_outer">
            <label style="margin: 15px 0px 0px -50px">密码</label>
            <input  type="password" name="loginPassword" class="text" id="loginPassword"  style="color: #FFFFFF !important; position: absolute; z-index: 100;" onblur="validateBlur()">
            <span  style="width:110px;font-style:normal; line-height: 33px; color:red; padding-left:5px;font-size: 10px" id="loginPasswordDesc"></span>
        </div>
        <div class="input_outer">
            <label style="margin: 15px 0px 0px -75px">确认密码</label>
            <input  type="password" name="confirmPassword" class="text" id="confirmPassword"  style="color: #FFFFFF !important; position: absolute; z-index: 100;" onblur="validateBlur()">
            <span  style="width:110px;font-style:normal; line-height: 33px; color:red; padding-left:5px;font-size: 10px" id="loginPasswordDes"></span>
        </div>
        <div class="mb2">
            <a class="act-but submit" href="javascript:;" style="color: #FFFFFF" onclick="login()">登录</a>
        </div>
        <input name="savesid" value="0" id="check-box" class="checkbox" type="checkbox">
        <span>记住用户名</span>
        <span><a href="#" class="login-fgetpwd" style="color: #FFFFFF">忘记密码？</a></span>

        <div class="zxfWechat" style="background-color: #bbbbbb;font-size: 16px">
            <a href="javascript:;" onclick="wechat_login()">微信登录</a>
        </div>
    </form>
</div>
</body>
</html>
