<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World - </title>

    <!-- 引入新字体：Black Ops One -->
    <link href="https://fonts.googleapis.com/css2?family=Black+Ops+One&family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">

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

        .container {
            max-width: 800px;
            margin: 60px auto;
            text-align: center;
            position: relative;
            z-index: 2;
            background: #fdf6ec;
            padding: 40px;
            border: 8px solid #5d4037;
            border-radius: 16px;
            box-shadow:
                    0 8px 20px rgba(0,0,0,0.4),
                    inset 0 0 12px rgba(161, 102, 45, 0.3);
        }

        /* ✨ 关键修改：Hello World 使用 Black Ops One 字体 */
        h2 {
            font-family: 'Black Ops One', cursive; /* ←←← 这里改了！ */
            font-size: 3.6em;
            color: #d35400;
            text-shadow:
                    2px 2px 0 #000,
                    4px 4px 0 rgba(0,0,0,0.2),
                    0 0 12px rgba(211, 84, 0, 0.6);
            letter-spacing: 4px;
            margin-bottom: 20px;
            position: relative;
        }

        h2::after {
            content: "";
            display: block;
            width: 160px;
            height: 6px;
            background: linear-gradient(to right, #d35400, #c0392b, #8b4513);
            margin: 16px auto;
            border-radius: 3px;
        }

        .footer-note {
            margin-top: 30px;
            color: #8b4513;
            font-size: 0.95em;
            font-family: 'Noto Sans SC', sans-serif;
        }

        @media (max-width: 768px) {
            h2 { font-size: 2.6em; letter-spacing: 2px; }
            .container { padding: 25px 15px; margin: 40px 10px; }
            .corner-icon { font-size: 20px; }
        }
    </style>
</head>
<body>

<!-- 四角装饰图标 -->
<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div>
<div class="corner-icon bottom-right">🍥</div>

<div class="container">
    <h2><%= "Hello World!" %></h2>
    <div class="footer-note">
        <small></small>
    </div>
</div>

</body>
</html>