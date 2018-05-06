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
    <title>每年一考</title>
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="css/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/button.css">
    <link rel="stylesheet" type="text/css" href="css/iframe.css">
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/formValidate.js"></script>
    <script type="text/javascript" src="js/httpCacheUtil.js"></script>
    <script type="text/javascript" src="js/zDialog.js"></script>
    <style type="text/css">

        .answer{
            width: 99%;
            float: left;
        }
        .answer td{
            padding:10 0 10 0;
            height:55px;
            vertical-align: middle;
        }
        .answer td span{
            height:55px;
            line-height:55px;
            vertical-align: middle;
            float: left;
        }
        .answer td textarea{
            float: left;
            width:625px;
        }
        .answer td .radio{
            padding-left:10px;
            padding-right:10px;
            height:55px;
            line-height:55px;
            vertical-align: middle;
            float: left;
        }

    </style>

</head>
<body>
<table class="bt_table" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td id="saveid"  >
            <div onclick="event_btsave();" style="width: 50px;" id="saveid" >
                <span class="bt_save"></span><span>&nbsp;保存</span>
            </div>
        </td>
        <td >
            <div onclick="event_returnBack();" style="width: 50px;">
                <span class="bt_back"></span><span>&nbsp;返回</span>
            </div>
        </td>
        <td width="100%">
        </td>
    </tr>
</table>
<div id="mainid" style="overflow: auto;">
    <form action="<%=basePath%>EduTestBase.do?method=saveOrUpdata" method="post" name="myform" id="myform" style="margin: 0px;padding: 0px;">
        <table class="sou_tab" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_1" width="10%">序号：</td>
                     <td> <input type="text" name="itemNumber" id="itemNumber" value="1">
                    </td>
            </tr>
            <tr>
                <td class="td_1" width="10%">类型：</td>
                <td class="td_2" width="90%">
                    <select id="type" name="type" class="must" style="width:100px;" onchange="event_changetype(this)">
                        <option id="dxt" value='1'>单选题</option>
                        <option id="pwt" value='2'>多选题</option>
                        <option id="pdt" value='3'>判断题</option>
                    </select>
                    <input type="hidden" id=_nodeNo" name="nodeNo" value="${requestScope.nodeNo}">
                    <input type="hidden" id="_testDirectoryId" name="testDirectoryId" value="${requestScope.testDirectoryId}">
                </td>
            </tr>
            <tr>
                <td class="td_3" width="10%">考试科目：</td>
                <td class="td_4" width="90%">
                    <select id="subject" name="subject" class="_must" style="width:100px;" onchange="event_changetype(this)">
                        <option id="history" value='历史'>历史</option>
                        <option id="literature" value='文学'>文学</option>
                        <option id="politics" value='政治'>政治</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td_5" width="10%">题目难度：</td>
                <td class="td_6" width="90%">
                    <select id="itemDifficulty" name="itemDifficulty" class="_must" style="width:100px;" onchange="event_changetype(this)">
                        <option id="primary" value='初级'>初级</option>
                        <option id="intermediate" value='中级'>中级</option>
                        <option id="senior" value='高级'>高级</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td_1" height="55">名称：</td>
                <td class="td_2">
                    <textarea class="tex_1 must" id="testContent" name="testContent" onblur="validateBlur(this,true,500)"  style="width:653px;"></textarea>
                </td>
            </tr>
            <tr>
                <td class="td_1">答案：</td>
                <td  class="td_2"  id="ueditconent" style="text-align: center;" colspan="3">
                    <div id="button_answer" style="width:660px;text-align: right;float:left;">
                        <div style="width: 120px;">
                            <div onclick="event_addAnswer();" class="bt_table_div" style="width:50px;" id="addbtn">
                                <span class="bt_add2"></span><span>&nbsp;增加</span>
                            </div>
                            <div onclick="event_deleteAnswer();" class="bt_table_div" style="width:50px;" id="delbtn">
                                <span class="bt_delete"></span><span>&nbsp;删除</span>
                            </div>
                        </div>
                    </div>
                    <table id="answer_single" class="answer"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <span>A</span>
                                <input type="radio" name="_optionA" class="radio" onclick="event_selectChange(this,'A',1)"/>
                                <textarea  rows="2" name="optionA" id="select_single_answerA" onblur="_fromcheck(this,{'length':'300'})" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>B</span>
                                <input type="radio" name="_optionB" class="radio" onclick="event_selectChange(this,'B',1)"/>
                                <textarea  rows="2" name="optionB" id="select_single_answerB" onblur="_fromcheck(this,{'length':'300'})" ></textarea>
                            </td>
                        </tr>
                    </table>

                    <table id="answer_multiple" class="answer" style="display:none;"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <span>A</span>
                                <input type="checkbox" class="radio" onclick="event_selectChange(this,'A',2)"  />
                                <textarea  rows="2"  name="select_multiple_answerA" id="select_multiple_answerA" onblur="_fromcheck(this,{'length':'300'})"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>B</span>
                                <input type="checkbox" class="radio" onclick="event_selectChange(this,'B',2)"  />
                                <textarea  rows="2"  name="select_multiple_answerB" id="select_multiple_answerB" onblur="_fromcheck(this,{'length':'300'})"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>C</span>
                                <input type="checkbox" class="radio" onclick="event_selectChange(this,'C',2)" />
                                <textarea  rows="2" name="select_multiple_answerC" id="select_multiple_answerC" onblur="_fromcheck(this,{'length':'300'})"></textarea>
                            </td>
                        </tr>
                    </table>

                    <table id="answer_truefalse" class="answer" style="display: none; " border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="width: 30%;">
                                <span>A</span>
                                <input type="radio" class="radio" name="select_truefalse"  onclick="event_selectChange(this,'A',3)" />
                                <span>正确</span>
                                <input type="hidden" name="select_truefalse_answerA" value="正确">
                            </td>
                            <td style="width: 70%;">
                                <span>B</span>
                                <input type="radio" class="radio" name="select_truefalse" onclick="event_selectChange(this,'B',3)" />
                                <span>错误</span>
                                <input type="hidden" name="select_truefalse_answerB" value="错误">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="td_1" height="40" >标准答案：</td>
                <td class="td_2">
                    <input type="text" readonly="readonly" id="standardanswer_single" name="rightKey" style="border: 0;background: transparent;">
                    <input type="text" readonly="readonly" id="standardanswer_multiple" name="standardanswer_multiple" style="border: 0;background: transparent;display: none;">
                    <input type="text" readonly="readonly" id="standardanswer_truefalse" name="standardanswer_truefalse" style="border: 0;background: transparent;display: none;">
                </td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
    var asciiCode = 65;
    var maxanswer=6;
    var minanswer=3;
    var selectMaterial=[];
    var dialog=new Dialog();
    dialog.Height=100000;//自动适应最大高度
    dialog.Width=window.screen.availWidth-200;


    $(document).ready(function (){
        bodyheight = document.body.clientHeight;
        $("#mainid").css("height",bodyheight-35);
    });


