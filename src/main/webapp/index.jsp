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
               //在页面加载完毕后刷新市场活动列表
                pageList(1,2);

                //为查询按钮绑定事件，执行条件查询
                $("#searchBtn").click(function () {
                    pageList(1,2);
                });

            });

            function pageList(pageNo,pageSize) {

            }
        </script>
    </head>
    <body>

        <div>
            <div style="position: relative; left: 10px; top: -10px;">
                <div class="page-header">
                    <h3>学生信息列表</h3>
                        <!--

                            tbl_student

                            id
                            name
                            gender
                            address
                            phone

                        -->
                </div>
            </div>
        </div>
        <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
            <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

                <div class="btn-toolbar" role="toolbar" style="height: 80px;">
                    <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">学生姓名</div>
                                <input class="form-control" type="text" id="search-name">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">学生性别</div>
                                <input class="form-control" type="text" id="search-owner">
                            </div>
                        </div>


                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">家庭地址</div>
                                <input class="form-control" type="text" id="search-startDate" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">联系电话</div>
                                <input class="form-control" type="text" id="search-endDate">
                            </div>
                        </div>

                        <button type="button" id="searchBtn" class="btn btn-default">查询</button>

                    </form>
                </div>
                <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">

                </div>
                <div style="position: relative;top: 10px;">
                    <table class="table table-hover">
                        <thead>
                            <tr style="color: #B3B3B3;">
                                <td><input type="checkbox" id="selAll"/></td>
                                <td>姓名</td>
                                <td>性别</td>
                                <td>家庭地址</td>
                                <td>联系电话</td>
                            </tr>
                        </thead>
                        <tbody id="studentBody">
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
                                <td>2020-10-20</td>--%>
                            </tr>
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
