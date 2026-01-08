<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>登录</title>

    <!-- 字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 4 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --naruto-red: #e63946;
            --naruto-orange: #ff6b35;
            --naruto-dark-blue: #1d3557;
            --naruto-light-beige: #f5e6d3;
            --naruto-brown: #5e452a;
            --naruto-shadow: rgba(0, 0, 0, 0.25);
        }

        body {
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--naruto-light-beige);
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(222, 184, 135, 0.1) 0%, transparent 20%),
                    radial-gradient(circle at 90% 80%, rgba(205, 133, 63, 0.1) 0%, transparent 20%);
            font-family: 'Noto Sans SC', "Microsoft YaHei", sans-serif;
            color: #3e2723;
            overflow-x: hidden;
            position: relative;
        }

        @keyframes sparkle { 0%,100% { text-shadow: 0 0 8px #ffeb3b,0 0 16px #ff9800,0 0 24px #f44336; opacity:1; } 50% { text-shadow: 0 0 12px #ffeb3b,0 0 24px #ff9800,0 0 36px #f44336,0 0 48px #e91e63; opacity:0.9; } }
        @keyframes flip { 0% { transform: rotateY(0); opacity:1; } 25% { transform: rotateY(30deg); opacity:0.85; } 50% { transform: rotateY(90deg); opacity:0.3; } 75% { transform: rotateY(150deg); opacity:0.85; } 100% { transform: rotateY(180deg); opacity:1; } }
        @keyframes float { 0%,100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
        @keyframes rotate { to { transform: rotate(360deg); } }

        .corner-icon {
            position: absolute;
            font-size: 24px;
            opacity: 1 !important;
            pointer-events: none;
            z-index: 1;
        }
        .top-left { top: 20px; left: 20px; animation: sparkle 1.8s ease-in-out infinite; color: #ff5722; }
        .top-right { top: 20px; right: 20px; animation: flip 3s linear infinite; transform-origin: center; }
        .bottom-left { bottom: 20px; left: 20px; color: #66ff33; text-shadow: 0 0 8px rgba(102,255,51,0.7); animation: float 3s ease-in-out infinite; }
        .bottom-right { bottom: 20px; right: 20px; color: #f48fb1; text-shadow: 0 0 6px rgba(244,143,177,0.6); animation: rotate 10s linear infinite; }

        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .card {
            width: 100%;
            max-width: 560px; /* ← 关键：左右拉伸！ */
            min-height: 420px;
            border: 2px solid var(--naruto-brown);
            border-radius: 12px;
            box-shadow: 0 6px 20px var(--naruto-shadow);
            background: rgba(255, 255, 255, 0.95);
        }

        .card-header {
            background: linear-gradient(135deg, var(--naruto-dark-blue), #2a3b55);
            color: white;
            padding: 1.2rem 0;
            text-align: center;
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 1.6rem;
            letter-spacing: 1.5px;
            text-shadow: 0 0 6px rgba(255,255,255,0.5);
            border-bottom: 2px solid var(--naruto-brown);
        }

        .form-control {
            border: 1px solid var(--naruto-brown);
            border-radius: 6px;
            padding: 0.6rem 1rem;
            font-size: 1.05rem;
            font-family: 'Noto Sans SC', sans-serif;
            width: 100%;
        }

        .form-control:focus {
            border-color: var(--naruto-orange);
            box-shadow: 0 0 0 0.2rem rgba(255,107,53,0.25);
        }

        .btn-primary {
            background: var(--naruto-orange);
            border: none;
            color: white;
            font-weight: bold;
            padding: 0.65rem;
            font-size: 1.15rem;
            transition: all 0.25s ease;
            border-radius: 6px;
            font-family: 'Noto Sans SC', sans-serif;
            width: 100%;
        }

        .btn-primary:hover {
            background: #e05a2c;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #3e2723;
        }

        .footer-text {
            margin-top: 1.2rem;
            font-size: 0.85rem;
            color: #666;
            text-align: center;
            font-family: 'Noto Sans SC', sans-serif;
        }
    </style>
</head>
<body>

<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div>
<div class="corner-icon bottom-right">🍥</div>

<div class="login-container">
    <div class="card">
        <div class="card-header">
            用户登录
        </div>
        <div class="card-body p-4">
            <form action="login" method="post">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" required>
                </div>
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required>
                </div>
                <button type="submit" class="btn btn-primary">登录</button>
            </form>
            <div class="footer-text">
                学生成绩管理系统
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>