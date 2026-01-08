<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>学生成绩管理系统</title>

    <!-- 字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 4 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* === 全局变量 === */
        :root {
            --sidebar-width: 360px;
            --naruto-red: #e63946;
            --naruto-orange: #ff6b35;
            --naruto-dark-blue: #1d3557;
            --naruto-light-beige: #f5e6d3;
            --naruto-brown: #5e452a;
            --naruto-shadow: rgba(0, 0, 0, 0.25);
        }

        body {
            padding-top: 56px;
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: var(--naruto-light-beige);
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(222, 184, 135, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 90% 80%, rgba(205, 133, 63, 0.1) 0%, transparent 20%);
            font-family: 'Noto Sans SC', "Microsoft YaHei", sans-serif;
            color: #3e2723;
        }

        /* === 顶部导航栏 === */
        .navbar {
            background: linear-gradient(135deg, #2a3b55, var(--naruto-dark-blue)) !important;
            box-shadow: 0 4px 10px var(--naruto-shadow);
            position: fixed !important;
            width: 100%;
            z-index: 1030;
        }
        .navbar-brand {
            color: white !important;
            font-weight: bold;
            letter-spacing: 1.5px;
            text-shadow: 0 0 6px rgba(255, 255, 255, 0.5);
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 1.4rem;
        }
        .navbar-brand::before {
            content: "🍥";
            margin-right: 6px;
        }

        .navbar .d-flex span {
            color: #f1faee !important;
            font-weight: 500;
            font-family: 'Noto Sans SC', sans-serif;
        }

        #logoutBtn {
            background: var(--naruto-orange) !important;
            border: none !important;
            color: white !important;
            font-weight: bold;
            padding: 0.375rem 0.75rem !important;
            transition: all 0.2s ease;
            font-family: 'Noto Sans SC', sans-serif;
            font-size: 0.95rem;
        }
        #logoutBtn:hover {
            background: #e05a2c !important;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.3);
        }

        /* === 左侧菜单 === */
        .sidebar {
            position: fixed;
            top: 56px;
            bottom: 0;
            left: 0;
            width: var(--sidebar-width);
            background: var(--naruto-light-beige);
            border-right: 2px solid var(--naruto-brown);
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 3px 0 8px var(--naruto-shadow);
            padding: 150px 0;
            font-family: 'Noto Sans SC', sans-serif;
        }

        /* 一级菜单（可折叠项） */
        .list-group-item[data-toggle="collapse"] {
            background: linear-gradient(to right, #f0e0c9, #e8d5b5) !important;
            border: 1px solid var(--naruto-brown) !important;
            border-radius: 6px !important;
            margin: 12px 12px !important;
            font-weight: bold;
            color: var(--naruto-brown) !important;
            position: relative;
            transition: all 0.25s ease;
            font-size: 1rem;
            text-align: center;
            padding-right: 40px;
        }
        .list-group-item[data-toggle="collapse"]::after {
            content: "▼";
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--naruto-red);
            font-size: 12px;
            transition: transform 0.3s ease;
            font-family: sans-serif;
        }
        .list-group-item[aria-expanded="true"]::after {
            transform: translateY(-50%) rotate(180deg);
        }
        .list-group-item[data-toggle="collapse"]:hover {
            background: linear-gradient(to right, #e8d5b5, #dfd0a8) !important;
            color: var(--naruto-red) !important;
            box-shadow: 0 2px 5px rgba(0,0,0,0.15);
        }

        /* 二级菜单项 */
        .collapse > .list-group-item {
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="200" height="40" viewBox="0 0 200 40"><rect width="200" height="40" fill="%23f5e6d3" stroke="%235e452a" stroke-width="1"/><path d="M0,10 L200,10 M0,30 L200,30" stroke="%235e452a" stroke-width="0.5" opacity="0.3"/></svg>') repeat-x,
            var(--naruto-light-beige) !important;
            border: none !important;
            padding-left: 32px !important;
            color: #3e2723 !important;
            font-size: 0.95rem;
            position: relative;
        }

        .collapse > .list-group-item:hover {
            background: linear-gradient(to right, #f0e6d4, #e8dcbf) !important;
            color: var(--naruto-red) !important;
            transform: translateX(5px);
        }

        /* 无子菜单项（如首页、系统设置）—— 居中对齐 */
        .list-group-item[data-url]:not([data-toggle]) {
            background: transparent !important;
            border: none !important;
            padding: 0.375rem 0 !important;
            margin: 12px auto !important; /* ← 关键：左右自动居中 */
            color: #3e2723 !important;
            font-weight: bold;
            font-family: 'Noto Sans SC', sans-serif;
            border-radius: 6px;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            width: calc(100% - 24px);
            max-width: 300px; /* 避免在宽屏下过宽 */
            box-sizing: border-box;
            text-align: center !important;
        }
        .list-group-item[data-url]:not([data-toggle]):hover {
            color: var(--naruto-red) !important;
            background: rgba(230, 57, 70, 0.08) !important;
        }

        /* === 主内容区 === */
        .main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        #content-frame {
            flex: 1;
            border: none;
            width: 100%;
            background-color: white;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.05);
        }

        /* === 响应式适配 === */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                margin-top: 10px;
                height: auto;
                border-right: none;
                border-bottom: 2px solid var(--naruto-brown);
                padding: 25px 0;
            }
            .main-content {
                margin-left: 0;
            }
            #content-frame {
                height: calc(100vh - 180px);
            }
            .list-group-item[data-toggle="collapse"],
            .list-group-item[data-url]:not([data-toggle]) {
                margin: 8px auto !important;
                font-size: 0.95rem;
                width: calc(100% - 20px);
            }
        }
    </style>
