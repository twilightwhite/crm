<%--
  Created by IntelliJ IDEA.
  User: lovelywhite
  Date: 2019/7/1
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.contextPath}/"/>
    <title>Title</title>
    <script>
        $.ajax({
            url : "",
            data : {
                "" : loginAct,
                "" : loginPwd
            },
            type : "",
            dataType : "json",
            success : function (data) {

            }
        });
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
    </script>
</head>
<body>

</body>
</html>
