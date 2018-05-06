<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String dirId =request.getParameter("dirId");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title></title>
    <script type="text/javascript">
        window.MY97WDATE_HOME_URL='<%=basePath%>';
    </script>
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.3.5/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.3.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/button.css">
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" type="text/css" href="css/iframe.css">
    <script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
    <script type="text/jav ascript" src="js/zDialog.js"></script>
    <script type="text/javascript" src="js/jedate/jedate.js"></script>
    <script type="text/javascript" src="js/formValidate.js"></script>
    <style type="text/css">
        .stlx{
            text-align: left;
        }
        .datainp{
            width:200px; height:25px; border:1px #ccc solid;
        }
    </style>


    <script type="text/javascript">


        //保存整个试卷
        function btsave() {
            var questionId = "";
            var subject = $("#subject").val();
            var itemDiffculty = $("#itemDiffculty").val();
            var time = $("#datebut").val();
            var radioNumber = $("#radioNumber").val();
            var radioScore = $("#radioScore").val();
            var radioSumScore = radioNumber*radioScore;
            var checkboxNumber = $("#checkboxNumber").val();
            var checkboxScore = $("#checkboxScore").val();
            var checkSumScore = checkboxNumber*checkboxScore;
            var answerNumber = $("#answerNumber").val();
            var answerScore = $("#answerScore").val();
            var answerSumScore = answerNumber*answerScore;

            $("input[id='questionId']").each(function (){
                questionId += $(this).val() + ",";
            });
            var questionIds = questionId.substring(0,questionId.length-1);

            $.ajax({
                type: "POST",
                url: "paper/savePaper",
                async: false,
                dataType: "json",
                data: {'subject': subject, 'time': time,'radioNumber':radioNumber, 'radioSumScore':radioSumScore,'checkboxNumber':checkboxNumber,
                          'checkSumScore':checkSumScore,'answerNumber':answerNumber, 'answerSumScore':answerSumScore,'questionIds':questionIds,
                            'itemDiffculty':itemDiffculty},
                success: function (data) {
                    var _msg;
                    if (data == 1) {
                        _msg = "保存试卷成功！"
                    } else if (data == 0) {
                        _msg = "保存试卷失败！"
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


        //删除已选题，试题数量，试题总分值跟着变化
        function deleteColumn() {
            var radioScore = $("#radioScore").val();
            var checkboxScore = $("#checkboxScore").val();
            var answerScore = $("#answerScore").val();
            var questionsType = "";
            var questionType = "";

            $("#tg").find("tr input[name='txid']:checked").each(function () {
              questionsType += $(this).closest('tr').find('.questionType').text() + ",";
              questionType = questionsType.substring(0,questionsType.length-1);
              for(var i=0;i<questionType.length;i++){
                 var quesType = questionType[i];
                  if(quesType==0){
                      $(this).closest("tr").remove();
                      var newRadioLength = $("#tg tr").find('.num0').length;
                      var newRadioSumScore = newRadioLength*radioScore;
                      $("#radioNumber").val(newRadioLength);
                      $("#danxfzid").val(newRadioSumScore);
                      $("#danxyxid").val(newRadioLength);
                  }
                  if(quesType==2){
                      $(this).closest("tr").remove();
                      var newCheckboxLength = $("#tg tr").find('.num2').length;
                      var newCheckboxSumScore = newCheckboxLength*checkboxScore;
                      $("#checkboxNumber").val(newCheckboxLength);
                      $("#duoxyxid").val(newCheckboxLength);
                      $("#duoxfzid").val(newCheckboxSumScore);
                  }
                  if(quesType==1){
                      $(this).closest("tr").remove();
                      var newAnswerLength = $("#tg tr").find('.num1').length;
                      var newAnswerSumScore = newAnswerLength*answerScore;
                      $("#answerNumber").val(newAnswerLength);
                      $("#pdyxid").val(newAnswerLength);
                      $("#pdfzid").val(newAnswerSumScore);
                  }
              }
            });
        }

        //单选题
        $(function () {
             $("#danxtxid").click(function () {
                 if($(this).prop("checked")){
                    $("#radioNumber").removeAttr("disabled");
                    $("#radioScore").removeAttr("disabled");
                    $("#btseldanxId").show();
                 }else{
                     $("#radioNumber").attr("disabled",true);
                     $("#radioScore").attr("disabled",true);
                     $("#btseldanxId").hide();

                 }
             });
        })


        //多选题
        $(function () {
            $("#duoxtxid").click(function () {
                if($(this).prop("checked")){
                    $("#checkboxNumber").removeAttr("disabled");
                    $("#checkboxScore").removeAttr("disabled");
                    $("#btselduoxId").show();
                }else {
                    $("#checkboxNumber").attr("disabled",true);
                    $("#checkboxScore").attr("disabled",true);
                    $("#btselduoxId").hide();
                }
            });
        })

        //解答题
        $(function () {
            $("#pdtxid").click(function () {
                if($(this).prop("checked")){
                    $("#answerNumber").removeAttr("disabled");
                    $("#answerScore").removeAttr("disabled");
                    $("#btselpdId").show();
                }else{
                    $("#answerNumber").attr("disabled",true);
                    $("#answerScore").attr("disabled",true);
                    $("#btselpdId").hide();
                }
            });
        })


        //单选题模态弹窗口
        function openTestRadio(type) {
            var radioNumber = $("#radioNumber").val();
            var radioScore = $("#radioScore").val();
            if(radioNumber==""||radioScore==""){
                alert("请输入单选题数量和试题分数")
                return;
            }
                $('#dlg').dialog({
                    title: '选择试题',
                    width: 800,
                    height: 600,
                    closed: false,
                    cache: false,
                    href: 'paper/questionSelect?type='+type,
                    modal: true
                });
        }

        //多选题模态窗口弹窗
        function openTestCheckbox(type){
            var checkboxNumber = $("#checkboxNumber").val();
            var checkboxScore = $("#checkboxScore").val();
            if(checkboxNumber==""||checkboxScore==""){
                alert("请输入多选题数量和试题分数")
                return;
            }
            $('#dlg').dialog({
                title: '选择试题',
                width: 800,
                height: 600,
                closed: false,
                cache: false,
                href: 'paper/questionSelect?type='+type,
                modal: true
            });
        }

        //解答题模态窗口弹窗
        function openTestAnswer(type){
            var answerNumber = $("#answerNumber").val();
            var answerScore = $("#answerScore").val();
            if(answerNumber==""||answerScore==""){
                alert("请输入解答题数量和试题分数")
                return;
            }

            $('#dlg').dialog({
                title: '选择试题',
                width: 800,
                height: 600,
                closed: false,
                cache: false,
                href: 'paper/questionSelect?type='+type,
                modal: true
            });
        }

        //保存所选试题到主页面
        function saveQuestion() {
            var radioNumber = $("#radioNumber").val();
            var radioScore = $("#radioScore").val();
            var checkboxNumber = $("#checkboxNumber").val();
            var checkboxScore = $("#checkboxScore").val();
            var answerNumber = $("#answerNumber").val();
            var answerScore = $("#answerScore").val();

            var html = "";
            var questionIds = "";
            var questionId = "";
            var rows = $('#dg').datagrid('getSelections');
            var rowsLast = rows[rows.length-1];
            var typeLast = rowsLast.questionsType;
            if (rows.length < 1) {
                $.messager.show({
                    title: '消息提示',
                    msg: '请选择保存试题！',
                    timeout: 2000,
                    showType: 'slide'
                });
            } else {
                for (var i = 0; i < rows.length; i++) {
                    //easyui添加
                    var row = rows[i];
                    var type = row.questionsType;
                    //$("#tg").datagrid("appendRow",row)
                    var rowsLength = rows.length;
                    var flag = false;
                    if(type==0&&typeLast==0){
                        $("#tg tr").find('.num0').each(function () {
                            var questionId = $(this).parent().next().find('input').val();
                            if(questionId == row.id){
                                flag = true;
                                return false;
                            }
                        });

                        //跳出循环
                        if(flag==true){
                            continue;
                        }

                        if(radioNumber<rowsLength){
                            alert("只能选择" + radioNumber + "道试题添加!!!" );
                            return;
                        }
                        if(radioNumber>=rowsLength){
                            var newRadioSumScore = rowsLength*radioScore;
                            $("#radioNumber").val(rowsLength);
                            $("#danxyxid").val(rowsLength);
                            $("#danxfzid").val(newRadioSumScore);
                        }
                    }
                    if(type==2&&typeLast==2){
                        $("#tg tr").find('.num2').each(function () {
                            var questionId = $(this).parent().next().find('input').val();
                            if(questionId == row.id){
                                flag = true;
                                return false;
                            }
                        });

                        //跳出循环
                        if(flag==true){
                            continue;
                        }
                        if(checkboxNumber<rowsLength){
                            alert("只能选择" + checkboxNumber + "道试题添加!!!" );
                            return;
                        }
                        if(checkboxNumber>=rowsLength){
                            var newCheckboxScore = rowsLength*checkboxScore;
                            $("#checkboxNumber").val(rowsLength);
                            $("#duoxyxid").val(rowsLength);
                            $("#duoxfzid").val(newCheckboxScore);

                        }
                    }
                    if(type==1&&typeLast==1){
                        $("#tg tr").find('.num1').each(function () {
                            var questionId = $(this).parent().next().find('input').val();
                            if(questionId == row.id){
                                flag = true;
                                return false;
                            }
                        });

                        //跳出循环
                        if(flag==true){
                            continue;
                        }
                        if(answerNumber<rowsLength){
                            alert("只能选择" + answerNumber + "道试题添加!!!" );
                            return;
                        }
                        if(answerNumber>=rowsLength){
                            var newAnswerScore = rowsLength*answerScore;
                            $("#answerNumber").val(rowsLength);
                            $("#pdyxid").val(rowsLength);
                            $("#pdfzid").val(newAnswerScore);
                        }
                    }
                    //自写table添加
                    html += "<tr name='quid'>";
                    html += "<td class='stlx' style='text-align: left;'>";
                    html += "<input id='delete' name='txid' type='checkbox'/>";
                    html += "<span class='title'>" + row.testContent +  "</span>";
                    html += "</td>";
                    html += "<td class='stlx' style='text-align: left;'>";
                    html += "<span class='title'>" + row.subject +  "</span>";
                    html += "</td>";
                    html += "<td class='stlx' style='text-align: left;'>";
                    html += "<span class='title'>" + row.title +  "</span>";
                    html += "</td>";
                    html += "<td class='stlx' style='text-align: left;display: none'>";
                    html += "<span class='questionType num"+  row.questionsType+"'>" + row.questionsType +  "</span>";
                    html += "</td>";
                    html += "<td class='stlx' style='text-align: left;display: none'>";
                    html += "<input id='questionId' name='questionId' value='" +row.id + "'>";
                    html +="</td>";
                    html += "<td class='stlx' style='text-align: left;'>";
                    html += "<span class='title'>" + row.itemDifficulty +  "</span>";
                    html += "</td>";
                    html += "<td class='stlx' style='text-align: left;'>";
                    html += "<span class='title'>" + row.createDate +  "</span>";
                    html += "</td>";
                    html += "</tr>";
                }
                $('#dlg').dialog('close');
                $("#tg").show();
                /*$("#tg tr:last").after(html);*/
                $("#tg").find("tr:last").after(html);
            }
    }
    </script>
</head>
<body>
<div style="color: #0052A3;margin-left: 800px">
    <h1>欢迎添加试卷</h1>
</div>
<div id="topid">
    <table class="bt_table" width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr >
            <td id="saveid">
                <div onclick="btsave();" style="width: 50px;" id="saveid">
                    <span class="bt_save"></span><span>&nbsp;保存</span>
                </div>
            </td>
            <td class="td">
                <div onclick="returnBack();" style="width: 50px;">
                    <span class="bt_back"></span><span>&nbsp;返回</span>
                </div>
            </td>

            <td width="100%" class="">
            </td>
        </tr>
    </table>

    <table class="sou_tab" width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup><col width="10%"/><col width="30%"/><col width="10%"/><col width="30%"/><col  width="20%"/></colgroup>
        <tr>
            <td class="td_1">专题试卷名称：</td>
            <td class="td_2" colspan="3">
                <input class="tex_1 must resetwidth" id="subject" name="subject" onblur="validateBlur(this,true,150)" style="height:25px;width:80%;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1">专题试卷难度：</td>
            <td class="td_2" colspan="3">
                <input class="tex_1 must resetwidth" id="itemDiffculty" name="itemDiffculty" onblur="validateBlur(this,true,150)" style="height:25px;width:30%;"/>
            </td>
        </tr>
        <tr>
            <td class="td_1">考试开始时间：</td>
            <td class="td_2" >
                <span id="abc"></span>
                <input class="datainp" id="datebut"  type="text" placeholder="请选择">
                <input class="tex_1 must" id="time"  name="time" type="image" src="images/icon_calendar.png"  style="width:30px;height:28px"
                       onblur="validateBlur(this,true,10)"
                       onclick="jeDate({dateCell:'#datebut',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})">
            </td>
            <td class="td_1">考试结束时间：</td>
            <td class="td_2" >
                <input class="datainp" id="datebuts"  type="text" placeholder="请选择">
                <input class="tex_1 must" id="times"  name="times" type="image" src="images/icon_calendar.png"  style="width:30px;height:28px"
                       onblur="validateBlur(this,true,10)"
                       onclick="jeDate({dateCell:'#datebuts',isTime:true,format:'YYYY-MM-DD hh:mm:ss'})" >
            </td>
        </tr>

        <tr>
            <td class="td_1">题型设置：</td>
            <td class="td_2" colspan="3">
                <table border="0" cellspacing="0" cellpadding="0" style="width:80%;margin-top:10px;margin-bottom: 10px;">
                    <tr>
                        <td style="text-align: left;font-weight: bold;">题型</td>
                        <td style="text-align: left;font-weight: bold;width: 140px;">试题数量</td>
                        <td style="text-align: left;font-weight: bold;width: 140px;">每题分值</td>
                        <td style="text-align: left;font-weight: bold;width: 140px;">总分值</td>
                        <td style="text-align: left;font-weight: bold;width: 140px;">已选题数</td>
                    </tr>
                    <tr>
                        <td class="stlx" style="text-align: left;">
                            单选题<input id="danxtxid" name="txid" type="checkbox"   value="0"/>
                            <input id="btseldanxId" class="bt_select" style="display:none;" onclick="openTestRadio(0);" type="button" src="images/sousuo.png"/>
                        </td>
                        <td  class="stlx" style="text-align: left;" >
                            <input id = "radioNumber"   name ="radioNumber" type="text" <%--onblur="event_onblurMark(this,1);"--%>  value="" style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "radioScore"  name ="radioScore" type="text" <%-- onblur="event_onblurMark(this,1)"--%>  value=""  style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "danxfzid"  name ="mtfz" type="text" style="width: 50px"  value="0" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "danxyxid"  name ="yxts" type="text" style="width: 50px"  value="0"  disabled="disabled">
                        </td>
                    </tr>
                    <tr>
                        <td  class="stlx" style="text-align: left;">
                            多选题<input id="duoxtxid" name="txid" type="checkbox"  value="2" />
                            <input id="btselduoxId" class="bt_select" style="display: none;" onclick="openTestCheckbox(2);" type="button" src="images/sousuo.png"/>
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "checkboxNumber"    name ="checkboxNumber" type="text"  <%--onblur="event_onblurMark(this,2);"--%> value="" style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "checkboxScore"   name ="checkboxScore" type="text" <%-- onblur="event_onblurMark(this,2);"--%> value="" style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "duoxfzid"  name ="mtfz" type="text" style="width: 50px"  value="0" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "duoxyxid"  name ="yxts" type="text" style="width: 50px"  value="0"  disabled="disabled">
                        </td>
                    </tr>
                    <tr>
                        <td  class="stlx" style="text-align: left;">
                            解答题<input id="pdtxid" name="txid" type="checkbox"  value="1" />
                            <input id="btselpdId" class="bt_select" style="display: none;" onclick="openTestAnswer(1);" type="button" src="images/sousuo.png" />
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "answerNumber"  name ="answerNumber" type="text"  <%--onblur="event_onblurMark(this,3);"--%>  value="" style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "answerScore"  name ="answerScore" type="text"  <%--onblur="event_onblurMark(this,3);"--%> value="" style="width: 50px" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "pdfzid"  name ="mtfz" type="text" style="width: 50px"  value="0" disabled="disabled">
                        </td>
                        <td  class="stlx" style="text-align: left;">
                            <input id = "pdyxid"  name ="yxts" type="text" style="width: 50px"  value="0"  disabled="disabled">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table width="100%" class="bt_table" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <div onclick="deleteColumn();" style="width: 50px;" id="deleteid">
                    <span class=bt_delete></span><span>&nbsp;删除</span>
                </div>
            </td>
            <td width="100%">
            </td>
        </tr>
        <tr>
            <td style="height: 2px; background-color: white;" colspan="2">
            </td>
        </tr>
    </table>

</div>
<%--<table id="tg"  style=width:1950px;height:800px;"  class="easyui-datagrid"  pagination="false"
       data-options="method:'get',border:false,singleSelect:false,striped:true,nowrap:false,
	    fit:false,fitColumns:true,rowNumbers:true,remoteSort:false,sortName:'type',sortOrder:'desc'">
    <thead>
    <tr>
        <th field="id" checkbox="true" id="questionId"></th>
        <th data-options="field:'testContent',width:150,align:'center'">试题名称</th>
        <th data-options="field:'subject',width:100,align:'center'">试题科目</th>
        <th data-options="field:'itemDifficulty',width:150,align:'center'">试题难度</th>
        <th data-options="field:'createDate',width:100,align:'center'">试题创建时间</th>
    </tr>
    </thead>
</table>--%>
<table id="tg"  border="0" cellspacing="0" cellpadding="0" style="width:80%;margin-top:10px;margin-bottom: 10px;display: none">
    <tr>
       <td style="text-align: left;font-weight: bold;width: 300px;padding-left: 20px">试题名称</td>
       <td style="text-align: left;font-weight: bold;width: 100px;">试题科目</td>
       <td style="text-align: left;font-weight: bold;width: 100px;">试题类型</td>
       <td style="text-align: left;font-weight: bold;width: 100px;display: none;">试题类型</td>
       <td style="text-align: left;font-weight: bold;width: 100px;display: none;">试题ID</td>
       <td style="text-align: left;font-weight: bold;width: 100px;">试题难度</td>
       <td style="text-align: left;font-weight: bold;width: 100px;">试题创建时间 </td>
   </tr>
</table>
<div id="dlg" style="margin-top: 2%;"></div>
</body>
</html>