</head>
<body>

<!-- 顶部 Header -->
<nav class="navbar navbar-expand-md navbar-light bg-light fixed-top">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h4">学生成绩管理系统</span>
        <div class="d-flex align-items-center text-nowrap">
            <span class="mr-2">欢迎您！<strong id="current-username"></strong></span>
            <a href="javascript:void(0);"
               class="btn btn-sm"
               id="logoutBtn"
               title="退出登录">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-box-arrow-right mr-1" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                </svg>
                退出
            </a>
        </div>
    </div>
</nav>

<!-- 左侧菜单栏 -->
<div class="sidebar">
    <div class="list-group list-group-flush">
        <!-- 首页：居中对齐 -->
        <a href="#" class="list-group-item list-group-item-action" data-url="${pageContext.request.contextPath}/home">🏠首页</a>

        <a href="#studentMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            🎒学生管理
        </a>
        <div id="studentMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/studentList">学生列表</a>
        </div>

        <a href="#courseMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            📚课程管理
        </a>
        <div id="courseMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/course/list">课程列表</a>
        </div>

        <a href="#scoreMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            📊成绩管理
        </a>
        <div id="scoreMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/score/list">成绩列表</a>
        </div>

        <!-- 系统设置：同样居中 -->
        <a href="#" class="list-group-item list-group-item-action" data-url="pages/settings.html">⚙️系统设置</a>
    </div>
</div>

<!-- 右侧内容区 -->
<main class="main-content">
    <iframe id="content-frame" src="${pageContext.request.contextPath}/home" title="主内容区"></iframe>
</main>

<!-- JS 依赖 -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const username = ""; // 实际项目中应从后端获取
    document.getElementById("current-username").textContent = username;

    document.querySelectorAll('.list-group-item[data-url]').forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const url = this.getAttribute('data-url');
            document.getElementById('content-frame').src = url;
        });
    });

    document.getElementById('logoutBtn').addEventListener('click', function() {
        if (confirm('确定要退出系统吗？')) {
            window.location.href = 'login.html';
        }
    });
</script>

</body>
</html>