//保存提交
    function event_btsave(){
        var arr = new Array();
        $("#answer_single tr").each(function(){
                var isCheck = "";
                var option = $(this).find("span").text();
                var answer = $(this).find("textarea").val();
                if($(this).find("input").attr("checked")){
                    isCheck = 1;
                }else {
                    isCheck = 0;
                }
                arr.push([option, answer, isCheck]);
            });
        var options = arr.join(";");

        $.ajax({
            type: "POST",
            url: "questions/saveQuestions",
            async: false,
            dataType:"json",
            data:{'options':options,'itemNumber':$("#itemNumber").val(),'subject':$("#subject").val(),'testContent':$("#testContent").val(),'itemDifficulty':$("#itemDifficulty").val()},
            success: function(data){
                var _msg;
                if(data==1){
                    _msg="保存试题成功！"
                }else if(data==0){
                    _msg="保存试题失败！"
                }
                $.messager.show({
                    title:'消息提示',
                    msg:_msg,
                    timeout:2000,
                    showType:'slide'
                });
            },
            error:function(data){
                $.messager.show({
                    title:'消息提示',
                    msg:"保存出错！ ",
                    timeout:2000,
                    showType:'slide'
                });
            }
        });
    }

        if(!_fromcheck(document.getElementById("title"),{'isnull':'isnull','length':'500'})){
            alert("【专题资料名称】不能为空并且不能超过500个字！！");
            return;
        }

        var typename="";
        var type=$("#type").val();
        switch(type-0){
            case 1:
                typename="single";
                break;
            case 2:
                typename="multiple";
                break;
            case 3:
                typename="truefalse";
                break;
            default:
                break;
        }
        if(type-0!=3){
            //判断选择答案是否为空或者超长；
            for(var i=0;i<maxanswer;i++){
                var option=String.fromCharCode(asciiCode+i);
                var obj=document.getElementById("select_"+typename+"_answer"+option);
                if(obj==null||obj==undefined){
                    continue;
                }
                if(!_fromcheck(obj,{'isnull':'isnull','length':'300'})){
                    alert("【选项"+option+"】不能为空并且不能超过300个字！");
                    return;
                }
            }
        }
        if(!_fromcheck(document.getElementById("standardanswer_"+typename),{'isnull':'isnull'})){
            alert("【标注答案】不能为空！");
            return;
        }

        $("#selectMaterial").val(selectMaterial.join(","));
        document.getElementById("myform").submit();
    }
