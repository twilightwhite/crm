<%--
  Created by IntelliJ IDEA.
  User: lovelywhite
  Date: 2019/7/1
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <base href="${pageContext.request.contextPath}/"/>
        <meta charset="UTF-8">

        <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
        <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

        <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
        <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
        <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
        <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
        <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

        <script type="text/javascript">
            $(function () {
                //时间控件
                $(".time").datetimepicker({
                    minView: "month",
                    language:  'zh-CN',
                    format: 'yyyy-mm-dd',
                    autoclose: true,
                    todayBtn: true,
                    pickerPosition: "bottom-left"
                });

               //为创建的按钮绑定事件，打开添加操作的模态窗口
               $("#addBtn").click(function () {
                   /*
                        操作bootstrap模态窗口的方式
                            取得模态窗口的对象，调用model方法，为该方法传递参数
                                    show：打开模态窗口
                                    hide：关闭模态窗口
                    */
                   $.ajax({
                       url : "workbench/activity/getUserList.do",
                       type : "get",
                       dataType : "json",
                       success : function (data) {
                           /*
                                data
                                List<User> uList
                            */
                           var html = "<option></option>";
                           //每一个n就是一个对象
                           $.each(data,function (i,n) {
                              html +=  "<option value='" + n.id + "'>" + n.name + "</option>";
                           });

                           //为所有者的下拉框铺值
                           $("#create-owner").html(html);
                           //将当前登录的用户当做所有者的默认选项
                           //取得当前用户的id，然后为select赋予value值，就是用户的id
                           //js代码中可以使用EL表达式,但是EL表达式必须套用在字符串中
                           var id = "${user.id}";
                           $("#create-owner").val(id);
                           //打开添加市场活动的模态窗口
                           $("#createActivityModal").modal("show");
                       }
                   });
               });

               //为保存按钮绑定事件，执行市场活动的添加操作
               $("#saveBtn").click(function () {
                   $.ajax({
                       url : "workbench/activity/save.do",
                       data : {
                           "owner" :$.trim($("#create-owner").val()),
                           "name" :$.trim($("#create-name").val()),
                           "startDate" :$.trim($("#create-startDate").val()),
                           "endDate" :$.trim($("#create-endDate").val()),
                           "cost" :$.trim($("#create-cost").val()),
                           "description" :$.trim($("#create-description").val())

                       },
                       type : "post",
                       dataType : "json",
                       success : function (data) {
                           /*
                                data
                                    {"success" true/false}
                            */
                           if (data.success) {
                               //添加成功
                               //刷新列表
                               //pageList(1,2);
                               pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                               //清空模态窗口中的信息
                               /*

                                    jquery为我们提供了 submit()方法，执行提交表单的操作
                                    但是并没有为我们提供reset()方法，我们表单的jquery对象就不能使用reset()方法重置表单

                                    虽然jquery没有为我们提供reset方法，但是原生js提供了这个reset方法

                                    jquery对象转换为js对象
                                        jquery对象[i]

                                    js对象转换为jquery对象
								    $(dom)

						        */
                               $("#activitySaveForm")[0].reset();
                               //关闭模态窗口
                               $("#createActivityModal").modal("hide");
                           }else {
                               alert("市场活动添加失败")
                           }
                       }
                   });
               });

               //在页面加载完毕后刷新市场活动列表
                pageList(1,2);

                //为查询按钮绑定事件，执行条件查询
                $("#searchBtn").click(function () {
                    //将搜索框中的信息保存到隐藏域中
                    $("#hidden-name").val($.trim($("#search-name").val()));
                    $("#hidden-owner").val($.trim($("#search-owner").val()));
                    $("#hidden-startDate").val($.trim($("#search-startDate").val()));
                    $("#hidden-endDate").val($.trim($("#search-endDate").val()));
                    pageList(1,2);
                });

                //为全选复选框绑定事件，执行全选操作
                $("#selAll").click(function () {
                    $("input[name = selOne]").prop("checked",this.checked);
                });

                //所有 name = selOne的复选框是拼接成的，为动态拼接的元素，不能以传统的方式来绑定事件

                /*$("input[name = selOne]").click(function () {
                    alert(123);
                });*/

                /*
                     动态生成的元素绑定事件需要使用 on 方法来绑定
                     $(需要绑定的元素的有效的父级元素).on(绑定事件的方法，需要绑定的元素，回调函数)
                 */
                $("#activityBody").on("click",$("input[name=selOne]"),function () {
                   $("#selAll").prop("checked",$("input[name=selOne]").length == $("input[name=selOne]:checked").length);
                });

                //为删除按钮绑定事件
                $("#deleteBtn").click(function () {
                    var $xz = $("input[name=selOne]:checked");
                    if ($xz.length == 0){
                        alert("请选择需要删除的记录")
                    }else{//肯定选择了需要删除的元素，不一定只有一条
                        //  workbench/activity/delete.do?id=xxx&id=xxx
                        if (confirm("确定删除所选记录吗？")){
                            //同一个 key下  多个参数  使用上面的方法传参  不适用json字符串
                            var param = "";
                            for (var i = 0;i < $xz.length; i++){
                                param += "id="+$($xz[i]).val();
                                //如果不是最后一个元素
                                if (i < $xz.length - 1){
                                    param += "&";
                                }
                            }
                            $.ajax({
                                url : "workbench/activity/delete.do",
                                data : param,
                                type : "post",
                                dataType : "json",
                                success : function (data) {
                                    if (data.success) {
                                        //删除成功
                                        //刷新列表
                                        //pageList(1,2);
                                        pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                                    }
                                }
                            });
                        } else {
                            alert("删除失败");
                        }
                    }
                });

                //为修改按钮绑定事件，打开修改操作的模态窗口
                $("#editBtn").click(function () {
                    var $xz = $("input[name=selOne]:checked");
                    if ($xz.length == 0){
                        alert("请选择要修改的记录");
                    } else if ($xz.length > 1){
                        alert("只能选择一条记录");
                    } else{//肯定选择了  而且只选了一条
                        //将选中的复选框值  id  取出
                        /*
                            对于复选框的取值，如果能够保证一条记录，
                            可以直接通过jQuery来取值
                         */
                        //$($xz[0]).val();
                        var id = $xz.val();
                        $.ajax({
                            url : "workbench/activity/getUserListAndActivity.do",
                            data : {
                                "id" : id
                            },
                            type : "get",
                            dataType : "json",
                            success : function (data) {
                                /*
                                    data
                                        List<User> list
                                        Activity a

                                        {"uList" : [{用户1}，{2}，{3}]，"a":{市场活动}}

                                 */
                                var html = "<option></option>";
                                $.each(data.uList,function (i,n) {
                                    html += "<option value='"+ n.id +"'>"+ n.name +"</optionvalue>";
                                });

                                //为所有者的下拉框铺值
                                $("#edit-owner").html(html);

                                //为表单其他元素铺值
                                $("#edit-id").val(data.a.id);
                                $("#edit-name").val(data.a.name);
                                $("#edit-owner").val(data.a.owner);
                                $("#edit-startDate").val(data.a.startDate);
                                $("#edit-endDate").val(data.a.endDate);
                                $("#edit-cost").val(data.a.cost);
                                $("#edit-description").val(data.a.description);

                                //打开修改操作的模态窗口
                                $("#editActivityModal").modal("show");
                            }
                        });
                    }
                });
                
                //为更新按钮绑定事件，执行修改操作
                $("#updateBtn").click(function () {
                    $.ajax({
                        url : "workbench/activity/update.do",
                        data : {
                            "id" :$.trim($("#edit-id").val()),
                            "owner" :$.trim($("#edit-owner").val()),
                            "name" :$.trim($("#edit-name").val()),
                            "startDate" :$.trim($("#edit-startDate").val()),
                            "endDate" :$.trim($("#edit-endDate").val()),
                            "cost" :$.trim($("#edit-cost").val()),
                            "description" :$.trim($("#edit-description").val())

                        },
                        type : "post",
                        dataType : "json",
                        success : function (data) {
                            /*
                                 data
                                     {"success" true/false}
                             */
                            if (data.success) {
                                //修改成功
                                //刷新列表
                                //pageList(1,2);
                                pageList($("#activityPage").bs_pagination('getOption', 'currentPage'),
                                    $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                                //关闭模态窗口
                                $("#editActivityModal").modal("hide");
                            }else {
                                alert("市场活动修改失败")
                            }
                        }
                    });
                });
                
            });

            /*
                pageNo:当前页的页码
                pageSize：每页展现的记录数

                这两个参数是所有关系型数据库分页操作的基础参数，有了这两个参数，其他所有的信息都惠济路出来
             */

            /*
                分析 pageList方法的入口   （也就是在什么时候刷新市场活动列表）
                1 在页面加载完毕后刷新市场活动列表
                2 点击查询按钮 调用pageList方法  刷新市场活动列表
                3 点击分页插件   调用pageList方法  刷新市场活动列表
                4 添加操作后    调用pageList方法  刷新市场活动列表
                5 修改操作后    调用pageList方法  刷新市场活动列表
                6 删除操作后    调用pageList方法  刷新市场活动列表

             */

            /*
                应该为后台传递那些参数
                分页查询参数
                pageNo
                pageSize

                条件查询参数
                name
                owner
                startDate
                endDate

             */
            function pageList(pageNo,pageSize) {
                //将全选√取消掉
                $("#selAll").prop("checked",false);
                //从隐藏域中讲值取出赋值给搜索框
                $("#search-name").val($.trim($("#hidden-name").val()));
                $("#search-owner").val($.trim($("#hidden-owner").val()));
                $("#search-startDate").val($.trim($("#hidden-startDate").val()));
                $("#search-endDate").val($.trim($("#hidden-endDate").val()));
                //alert("查询并展现市场活动列表");
                $.ajax({
                    url : "workbench/activity/pageList.do",
                    data : {
                        "pageNo" : pageNo,
                        "pageSize" : pageSize,
                        "name" : $.trim($("#search-name").val()),
                        "owner" : $.trim($("#search-owner").val()),
                        "startDate" : $.trim($("#search-startDate").val()),
                        "endDate" : $.trim($("#search-endDate").val())
                    },
                    type : "get",
                    dataType : "json",
                    success : function (data) {
                        /*
                            data
                                List<Activity>  dataList
                                [{市场活动1}，{2}，{3}]

                            int total  查询出来的总条数

                            通过data分析后台需要为我们提供total 和 dataList
                            后台如何为我们提供这两项数据
                            vo
                             {"total" : 100,"dataList" : [{市场活动1}，{2}，{3}]}
                         */
                        var html = "";
                        $.each(data.dataList,function (i,n) {
                            html += '<tr class="active">';
                            html += '<td><input type="checkbox" name="selOne" value="' + n.id +'" /></td>';
                            html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.id+'\';">' + n.name + '</a></td>';
                            html += '<td>' + n.owner + '</td>';
                            html += '<td>' + n.startDate + '</td>';
                            html += '<td>' + n.endDate + '</td>';
                            html += '</tr>';
                        });
                        $("#activityBody").html(html);
                        var totalPages = data.total % pageSize == 0 ? data.total / pageSize : parseInt(data.total / pageSize) + 1;
                        //处理完列表之后，加入分页插件 bs-pagination
                        $("#activityPage").bs_pagination({
                            currentPage: pageNo, // 页码
                            rowsPerPage: pageSize, // 每页显示的记录条数
                            maxRowsPerPage: 10, // 每页最多显示的记录条数
                            totalPages: totalPages, // 总页数
                            totalRows: data.total, // 总记录条数

                            visiblePageLinks: 3, // 显示几个卡片

                            showGoToPage: true,
                            showRowsPerPage: true,
                            showRowsInfo: true,
                            showRowsDefaultInfo: true,

                            //该函数是在我们点击分页组件后，触发的
                            onChangePage : function(event, data){
                                pageList(data.currentPage , data.rowsPerPage);
                            }
                        });

                    }
                });

            }
        </script>
    </head>
    <body>
        <input type="hidden" id="hidden-name"/>
        <input type="hidden" id="hidden-owner"/>
        <input type="hidden" id="hidden-startDate"/>
        <input type="hidden" id="hidden-endDate"/>
        <!-- 创建市场活动的模态窗口 -->
        <div class="modal fade" id="createActivityModal" role="dialog">
            <div class="modal-dialog" role="document" style="width: 85%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
                    </div>
                    <div class="modal-body">

                        <form id="activitySaveForm" class="form-horizontal" role="form">

                            <div class="form-group">
                                <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <select class="form-control" id="create-owner">

                                    </select>
                                </div>
                                <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="create-name">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" id="create-startDate" readonly>
                                </div>
                                <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" id="create-endDate" readonly>
                                </div>
                            </div>
                            <div class="form-group">

                                <label for="create-cost" class="col-sm-2 control-label">成本</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="create-cost">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-describe" class="col-sm-2 control-label">描述</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-description"></textarea>
                                </div>
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <!--
                                 data-dismiss="modal"  关闭模态窗口
                        -->
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 修改市场活动的模态窗口 -->
        <div class="modal fade" id="editActivityModal" role="dialog">
            <div class="modal-dialog" role="document" style="width: 85%;">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
                    </div>
                    <div class="modal-body">

                        <form class="form-horizontal" role="form">
                            <input type="hidden" id="edit-id"/>
                            <div class="form-group">
                                <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <select class="form-control" id="edit-owner">

                                    </select>
                                </div>
                                <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="edit-name" value="发传单">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" id="edit-startDate">
                                </div>
                                <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" id="edit-endDate">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="edit-cost">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <!--
                                        关于页面中的文本域textarea
                                        观察textarea
                                            1 textarea标签对中不能有空格换行
                                            2 textarea在表单元素中是比较特殊的存在，该表单元素的值去其他表单元素的表现形式不一样
                                                其他的表单元素input select...  值都是以value属性值的形式来呈现的
                                                textarea没有value属性值
                                                虽然textarea没有value属性值但是仍然以val方法操作textarea标签（而不是html方法）
                                    -->
                                    <textarea class="form-control" rows="3" id="edit-description"></textarea>
                                </div>
                            </div>

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="updateBtn">更新</button>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <div style="position: relative; left: 10px; top: -10px;">
                <div class="page-header">
                    <h3>市场活动列表</h3>
                </div>
            </div>
        </div>
        <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
            <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

                <div class="btn-toolbar" role="toolbar" style="height: 80px;">
                    <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">名称</div>
                                <input class="form-control" type="text" id="search-name">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">所有者</div>
                                <input class="form-control" type="text" id="search-owner">
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">开始日期</div>
                                <input class="form-control" type="text" id="search-startDate" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">结束日期</div>
                                <input class="form-control" type="text" id="search-endDate">
                            </div>
                        </div>

                        <button type="button" id="searchBtn" class="btn btn-default">查询</button>

                    </form>
                </div>
                <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
                    <div class="btn-group" style="position: relative; top: 18%;">
                        <!--
                            data-toggle = "model"
                                表示触发按钮，将要打开一个模态窗口(模态框)
                            data-target="#createActivityModal"
                                表示指定模态窗口目标，通过ID来指定
                            需求：
                                在打开模态窗口之前弹出一个   alert(123)

                                弹不了！！！
                                因为我们现在出发模态窗口，是以标签中固定的属性和属性值来决定的
                                对于按钮，按钮能够触发的行为永远不是以属性属性值的形式来写死的
                                    我们应该给按钮起一个id名字   然后通过该按钮绑定事件，以触发js代码的形式来控制行为
                        -->
                        <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                        <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                        <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                    </div>

                </div>
                <div style="position: relative;top: 10px;">
                    <table class="table table-hover">
                        <thead>
                            <tr style="color: #B3B3B3;">
                                <td><input type="checkbox" id="selAll"/></td>
                                <td>名称</td>
                                <td>所有者</td>
                                <td>开始日期</td>
                                <td>结束日期</td>
                            </tr>
                        </thead>
                        <tbody id="activityBody">
                            <%--<tr class="active">
                                <td><input type="checkbox" /></td>
                                <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                                <td>zhangsan</td>
                                <td>2020-10-10</td>
                                <td>2020-10-20</td>
                            </tr>
                            <tr class="active">
                                <td><input type="checkbox" /></td>
                                <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>
                                <td>zhangsan</td>
                                <td>2020-10-10</td>
                                <td>2020-10-20</td>
                            </tr>--%>
                        </tbody>
                    </table>
                </div>

                <div style="height: 50px; position: relative;top: 30px;">
                    <div id="activityPage">

                    </div>
                </div>

            </div>

        </div>
    </body>
</html>
