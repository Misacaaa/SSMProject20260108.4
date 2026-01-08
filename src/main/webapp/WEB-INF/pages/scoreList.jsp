<%--
  路径：src/main/webapp/WEB-INF/jsp/scoreList.jsp
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成绩列表 - 教务系统</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery & Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        header {
            background: linear-gradient(to right, #0d9488, #0f766e);
            color: white;
            padding: 20px 30px;
            text-align: center;
        }
        h1 {
            font-size: 24px;
            margin: 0;
        }
        .table-container {
            padding: 25px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 14px 12px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        th {
            color: #334155;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
        }
        tr:hover {
            background-color: #f1f5f9;
        }
        .score-value {
            font-weight: bold;
            color: #0d9488;
            font-size: 16px;
        }
        .empty {
            text-align: center;
            color: #94a3b8;
            padding: 40px 0;
            font-style: italic;
        }
        footer {
            text-align: center;
            padding: 15px;
            color: #94a3b8;
            font-size: 14px;
            border-top: 1px solid #f1f5f9;
        }
        @media (max-width: 600px) {
            th, td { padding: 10px 6px; font-size: 14px; }
            .container { margin: 10px; }
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>📊 所有学生成绩列表</h1>
    </header>

    <div class="table-container">
        <c:choose>
            <c:when test="${not empty pageInfo.list}">
                <table>
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>学生姓名</th>
                        <th>课程名称</th>
                        <th>成绩</th>
                        <th>考试日期</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${pageInfo.list}" var="score">
                        <tr>
                            <td>${score.studentId}</td>
                            <td><strong>${score.studentName}</strong></td>
                            <td>${score.courseName}</td>
                            <td>
                                        <span class="score-value">
                                            <fmt:formatNumber value="${score.score}" pattern="0.00"/>
                                        </span>
                            </td>
                            <td>
                                <fmt:formatDate value="${score.examDate}" pattern="yyyy-MM-dd"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty">暂无成绩数据。</div>
            </c:otherwise>
        </c:choose>
    </div>
    <!-- ========== 分页导航（Bootstrap 5） ========== -->
    <c:if test="${pageInfo.pages > 1}">
        <nav aria-label="成绩分页导航" class="mt-4">
            <ul class="pagination justify-content-center">

                <!-- 首页 -->
                <li class="page-item ${pageInfo.isFirstPage ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/score/list?pageNum=1&pageSize=${pageInfo.pageSize}">首页</a>
                </li>

                <!-- 上一页 -->
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pageNum - 1}&pageSize=${pageInfo.pageSize}">«</a>
                    </li>
                </c:if>
                <c:if test="${!pageInfo.hasPreviousPage}">
                    <li class="page-item disabled">
                        <span class="page-link">«</span>
                    </li>
                </c:if>

                <!-- 页码 -->
                <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                    <c:choose>
                        <c:when test="${page == pageInfo.pageNum}">
                            <li class="page-item active" aria-current="page">
                                <span class="page-link">${page}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/score/list?pageNum=${page}&pageSize=${pageInfo.pageSize}">${page}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 下一页 -->
                <c:if test="${pageInfo.hasNextPage}">
                    <li class="page-item">
                        <a class="page-link" href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pageNum + 1}&pageSize=${pageInfo.pageSize}">»</a>
                    </li>
                </c:if>
                <c:if test="${!pageInfo.hasNextPage}">
                    <li class="page-item disabled">
                        <span class="page-link">»</span>
                    </li>
                </c:if>

                <!-- 末页 -->
                <li class="page-item ${pageInfo.isLastPage ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pages}&pageSize=${pageInfo.pageSize}">末页</a>
                </li>

            </ul>
        </nav>

        <!-- 分页信息 -->
        <div class="text-center text-muted small">
            共 ${pageInfo.total} 条记录，每页 ${pageInfo.pageSize} 条，共 ${pageInfo.pages} 页
        </div>
    </c:if>

</div>
</body>
</html>