<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/20
  Time: 下午3:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <style>
        :root {
            --primary-color: #0077C2;
            --secondary-color: #f8f9fa;
            --accent-color: #34495e;
            --text-color: #2c3e50;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
            --input-bg: rgba(255, 255, 255, 0.9);
            --box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #59a5f5 0%, #0077C2 100%);
            position: relative;
        }

        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .registration-container {
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 40px;
            width: 400px;
            box-shadow: var(--box-shadow);
            animation: fadeIn 0.5s ease-out;
        }

        .form-title {
            color: var(--accent-color);
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid transparent;
            border-radius: 12px;
            background: var(--input-bg);
            color: var(--text-color);
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(0, 119, 194, 0.2);
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 119, 194, 0.2);
        }

        .submit-btn:hover {
            background: #005a94;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 119, 194, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .error-text {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 6px;
            padding-left: 12px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #005a94;
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        ::placeholder {
            color: #a0aec0;
        }
    </style>
</head>
<body>
<div id="particles-js"></div>
<div class="registration-container">
    <h2 class="form-title">用户注册</h2>

    <form id="registrationForm" action="<%=request.getContextPath()%>/Register" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <input
                    type="text"
                    id="username"
                    name="username"
                    class="form-input"
                    placeholder="用户名"
                    required
            >
            <div id="usernameError" class="error-text"></div>
        </div>

        <div class="form-group">
            <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-input"
                    placeholder="密码"
                    required
            >
            <div id="passwordError" class="error-text"></div>
        </div>

        <div class="form-group">
            <input
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    class="form-input"
                    placeholder="确认密码"
                    required
            >
            <div id="confirmPasswordError" class="error-text"></div>
        </div>

        <div class="form-group">
            <input
                    type="text"
                    id="employeeId"
                    name="employeeId"
                    class="form-input"
                    placeholder="邀请码"
                    required
            >
            <div id="employeeIdError" class="error-text"></div>
        </div>

        <button type="submit" class="submit-btn">注册</button>
        <div class="login-link">
            <a href="<%=request.getContextPath()%>/login.jsp">已有账号？立即登录</a>
        </div>
    </form>
</div>

<script>
    particlesJS('particles-js', {
        particles: {
            number: {
                value: 80,
                density: {
                    enable: true,
                    value_area: 800
                }
            },
            color: {
                value: '#ffffff'
            },
            shape: {
                type: 'circle'
            },
            opacity: {
                value: 0.5,
                random: false
            },
            size: {
                value: 3,
                random: true
            },
            line_linked: {
                enable: true,
                distance: 150,
                color: '#ffffff',
                opacity: 0.4,
                width: 1
            },
            move: {
                enable: true,
                speed: 2,
                direction: 'none',
                random: false,
                straight: false,
                out_mode: 'out',
                bounce: false
            }
        },
        interactivity: {
            detect_on: 'canvas',
            events: {
                onhover: {
                    enable: true,
                    mode: 'repulse'
                },
                onclick: {
                    enable: true,
                    mode: 'push'
                },
                resize: true
            }
        },
        retina_detect: true
    });

    function validateForm() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const employeeId = document.getElementById('employeeId').value;
        let isValid = true;

        // Reset previous error messages
        document.getElementById('passwordError').textContent = '';
        document.getElementById('confirmPasswordError').textContent = '';
        document.getElementById('employeeIdError').textContent = '';

        // Password matching validation
        if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').textContent = '两次输入的密码不一致';
            Swal.fire({
                icon: 'warning',
                title: '密码不匹配',
                text: '请确保两次输入的密码相同',
                background: '#fff',
                confirmButtonColor: '#0077C2'
            });
            isValid = false;
        }

        // Employee ID validation
        if (!/^\d{6}$/.test(employeeId)) {
            document.getElementById('employeeIdError').textContent = '邀请码必须为6位';
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>
