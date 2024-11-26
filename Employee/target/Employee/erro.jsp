<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/23
  Time: 上午11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>资源访问错误</title>
    <style>
        :root {
            --primary-blue: #1890FF;
            --error-red: #FF4D4F;
            --bg-light-blue: #F0F4F8;
            --text-gray: #666666;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', 'Arial', sans-serif;
            background-color: var(--bg-light-blue);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            line-height: 1.6;
        }

        .error-container {
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 12px 36px rgba(0, 0, 0, 0.08);
            padding: 40px;
            width: 100%;
            max-width: 480px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .error-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 20px;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23FF4D4F"><path d="M12 2L1 22h22L12 2zm1 18h-2v-2h2v2zm0-4h-2V8h2v8z"/></svg>') no-repeat center;
            background-size: contain;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .error-title {
            color: var(--error-red);
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .error-description {
            color: var(--text-gray);
            margin-bottom: 25px;
            font-size: 16px;
        }

        .admin-guidance {
            background-color: #FFF1F0;
            border-left: 5px solid var(--error-red);
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
            border-radius: 4px;
        }

        .guidance-title {
            color: var(--error-red);
            font-weight: 600;
            margin-bottom: 10px;
        }

        .guidance-list {
            padding-left: 20px;
            color: var(--text-gray);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .return-btn {
            background-color: var(--primary-blue);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: 500;
        }

        .return-btn:hover {
            background-color: #40A9FF;
        }

        .countdown-timer {
            margin-top: 20px;
            color: var(--text-gray);
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon"></div>

    <h1 class="error-title">资源访问错误</h1>

    <p class="error-description">
        您尝试访问的资源无法找到或已被移除。系统无法处理您的请求。
    </p>

    <div class="admin-guidance">
        <div class="guidance-title">管理员指导</div>
        <ul class="guidance-list">
            <li>记录访问时间</li>
            <li>标注具体访问页面</li>
            <li>描述错误详细情况</li>
        </ul>
    </div>

    <div class="action-buttons">
        <button onclick="returnToIndex()" class="return-btn">
            返回登录页面
        </button>
    </div>

    <div id="countdown" class="countdown-timer">
        页面将在 5 秒后自动跳转
    </div>
</div>

<script>
    let seconds = 5;
    const countdownEl = document.getElementById('countdown');

    function updateCountdown() {
        countdownEl.textContent = `页面将在`+ seconds + `秒后自动跳转`;

        if (seconds > 0) {
            seconds--;
            setTimeout(updateCountdown, 1000);
        } else {
            returnToIndex();
        }
    }

    function returnToIndex() {
        window.location.href = 'login.jsp';
    }

    updateCountdown();
</script>
</body>
</html>