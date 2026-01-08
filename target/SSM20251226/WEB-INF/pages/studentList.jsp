<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息列表</title>

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
            50% { transform: rotateY(90deg); opacity: 0.3; }
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
            position: fixed;
            font-size: 24px;
            opacity: 1 !important;
            pointer-events: none;
            z-index: 9999;
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
            transform-origin: center;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
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

        /* 搜索区域样式 */
        .search-card {
            background: #fdf6ec;
            border: 6px solid #5d4037;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        .search-card input,
        .search-card .btn {
            border-radius: 20px;
            border: 2px solid #d7ccc8;
            padding: 8px 16px;
            font-family: 'Noto Sans SC', sans-serif;
            min-height: 42px; /* 👈 增加高度 */
        }

        .search-card .btn-primary {
            background-color: #27ae60;
            border-color: #219653;
            color: white;
        }

        .search-card .btn-primary:hover {
            background-color: #219653;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        .search-card .btn-secondary {
            background-color: #95a5a6;
            border-color: #7f8c8d;
            color: white;
        }

        .search-card .btn-secondary:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        .add-btn {
            background-color: #27ae60;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: bold;
            border: 2px solid #219653;
            position: absolute;
            top: 60px;
            right: 20px;
            transition: all 0.2s;
        }

        .add-btn:hover {
            background-color: #219653;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
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

        .no-data {
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

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin: 0 4px;
            text-decoration: none;
            border-radius: 18px;
            font-weight: bold;
            font-size: 14px;
            color: white;
            transition: all 0.2s;
            min-width: 50px;
            text-align: center;
        }

        .btn-edit {
            background-color: #3498db;
            border: 2px solid #2980b9;
        }

        .btn-edit:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        .btn-delete {
            background-color: #e74c3c;
            border: 2px solid #c0392b;
        }

        .btn-delete:hover {
            background-color: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        /* ========== 分页样式 ========== */
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

        .page-item {
            margin: 0;
        }

        .page-link {
            display: block;
            padding: 8px 14px;
            background: #fdf6ec;
            border: 2px solid #d35400;
            color: #d35400;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .page-link:hover:not(.disabled) {
            background: #d35400;
            color: white;
            transform: translateY(-2px);
        }

        .page-item.active .page-link {
            background: #d35400;
            color: white;
            border-color: #b03a2e;
        }

        .page-item.disabled .page-link {
            color: #aaa;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .pagination-info {
            margin-top: 12px;
            color: #8b4513;
            font-size: 0.95em;
        }

        /* ========== 自定义模态框 ========== */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            justify-content: center;
            align-items: flex-start;
            padding-top: 80px;
        }

        .modal-content {
            background: #fdf6ec;
            border: 6px solid #5d4037;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            width: 90%;
            max-width: 500px;
            padding: 25px;
            position: relative;
            font-family: 'Noto Sans SC', sans-serif;
        }

        .modal-title {
            margin-top: 0;
            color: #d35400;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px dashed #d35400;
            font-family: 'Ma Shan Zheng', cursive;
            letter-spacing: 2px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #5d4037;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 2px solid #d7ccc8;
            border-radius: 8px;
            font-size: 15px;
            background: #fffaf5;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #d35400;
            box-shadow: 0 0 0 3px rgba(211, 84, 0, 0.2);
        }

        .modal-buttons {
            text-align: center;
            margin-top: 20px;
        }

        .modal-buttons button {
            padding: 10px 24px;
            border: 2px solid transparent;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin: 0 8px;
            transition: all 0.2s;
        }

        .btn-confirm {
            background-color: #27ae60;
            color: white;
            border-color: #219653;
        }

        .btn-confirm:hover {
            background-color: #219653;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        .btn-cancel {
            background-color: #95a5a6;
            color: white;
            border-color: #7f8c8d;
        }

        .btn-cancel:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.2);
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 28px;
            color: #aaa;
            cursor: pointer;
            background: #f9f0e0;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #d35400;
        }

        .close-modal:hover {
            color: #c0392b;
            background: #ffe0b2;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2.4em;
            }
            .add-btn {
                top: 40px;
                right: 10px;
                padding: 8px 16px;
                font-size: 14px;
            }
            table {
                font-size: 14px;
            }
            th, td {
                padding: 10px 6px;
            }
            .corner-icon {
                font-size: 20px;
            }
            .page-link {
                padding: 6px 10px;
                font-size: 14px;
            }
            .search-card input,
            .search-card .btn {
                border-radius: 12px;
                padding: 6px 12px;
                font-size: 14px;
                min-height: 38px; /* 移动端稍小 */
            }
        }
    </style>
