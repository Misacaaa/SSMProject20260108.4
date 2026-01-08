<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>课程信息列表 - 教务管理系统</title>

    <!-- 字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans SC', sans-serif;
            background-color: #f5e6d3;
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

        @keyframes rotate {
            to { transform: rotate(360deg); }
        }

        @keyframes flip {
            0% { transform: rotateY(0deg); opacity: 1; }
            25% { transform: rotateY(30deg); opacity: 0.85; }
            50% { transform: rotateY(90deg); opacity: 0.3; }
            75% { transform: rotateY(150deg); opacity: 0.85; }
            100% { transform: rotateY(180deg); opacity: 1; }
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
            font-size: 24px;
            opacity: 1 !important;
            pointer-events: none;
            z-index: 1;
        }

        .top-left {
            top: 20px;
            left: 20px;
            animation: sparkle 1.8s ease-in-out infinite;
            color: #ff5722;
        }

        .top-right {
            top: 20px;
            right: 20px;
            animation: flip 3s linear infinite;
            transform-origin: center;
            color: inherit;
        }

        .bottom-left {
            bottom: 20px;
            left: 20px;
            color: #66ff33;
            text-shadow: 0 0 8px rgba(102, 255, 51, 0.7);
            animation: float 3s ease-in-out infinite;
        }

        .bottom-right {
            bottom: 20px;
            right: 20px;
            color: #f48fb1;
            text-shadow: 0 0 6px rgba(244, 143, 177, 0.6);
            animation: rotate 10s linear infinite;
        }

        h1 {
            font-family: 'Ma Shan Zheng', cursive;
            text-align: center;
            font-size: 3.2em;
            color: #d35400;
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

        .container {
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
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

        .footer-note {
            text-align: center;
            margin-top: 30px;
            color: #8b4513;
            font-size: 0.9em;
            font-family: 'Noto Sans SC', sans-serif;
        }

        @media (max-width: 768px) {
            h1 { font-size: 2.4em; }
            table { font-size: 14px; }
            th, td { padding: 10px 8px; }
            .corner-icon { font-size: 20px; }
        }
    </style>
</head>
<body>

<!-- 四角装饰图标 -->
<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div> <!-- 木叶标志 -->
<div class="corner-icon bottom-right">🍥</div>

<div class="container">
    <h1>📜 课程信息列表</h1>

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
                        <td><span class="badge">${course.credit} 学分</span></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <h3>暂无课程数据</h3>
                <p>当前数据库中没有课程记录，请联系管理员添加。</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="footer-note">
        <small>© 2026 教务管理系统 | 课程管理模块</small>
    </div>
</div>

</body>
</html>