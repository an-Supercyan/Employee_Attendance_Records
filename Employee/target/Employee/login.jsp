<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/17
  Time: 下午4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工考勤系统</title>
    <style>
        :root {
            --primary-100: #0077C2;
            --primary-200: #59a5f5;
            --primary-300: #c8ffff;
            --accent-100: #00BFFF;
            --accent-200: #00619a;
            --text-100: #333333;
            --text-200: #5c5c5c;
            --bg-100: #FFFFFF;
            --bg-200: #f5f5f5;
            --bg-300: #cccccc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, var(--bg-100), var(--bg-200), var(--primary-200), var(--accent-200));
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            perspective: 1000px;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            transform: rotateX(10deg);
            transition: all 0.5s ease;
        }

        .login-container:hover {
            transform: rotateX(0deg) scale(1.02);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--primary-100);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--bg-300);
            border-radius: 8px;
            background: var(--bg-100);
            color: var(--text-100);
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-100);
            box-shadow: 0 0 15px rgba(0, 119, 194, 0.2);
        }

        .form-group label {
            position: absolute;
            left: 12px;
            top: -8px;
            background: var(--bg-100);
            padding: 0 5px;
            color: var(--text-200);
            font-size: 0.8em;
            transition: all 0.3s ease;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, var(--primary-100), var(--primary-200));
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 119, 194, 0.3);
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link a {
            color: var(--primary-100);
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: var(--accent-100);
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>员工考勤登录</h2>
    <form action="<%=request.getContextPath()%>/Login" method="post">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="login-btn">登录</button>
        <div class="register-link">
            <a href="<%=request.getContextPath()%>/register.jsp">没有账号？立即注册</a>
        </div>
    </form>
</div>
</body>
</html>