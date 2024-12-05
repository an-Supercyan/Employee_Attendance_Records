<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/18
  Time: 下午4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录错误</title>
    <style>
        :root {
            --primary-100:#d90429;
            --primary-200:#ff98aa;
            --primary-300:#fdf6fd;
            --accent-100:#ffadad;
            --accent-200:#ffd6a5;
            --text-100:#4b4f5d;
            --text-200:#6a738b;
            --bg-100:#edf2f4;
            --bg-200:#d9dee4;
            --bg-300:#bfc7d1;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: var(--bg-200);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: var(--text-100);
        }

        .error-container {
            background-color: var(--bg-100);
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 90%;
        }

        .error-icon {
            font-size: 72px;
            color: var(--primary-100);
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 24px;
            color: var(--primary-200);
            margin-bottom: 15px;
        }

        .error-message {
            font-size: 16px;
            color: var(--text-200);
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .retry-button {
            background-color: var(--primary-100);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .retry-button:hover {
            background-color: var(--primary-200);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">⚠️</div>
    <h1 class="error-title">登录失败</h1>
    <p class="error-message">
        您输入的用户名或密码不正确。请检查您的凭据并尝试重新登录。
    </p>
    <a href="<%=request.getContextPath()%>/login.jsp" class="retry-button">重新登录</a>
</div>
</body>
</html>