</head>
<body>

<!-- 四角动态图标 -->
<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div>
<div class="corner-icon bottom-right">🍥</div>

<div class="container">
    <h1>📜 学生信息列表</h1>

    <!-- 搜索表单 -->
    <div class="search-card">
        <form id="searchForm" method="get" action="${pageContext.request.contextPath}/studentList">
            <div style="display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 15px;">
                <input type="text" name="studentId" placeholder="学号"
                       value="${param.studentId != null ? param.studentId : ''}"
                       style="flex: 1; min-width: 120px;">
                <input type="text" name="name" placeholder="姓名"
                       value="${param.name != null ? param.name : ''}"
                       style="flex: 1; min-width: 120px;">
                <input type="text" name="email" placeholder="邮箱"
                       value="${param.email != null ? param.email : ''}"
                       style="flex: 1; min-width: 120px;">
            </div>
            <div style="text-align: center;">
                <button type="submit" class="btn btn-primary" style="margin-right: 10px;">🔍 搜索</button>
                <button type="button" class="btn btn-secondary" onclick="clearSearch()">↺ 重置</button>
            </div>
        </form>
    </div>

    <a href="javascript:void(0);" class="add-btn" onclick="openAddModal()">➕ 添加学生</a>

    <!-- 构造基础 URL（带搜索参数） -->
    <c:url var="baseUrl" value="/studentList">
        <c:param name="studentId" value="${param.studentId}" />
        <c:param name="name" value="${param.name}" />
        <c:param name="email" value="${param.email}" />
        <c:param name="pageSize" value="${pageInfo.pageSize}" />
    </c:url>

    <c:if test="${empty pageInfo.list}">
        <p class="no-data">⚠️ 暂无登记学生。</p>
    </c:if>

    <c:if test="${not empty pageInfo.list}">
        <table>
            <thead>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>出生日期</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="student">
                <tr>
                    <td>${student.studentId}</td>
                    <td>${student.name}</td>
                    <td>${student.gender}</td>
                    <td>
                        <c:if test="${not empty student.birthDate}">
                            <fmt:formatDate value="${student.birthDate}" pattern="yyyy-MM-dd"/>
                        </c:if>
                    </td>
                    <td>${student.phone}</td>
                    <td>${student.email}</td>
                    <td>
                        <a class="btn btn-edit" href="javascript:void(0)" onclick="editStudent('${student.studentId}')">✏️ 编辑</a>
                        <a class="btn btn-delete" href="javascript:void(0)" onclick="deleteStudent('${student.studentId}')">🗑️ 删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- ========== 分页 ========== -->
        <c:if test="${pageInfo.pages > 1}">
            <div class="pagination-container">
                <ul class="pagination">
                    <li class="page-item ${pageInfo.isFirstPage ? 'disabled' : ''}">
                        <a class="page-link" href="${baseUrl}&pageNum=1">首页</a>
                    </li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pageNum - 1}">«</a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasPreviousPage}">
                        <li class="page-item disabled">
                            <span class="page-link">«</span>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                        <c:choose>
                            <c:when test="${page == pageInfo.pageNum}">
                                <li class="page-item active">
                                    <span class="page-link">${page}</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="${baseUrl}&pageNum=${page}">${page}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pageNum + 1}">»</a>
                        </li>
                    </c:if>
                    <c:if test="${!pageInfo.hasNextPage}">
                        <li class="page-item disabled">
                            <span class="page-link">»</span>
                        </li>
                    </c:if>

                    <li class="page-item ${pageInfo.isLastPage ? 'disabled' : ''}">
                        <a class="page-link" href="${baseUrl}&pageNum=${pageInfo.pages}">末页</a>
                    </li>
                </ul>

                <div class="pagination-info">
                    共 ${pageInfo.total} 条记录，每页 ${pageInfo.pageSize} 条，共 ${pageInfo.pages} 页
                </div>
            </div>
        </c:if>
    </c:if>
</div>

<!-- ========== 新增模态框 ========== -->
<div id="addModalOverlay" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="closeModal()">&times;</span>
        <h2 class="modal-title">➕ 新增学生档案</h2>
        <form id="addStudentForm" onsubmit="submitAddForm(event)">
            <div class="form-group">
                <label for="studentId">学生编号 *</label>
                <input type="text" id="studentId" name="studentId" required>
            </div>
            <div class="form-group">
                <label for="name">姓名 *</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="gender">性别 *</label>
                <select id="gender" name="gender" required>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="form-group">
                <label for="birthDate">出生日期 *</label>
                <input type="date" id="birthDate" name="birthDate" required>
            </div>
            <div class="form-group">
                <label for="phone">联络方式</label>
                <input type="text" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email">
            </div>
            <div class="modal-buttons">
                <button type="submit" class="btn-confirm">确定登记</button>
                <button type="button" class="btn-cancel" onclick="closeModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<!-- ========== 编辑模态框 ========== -->
