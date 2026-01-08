<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生成绩管理系统</title>

    <!-- 引入字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Ma+Shan+Zheng&family=Noto+Sans+SC:wght@400;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans SC', sans-serif;
            background-color: #f0e0c9; /* 更暖的卷轴底色 */
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(160, 120, 90, 0.08) 0%, transparent 25%),
                    radial-gradient(circle at 90% 80%, rgba(139, 69, 19, 0.06) 0%, transparent 25%);
            color: #3e2723;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
            padding: 20px;
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

        /* ========== 四角图标 ========== */
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

        /* ========== 卷轴容器 —— 火影风格 ========== */
        .scroll-container {
            position: relative;
            background: #e8d9c5 url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><rect width="100" height="100" fill="%23e8d9c5"/><path d="M0,0 L100,100 M100,0 L0,100" stroke="%23d0b8a0" stroke-width="0.5" opacity="0.3"/></svg>');
            border: 3px solid #5d4037;
            border-radius: 6px;
            padding: 40px 80px; /* ← 左右增加内边距 */
            max-width: 800px;   /* ← 扩大最大宽度 */
            width: 100%;
            text-align: center;
            box-shadow:
                    0 10px 25px rgba(0, 0, 0, 0.25),
                    inset 0 0 12px rgba(93, 64, 55, 0.15);
            z-index: 20;
            backdrop-filter: blur(2px);
        }

        .scroll-container::before {
            content: "";
            position: absolute;
            left: -25px;
            top: 50%;
            transform: translateY(-50%);
            width: 50px;
            height: 120%;
            background: linear-gradient(to right,
            #4e342e,
            #6d4c41 30%,
            #8d6e63 50%,
            #6d4c41 70%,
            #4e342e);
            border-radius: 5px;
            box-shadow:
                    -4px 0 8px rgba(0,0,0,0.3),
                    inset 0 0 6px rgba(0,0,0,0.4);
            z-index: -1;
        }

        .scroll-container::after {
            content: "";
            position: absolute;
            right: -25px;
            top: 50%;
            transform: translateY(-50%);
            width: 50px;
            height: 120%;
            background: linear-gradient(to left,
            #4e342e,
            #6d4c41 30%,
            #8d6e63 50%,
            #6d4c41 70%,
            #4e342e);
            border-radius: 5px;
            box-shadow:
                    4px 0 8px rgba(0,0,0,0.3),
                    inset 0 0 6px rgba(0,0,0,0.4);
            z-index: -1;
        }

        .scroll-content h1 {
            font-family: 'Ma Shan Zheng', cursive;
            font-size: 2.2em;       /* ← 适当缩小字体 */
            color: #c62828;
            text-shadow:
                    1px 1px 0 #000,
                    2px 2px 0 rgba(0,0,0,0.2);
            margin-bottom: 20px;
            letter-spacing: 2px;
            line-height: 1.3;
            white-space: normal;    /* ← 允许换行，避免截断 */
            overflow: visible;
            text-overflow: clip;    /* ← 确保不出现 ... */
        }

        .scroll-content h1::after {
            content: "";
            display: block;
            width: 120px;
            height: 3px;
            background: linear-gradient(to right, #c62828, #d32f2f, #b71c1c);
            margin: 12px auto;
            border-radius: 2px;
        }

        .scroll-content .welcome-message {
            font-size: 1.3em;
            color: #5d4037;
            line-height: 1.6;
            margin-top: 10px;
        }

        .scroll-content .footer-note {
            margin-top: 25px;
            color: #795548;
            font-size: 0.85em;
        }

        /* 响应式优化 */
        @media (max-width: 768px) {
            .scroll-container {
                padding: 30px 40px;
                max-width: 90%;
            }
            .scroll-content h1 {
                font-size: 1.6em;
                letter-spacing: 1px;
                line-height: 1.4;
            }
            .scroll-content .welcome-message {
                font-size: 1.1em;
            }
            .corner-icon {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

<!-- 四角装饰图标 -->
<div class="corner-icon top-left">🔥</div>
<div class="corner-icon top-right">📖</div>
<div class="corner-icon bottom-left">🍃</div>
<div class="corner-icon bottom-right">🍥</div>

<!-- 居中卷轴 -->
<div class="scroll-container">
    <div class="scroll-content">
        <h1>欢迎您来到学生成绩管理系统！</h1>
        <div class="welcome-message">
            <p>在这里，您可以管理所有学生的成绩记录。</p>
        </div>
        <div class="footer-note">
            <small>© 2026 学生成绩管理系统 | 版本号：v1.0.0</small>
        </div>
    </div>
</div>

</body>
</html>