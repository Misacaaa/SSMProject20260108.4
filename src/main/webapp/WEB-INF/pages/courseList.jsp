<%--
  文件路径：src/main/webapp/WEB-INF/jsp/courseList.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程列表 - 教务管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        header {
            background: linear-gradient(135deg, #4e73df, #224abe);
            color: white;
            padding: 20px 30px;
            text-align: center;
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
        }

        .content {
            padding: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #f1f5ff;
            color: #2c3e50;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }

        tr:hover {
            background-color: #f9fbff;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .empty-message {
            text-align: center;
            color: #777;
            font-style: italic;
            padding: 30px 0;
            font-size: 16px;
        }

        footer {
            text-align: center;
            padding: 15px;
            color: #888;
            font-size: 14px;
            border-top: 1px solid #eee;
            margin-top: 20px;
        }

        @media (max-width: 600px) {
            th, td {
                padding: 10px 8px;
                font-size: 14px;
            }
            h1 {
                font-size: 22px;
            }
            .content {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>📚 课程信息列表</h1>
    </header>

    <div class="content">
        <c:choose>
            <c:when test="${not empty courseList}">
                <table>
                    <thead>
                    <tr>
                        <th>课程编号</th>
                        <th>课程名称</th>
                        <th>学分</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${courseList}" var="course">
                        <tr>
                            <td><strong>${course.courseId}</strong></td>
                            <td>${course.courseName}</td>
                            <td>
                                        <span style="background:#eef2ff; color:#4e73df; padding:4px 8px; border-radius:4px; font-weight:bold;">
                                                ${course.credit}
                                        </span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    ⚠️ 暂无课程数据，请联系管理员添加课程。
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer>

    </footer>
</div>
</body>
</html>