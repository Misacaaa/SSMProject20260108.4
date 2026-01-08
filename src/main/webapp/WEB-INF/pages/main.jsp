<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>学生成绩管理系统 · 动漫版</title>
    <!-- Bootstrap 4 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 全局：动漫背景 */
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            background-image: url('https://cdn.pixabay.com/photo/2023/07/10/15/00/anime-8119003_1280.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Microsoft YaHei', 'Segoe UI Emoji', sans-serif;
            color: #333;
            overflow-x: hidden;
        }

        /* 毛玻璃遮罩层（提升文字可读性） */
        .glass-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            background: rgba(255, 255, 255, 0.75);
            z-index: -1;
        }

        /* 顶部导航栏 */
        .navbar {
            background: rgba(255, 255, 255, 0.85) !important;
            backdrop-filter: blur(4px);
            border-bottom: 2px solid #ffb6c1;
            padding: 0.5rem 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            color: #ff69b4 !important;
            font-weight: bold;
            font-size: 1.3rem;
        }
        .navbar .text-nowrap span {
            color: #5d4037;
            font-weight: 500;
        }
        .navbar .btn-outline-secondary {
            background-color: #e3f2fd;
            border: 1px solid #90caf9;
            color: #0288d1 !important;
            border-radius: 20px;
            padding: 0.2rem 0.8rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .navbar .btn-outline-secondary:hover {
            background-color: #bbdefb;
            transform: scale(1.05);
        }
        .navbar .btn-outline-secondary svg {
            color: #0288d1;
        }

        /* 侧边栏 */
        .sidebar {
            position: fixed;
            top: 56px;
            bottom: 0;
            left: 0;
            width: 230px;
            background: rgba(255, 248, 240, 0.92);
            backdrop-filter: blur(4px);
            border-right: 2px dashed #ffd1dc;
            overflow-y: auto;
            z-index: 1000;
            padding: 10px 0;
            border-radius: 0 16px 0 0;
            box-shadow: 2px 0 8px rgba(0,0,0,0.08);
        }

        /* 菜单项样式 */
        .list-group-item-action {
            background-color: transparent !important;
            border: none !important;
            color: #e91e63 !important;
            padding: 0.75rem 1.2rem;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.25s ease;
            border-radius: 12px !important;
            margin: 0.3rem 0.6rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .list-group-item-action:hover,
        .list-group-item-action:focus {
            color: #ffffff !important;
            background: linear-gradient(135deg, #ff9a9e, #fad0c4) !important;
            transform: translateX(6px);
            box-shadow: 0 3px 8px rgba(233, 30, 99, 0.2);
        }
        .list-group-item-action.active {
            color: white !important;
            background: linear-gradient(135deg, #a1887f, #d7ccc8) !important;
        }

        /* 二级菜单缩进 */
        .pl-4 {
            padding-left: 2rem !important;
        }

        /* 主内容区 */
        .main-content {
            margin-left: 230px;
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 12px;
        }
        #content-frame {
            flex: 1;
            border: none;
            width: 100%;
            background: white;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
            border: 2px solid #e0f7fa;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                top: 0;
                margin-top: 10px;
                height: auto;
                border-radius: 12px;
                border-right: none;
                border: 2px dashed #c8e6c9;
            }
            .main-content {
                margin-left: 0;
                padding: 8px;
            }
            #content-frame {
                height: calc(100vh - 180px);
            }
            .list-group-item-action {
                margin: 0.2rem 0.4rem;
            }
        }

        /* 自定义滚动条（可爱风格） */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #fff5f7;
        }
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(#ff9a9e, #fad0c4);
            border-radius: 10px;
        }
    </style>
</head>
<body>

<!-- 毛玻璃背景遮罩 -->
<div class="glass-overlay"></div>

<!-- 顶部 Header -->
<nav class="navbar navbar-expand-md navbar-light fixed-top">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h4">🌸 学生成绩管理系统</span>
        <div class="d-flex align-items-center text-nowrap">
            <span class="mr-2">欢迎你呀！<strong id="current-username">小樱</strong></span>
            <a href="javascript:void(0);"
               class="btn btn-sm btn-outline-secondary d-flex align-items-center"
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
        <a href="#" class="list-group-item list-group-item-action" data-url="pages/home.html">首页</a>

        <a href="#studentMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            🎒 学生管理 ▼
        </a>
        <div id="studentMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/studentList">学生列表</a>
        </div>

        <a href="#courseMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            📚 课程管理 ▼
        </a>
        <div id="courseMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/course/list">课程列表</a>
        </div>

        <a href="#scoreMenu" class="list-group-item list-group-item-action" data-toggle="collapse">
            📊 成绩管理 ▼
        </a>
        <div id="scoreMenu" class="collapse">
            <a href="#" class="list-group-item list-group-item-action pl-4" data-url="${pageContext.request.contextPath}/score/list">成绩列表</a>
        </div>

        <a href="#" class="list-group-item list-group-item-action" data-url="pages/settings.html">⚙️ 系统设置</a>
    </div>
</div>

<!-- 右侧内容区：使用 iframe -->
<main class="main-content">
    <iframe id="content-frame" src="${pageContext.request.contextPath}/home" title="主内容区"></iframe>
</main>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 可爱用户名（可从后端动态获取）
    const username = "小樱";
    document.getElementById("current-username").textContent = username;

    // 菜单点击事件（逻辑不变）
    document.querySelectorAll('.list-group-item[data-url]').forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const url = this.getAttribute('data-url');
            document.getElementById('content-frame').src = url;
        });
    });

    // 退出确认
    document.getElementById('logoutBtn').addEventListener('click', function() {
        if (confirm('要离开小樱了吗？(｡•́︿•̀｡)')) {
            window.location.href = 'login.html';
        }
    });
</script>

</body>
</html>