<div id="editModalOverlay" class="modal-overlay">
    <div class="modal-content">
        <span class="close-modal" onclick="closeEditModal()">&times;</span>
        <h2 class="modal-title">✏️ 编辑学生档案</h2>
        <form id="editStudentForm" onsubmit="submitEditForm(event)">
            <input type="hidden" id="edit-studentId" name="studentId">
            <div class="form-group">
                <label for="edit-name">姓名 *</label>
                <input type="text" id="edit-name" name="name" required>
            </div>
            <div class="form-group">
                <label for="edit-gender">性别 *</label>
                <select id="edit-gender" name="gender" required>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="form-group">
                <label for="edit-birthDate">出生日期 *</label>
                <input type="date" id="edit-birthDate" name="birthDate" required>
            </div>
            <div class="form-group">
                <label for="edit-phone">联络方式</label>
                <input type="text" id="edit-phone" name="phone">
            </div>
            <div class="form-group">
                <label for="edit-email">邮箱</label>
                <input type="email" id="edit-email" name="email">
            </div>
            <div class="modal-buttons">
                <button type="submit" class="btn-confirm">保存修改</button>
                <button type="button" class="btn-cancel" onclick="closeEditModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function openAddModal() {
        document.getElementById('addModalOverlay').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('addModalOverlay').style.display = 'none';
    }

    function closeEditModal() {
        document.getElementById('editModalOverlay').style.display = 'none';
    }

    function clearSearch() {
        document.querySelector('input[name="studentId"]').value = '';
        document.querySelector('input[name="name"]').value = '';
        document.querySelector('input[name="email"]').value = '';
        document.getElementById('searchForm').submit();
    }

    function editStudent(studentId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/getStudentInfoById",
            type: 'POST',
            dataType: 'json',
            data: { studentId: studentId },
            success: function(data) {
                if (data) {
                    $('#edit-studentId').val(data.studentId);
                    $('#edit-name').val(data.name);
                    $('#edit-gender').val(data.gender || '男');

                    let birthDate = '';
                    if (data.birthDate) {
                        const date = new Date(Number(data.birthDate));
                        const year = date.getFullYear();
                        const month = String(date.getMonth() + 1).padStart(2, '0');
                        const day = String(date.getDate()).padStart(2, '0');
                        birthDate = `${year}-${month}-${day}`;
                    }
                    $('#edit-birthDate').val(birthDate);
                    $('#edit-phone').val(data.phone || '');
                    $('#edit-email').val(data.email || '');

                    document.getElementById('editModalOverlay').style.display = 'flex';
                } else {
                    alert('未找到该学生信息！');
                }
            },
            error: function() {
                alert('获取学生信息失败，请重试。');
            }
        });
    }

    function submitAddForm(event) {
        event.preventDefault();
        const form = document.getElementById('addStudentForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/studentAdd', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams(formData)
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 学生登记成功！');
                    closeModal();
                    location.reload();
                } else {
                    alert('❌ 登记失败：' + (data.message || '未知错误'));
                }
            })
            .catch(err => {
                console.error(err);
                alert('网络错误，请稍后重试');
            });
    }

    function submitEditForm(event) {
        event.preventDefault();
        const form = document.getElementById('editStudentForm');
        const formData = new FormData(form);

        fetch('${pageContext.request.contextPath}/studentUpdate', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(Object.fromEntries(formData))
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 修改成功！');
                    closeEditModal();
                    location.reload();
                } else {
                    alert('❌ 修改失败：' + (data.message || '未知错误'));
                }
            })
            .catch(err => {
                console.error(err);
                alert('网络错误，请稍后重试');
            });
    }

    function deleteStudent(studentId) {
        if (!confirm('【警告】确定要将该学生从学生名册中除名吗？此操作不可逆！')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/studentDelete', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ 'studentId': studentId })
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 学生已成功移除！');
                    location.reload();
                } else {
                    alert('❌ 删除失败：' + (data.message || '未知错误'));
                }
            })
            .catch(err => {
                console.error(err);
                alert('网络错误，请稍后重试');
            });
    }
</script>

</body>
</html>