*/


    function event_returnBack(){
        var havechange=false;
        if($("#title").val()!=null&&$("#title").val()!=""){
            havechange=true;
        }
        if(havechange){
            if(confirm("尚未执行保存，是否继续取消操作？")==false){
                return;
            }
        }
        //parent.location.href="<%=basePath%>Education/iframeTestManage.jsp?nodeid="+$("#testDirectoryId").val()+"&nodeNo="+$("#nodeNo").val()
        window.parent.parent.deltailBack();
    }



    //试题类型切换事件
    function event_changetype(obj){
        switch(obj.value-0){
            case 1:
                $("#answer_single").css("display","block");
                $("#answer_multiple").css("display","none");
                $("#answer_truefalse").css("display","none");
                $("#button_answer").css("display","block");
                $("#standardanswer_single").css("display","block");
                $("#standardanswer_multiple").css("display","none");
                $("#standardanswer_truefalse").css("display","none");
                break;
            case 2:
                $("#answer_single").css("display","none");
                $("#answer_multiple").css("display","block");
                $("#answer_truefalse").css("display","none");
                $("#button_answer").css("display","block");
                $("#standardanswer_single").css("display","none");
                $("#standardanswer_multiple").css("display","block");
                $("#standardanswer_truefalse").css("display","none");
                break;
            case 3:
                $("#answer_single").css("display","none");
                $("#answer_multiple").css("display","none");
                $("#answer_truefalse").css("display","block");
                $("#button_answer").css("display","none");
                $("#standardanswer_single").css("display","none");
                $("#standardanswer_multiple").css("display","none");
                $("#standardanswer_truefalse").css("display","block");
                break;
            default:
                break;
        }
    }
    //标准答案选择事件
    function event_selectChange(obj,option,type){
        switch(type-0){
            case 1:
                if(obj.checked){
                    $("#standardanswer_single").val(option);
                }else{
                    if($("#standardanswer_single").val()==option){
                        $("#standardanswer_single").val("");
                    }
                }
                break;
            case 3:
                $("#standardanswer_truefalse").val(option);
                break;
            case 2:
                var select=$("#standardanswer_multiple").val().split(",");
                if(select.length<1){
                    $("#standardanswer_multiple").val(option);
                }else{
                    for(var i=0;i<select.length;i++){
                        if(select[i]==option){
                            if(!obj.checked){
                                select.splice(i,1);
                                continue;
                            }
                            continue;
                        }
                        if(i==select.length-1&&obj.checked){
                            select.push(option);
                        }
                    }
                }
                if(select.length>0&&select[0]==""){
                    select.splice(0,1);
                }
                $("#standardanswer_multiple").val(select.join(","));
                break;
            default:
                break;
        }
    }

    //添加新的可选答案
    function event_addAnswer(){
            var currentLength = $("#answer_single").find("tr").length;
            if(currentLength>=maxanswer){
                return;
            }
            var option =  $("#answer_single tr:last").find("td span").text();
            var  a = ["A","B","C","D","E","F"];
            var html = "";
            for(var i=0;i<a.length;i++){
                var _option = a[i];
//                if(option==a[a.length - 1]){
//                    break;
//                }
                if(option==_option){
                    option = a[i+1];
                    html = "<tr><td><span>"+ option+"</span>"
                    html += "<input type='radio' name='lect_single'class='radio' onclick='event_selectChange(this,'A',1)'/>'";
                    html +=  "<textarea  rows='2' name='select_single_answerA' id='select_single_answerA' onblur='_fromcheck(this,{'length':'300'})'></textarea>";
                    html +="</td></tr>"
                    break;
                }
            }
            $("#answer_single").append(html);
    }

    //删除答案选项
    function event_deleteAnswer() {
        var totalLength = $("#answer_single").find("tr").length;
        if(totalLength>minanswer){
            $("#answer_single tr:last").remove();
        }else {
            return;
        }
    }
    function event_openMaterialSelect(){
        var url='<%=basePath%>Education/Materials.jsp?baseId='+selectMaterial.join(",");
        dialog.URL=url;
        dialog.Title='资料选择';
        dialog.OKEvent = function(){material_callback(dialog.innerFrame.contentWindow.getReturnData());dialog.close();};
        dialog.show();
    }

    function  material_callback(data){

        if(data==null||data.length<1){
            return;
        }
        for(var i=0;i<data.length;i++){
            var isexit=false;
            for(var exit=0;exit<selectMaterial.length;exit++){
                if(selectMaterial[exit]==data[i].id){
                    isexit=true;
                }
            }
            if(isexit){
                continue;
            }
            var ulObj = $('#selectMaterialshow');
            var liObj = $("<li style=\"float:left;\" id=\"material"+data[i].id+"\"></li>");
            var lihtml=new Array();
            lihtml.push("<a href=\"javascript:void(0);white-space: nowrap;\" onclick=\"event_openMaterial('"+data[i].id+"')\">"+data[i].title+"</a>");
            lihtml.push("<img src=\"images/button/close.png\" style=\"cursor: pointer;height:16px;width:16px;\"  onclick =\"event_deleteMaterial('"+data[i].id+"')\"/>");
            liObj.append($(lihtml.join(" ")));
            ulObj.append(liObj);
            selectMaterial.push(data[i].id);
        }
    }

    function event_deleteMaterial(materialid){
        $("#material"+materialid).remove();
        for(var i=0;i<selectMaterial.length;i++){
            if(selectMaterial[i]==materialid){
                selectMaterial.splice(i,1);
            }
        }
    }
    function event_openMaterial(materialid){
        window.open("<%=basePath%>EduDataBase.do?method=querydata&id="+materialid+"&openfrom=-1");
    }




</script>
</body>
<script type="text/javascript" src="Js/httpCacheUtil.js"></script>
<SCRIPT language="javascript">
    httpCacheUtil.update("Js/zDialog.js");
</script>
</html>
