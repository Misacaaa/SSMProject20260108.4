<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>成绩列表 - 教务系统</title>

    <!-- 字体-->
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans SC', sans-serif;
            background-color: #f5e6d3; /* 卷轴纸色 */
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(222, 184, 135, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 90% 80%, rgba(205, 133, 63, 0.1) 0%, transparent 20%);
            color: #3e2723;
            padding: 40px 20px;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* ========== 动画定义 ========== */
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @keyframes flip {
            0% { transform: rotateY(0deg); opacity: 1; }
            50% { transform: rotateY(90deg); opacity: 0.3; }
            100% { transform: rotateY(180deg); opacity: 1; }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        @keyframes sparkle {
            0%, 100% {
                text-shadow:
                        0 0 8px #ffeb3b,
                        0 0 16px #ff9800,
                        0 0 24px #f44336;
                opacity: 1;
            }
            50% {
                text-shadow:
                        0 0 12px #ffeb3b,
                        0 0 24px #ff9800,
                        0 0 36px #f44336,
                        0 0 48px #e91e63;
                opacity: 0.9;
            }
        }

        .corner-icon {
            position: absolute;
            font-size: 28px;
            opacity: 0.9;
            pointer-events: none;
            z-index: 10;
        }

        .top-left {
            top: 30px;
            left: 30px;
            animation: sparkle 1.8s ease-in-out infinite;
            opacity: 1 !important;
            color: #ff5722;
        }

        .top-right {
            top: 30px;
            right: 30px;
            animation: flip 4s linear infinite;
            transform-origin: center;
        }

        .bottom-left {
            bottom: 30px;
            left: 30px;
            color: #66ff33;
            text-shadow: 0 0 8px rgba(102, 255, 51, 0.7);
            animation: float 3s ease-in-out infinite;
            opacity: 1 !important;
        }

        .bottom-right {
            bottom: 30px;
            right: 30px;
            color: #f48fb1;
            text-shadow: 0 0 6px rgba(244, 143, 177, 0.6);
            animation: spin 12s linear infinite;
            opacity: 1 !important;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        h1 {
            font-family: 'Ma Shan Zheng', cursive;
            text-align: center;
            font-size: 3.2em;
            color: #d35400; /* 木叶橙 */
            text-shadow: 2px 2px 0 #000, 4px 4px 0 rgba(0,0,0,0.1);
            margin-bottom: 30px;
            letter-spacing: 4px;
            position: relative;
        }

        h1::after {
            content: "";
            display: block;
            width: 120px;
            height: 4px;
            background: linear-gradient(to right, #d35400, #c0392b);
            margin: 10px auto;
            border-radius: 2px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            background: #fdf6ec;
            border: 8px solid #5d4037;
            border-radius: 12px;
            box-shadow:
                    0 6px 12px rgba(0,0,0,0.3),
                    inset 0 0 10px rgba(161, 102, 45, 0.2);
            overflow: hidden;
            font-size: 16px;
        }

        th, td {
            padding: 14px 16px;
            text-align: center;
            border-bottom: 2px solid #d7ccc8;
        }

        th {
            background: linear-gradient(to bottom, #d35400, #b03a2e);
            color: white;
            font-weight: bold;
            text-shadow: 1px 1px 1px rgba(0,0,0,0.5);
            font-size: 1.1em;
            letter-spacing: 1px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:nth-child(even) {
            background-color: #faf2e4;
        }

        tr:hover {
            background-color: #ffe0b2 !important;
            transform: scale(1.01);
            transition: all 0.2s ease;
            box-shadow: inset 0 0 8px rgba(211, 84, 0, 0.3);
        }

        .empty-state {
            text-align: center;
            color: #7f8c8d;
            font-style: italic;
            font-size: 1.2em;
            padding: 40px;
            background: #f9f0e0;
            border: 2px dashed #d35400;
            border-radius: 10px;
            margin-top: 20px;
        }

        .footer-note {
            text-align: center;
            margin-top: 30px;
            color: #8b4513;
            font-size: 0.9em;
            font-family: 'Noto Sans SC', sans-serif;
        }

        .badge {
            display: inline-block;
            padding: 4px 10px;
            background-color: #d4af37;
            color: #000;
            font-weight: bold;
            border-radius: 12px;
            border: 1px solid #8b4513;
            font-size: 0.95em;
        }

        /* ========== 分页样式（火影忍者风格） ========== */
        .pagination-container {
            margin-top: 30px;
            text-align: center;
        }

        .pagination {
            display: inline-flex;
            list-style: none;
            padding: 0;
            gap: 6px;
        }

        .pagination .page-item a,
        .pagination .page-item span {
            display: inline-block;
            padding: 8px 14px;
            background: #fdf6ec;
            border: 2px solid #d35400;
            color: #d35400;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: all 0.2s;
            min-width: 36px;
            text-align: center;
        }

        .pagination .page-item.active span {
            background: #d35400;
            color: white;
            border-color: #b03a2e;
        }

        .pagination .page-item.disabled span {
            color: #aaa;
            border-color: #ccc;
            cursor: not-allowed;
        }

        .pagination .page-item:not(.disabled):not(.active) a:hover {
            background: #ffe0b2;
            transform: scale(1.05);
            box-shadow: 0 2px 6px rgba(211, 84, 0, 0.3);
        }

        .pagination-info {
            margin-top: 12px;
            color: #8b4513;
            font-size: 0.95em;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.4em;
            }
            table {
                font-size: 14px;
            }
            th, td {
                padding: 10px 8px;
            }
            .corner-icon {
                font-size: 24px;
                top: 20px;
                left: 20px;
                right: 20px;
                bottom: 20px;
            }
            .pagination .page-item a,
            .pagination .page-item span {
                padding: 6px 10px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<!-- ========== 四角装饰图标 ========== -->
<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div>
<div class="corner-icon bottom-right">🍥</div>

<div class="container">
    <h1>📊 所有学生成绩列表</h1>

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
                            <span class="badge">
                                <fmt:formatNumber value="${score.score}" pattern="0.00"/> 分
                            </span>
                        </td>
                        <td>
                            <fmt:formatDate value="${score.examDate}" pattern="yyyy-MM-dd"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- ========== 分页导航（火影忍者风格） ========== -->
            <c:if test="${pageInfo.pages > 1}">
                <div class="pagination-container">
                    <ul class="pagination">

                        <!-- 首页 -->
                        <li class="page-item ${pageInfo.isFirstPage ? 'disabled' : ''}">
                            <c:choose>
                                <c:when test="${pageInfo.isFirstPage}">
                                    <span class="page-link">首页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/score/list?pageNum=1&pageSize=${pageInfo.pageSize}">首页</a>
                                </c:otherwise>
                            </c:choose>
                        </li>

                        <!-- 上一页 -->
                        <c:choose>
                            <c:when test="${pageInfo.hasPreviousPage}">
                                <li class="page-item">
                                    <a href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pageNum - 1}&pageSize=${pageInfo.pageSize}">«</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item disabled">
                                    <span>«</span>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <!-- 页码 -->
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <c:choose>
                                <c:when test="${page == pageInfo.pageNum}">
                                    <li class="page-item active">
                                        <span>${page}</span>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <a href="${pageContext.request.contextPath}/score/list?pageNum=${page}&pageSize=${pageInfo.pageSize}">${page}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- 下一页 -->
                        <c:choose>
                            <c:when test="${pageInfo.hasNextPage}">
                                <li class="page-item">
                                    <a href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pageNum + 1}&pageSize=${pageInfo.pageSize}">»</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item disabled">
                                    <span>»</span>
                                </li>
                            </c:otherwise>
                        </c:choose>

                        <!-- 末页 -->
                        <li class="page-item ${pageInfo.isLastPage ? 'disabled' : ''}">
                            <c:choose>
                                <c:when test="${pageInfo.isLastPage}">
                                    <span class="page-link">末页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/score/list?pageNum=${pageInfo.pages}&pageSize=${pageInfo.pageSize}">末页</a>
                                </c:otherwise>
                            </c:choose>
                        </li>

                    </ul>

                    <!-- 分页信息 -->
                    <div class="pagination-info">
                        共 ${pageInfo.total} 条记录，每页 ${pageInfo.pageSize} 条，共 ${pageInfo.pages} 页
                    </div>
                </div>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <h3>暂无成绩数据</h3>
                <p>当前系统中没有成绩记录，请联系管理员导入。</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="footer-note">
        <small>© 2026 教务管理系统 | 成绩管理模块</small>
    </div>
</div>

</body>
</html>