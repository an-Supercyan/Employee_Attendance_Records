<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/29
  Time: 下午4:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>账户注销确认</title>
    <style>
        /* Base styles */
        :root {
            --primary-blue: #4299e1;
            --primary-blue-dark: #2b6cb0;
            --danger-red: #e53e3e;
            --danger-red-dark: #c53030;
            --gray-light: #e2e8f0;
            --gray-medium: #718096;
            --gray-dark: #4a5568;
            --text-primary: #2c5282;
        }

        /* Container and card styles */
        .container {
            min-height: 100vh;
            background: linear-gradient(135deg, #e6f3ff 0%, #ffffff 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            padding: 1rem;
        }

        .logout-card {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeIn 0.6s ease forwards;
        }

        /* Form styles */
        .form-group {
            margin-bottom: 2rem;
            text-align: center;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
            font-weight: 500;
            font-size: 1.1rem;
        }

        .form-control {
            width: 90%;
            padding: 1rem;
            border: 2px solid var(--gray-light);
            border-radius: 12px;
            transition: all 0.3s ease;
            font-size: 1rem;
            text-align: center;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(66, 153, 225, 0.15);
            outline: none;
            transform: scale(1.02);
        }

        /* Button styles */
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .btn-confirm {
            background-color: var(--primary-blue);
            color: white;
            width: 90%;
            margin: 0 auto;
            display: block;
        }

        .btn-confirm:hover {
            background-color: var(--primary-blue-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(66, 153, 225, 0.3);
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            justify-content: center;
            align-items: center;
            z-index: 1000;
            backdrop-filter: blur(4px);
        }

        .modal-content {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            max-width: 450px;
            width: 90%;
            text-align: center;
            animation: slideIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .modal-title {
            color: var(--danger-red);
            margin-bottom: 1.5rem;
            font-size: 1.75rem;
            font-weight: 600;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .btn-yes, .btn-no {
            min-width: 120px;
        }

        .btn-yes {
            background-color: var(--danger-red);
            color: white;
        }

        .btn-yes:hover {
            background-color: var(--danger-red-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(229, 62, 62, 0.3);
        }

        .btn-no {
            background-color: var(--gray-medium);
            color: white;
        }

        .btn-no:hover {
            background-color: var(--gray-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(113, 128, 150, 0.3);
        }

        /* Error message styles */
        .error-message {
            color: var(--danger-red);
            font-size: 0.9rem;
            margin-top: 0.75rem;
            display: none;
            animation: shake 0.4s ease-in-out;
        }

        /* Animations */
        @keyframes fadeIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-30px) scale(0.95);
                opacity: 0;
            }
            to {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logout-card">
        <form id="logoutForm"  style="display: none;">
            <h2 style="color: #2c5282; margin-bottom: 2.5rem; text-align: center; font-size: 1.75rem;">
                账户注销确认
            </h2>
            <div class="form-group">
                <input type="text" id="username" name="username" class="form-control"
                       placeholder="输入用户名" required>
                <div id="usernameError" class="error-message">请输入有效的用户名</div>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="输入密码" required>
                <div id="passwordError" class="error-message">请输入正确的密码</div>
            </div>
            <button type="submit" class="btn btn-confirm">确认注销账户</button>
        </form>
    </div>
</div>

<!-- 注销确认弹窗 -->
<div id="logoutModal" class="modal">
    <div class="modal-content">
        <h3 class="modal-title">注销确认</h3>
        <p style="font-size: 1.1rem; line-height: 1.6; color: #4a5568;">
            您确定要注销账户吗？<br>
            注销后数据将无法恢复。
        </p>
        <div class="modal-buttons">
            <button id="btnYes" class="btn btn-yes">确认注销</button>
            <button id="btnNo" class="btn btn-no">取消</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const modal = document.getElementById('logoutModal');
        const logoutForm = document.getElementById('logoutForm');
        const username = document.getElementById('username');
        const password = document.getElementById('password');
        const usernameError = document.getElementById('usernameError');
        const passwordError = document.getElementById('passwordError');

        // 中文 输入框提示
        modal.style.display = 'flex';
        modal.style.opacity = '0';
        requestAnimationFrame(() => {
            modal.style.opacity = '1';
            modal.style.transition = 'opacity 0.3s ease';
        });

        // 点击否按钮时，关闭弹窗并跳转到首页
        document.getElementById('btnNo').addEventListener('click', function() {
            modal.style.opacity = '0';
            setTimeout(() => {
                window.location.href = 'index.jsp';
            }, 300);
        });

        // 点击是按钮时，关闭弹窗并显示注销表单
        document.getElementById('btnYes').addEventListener('click', function() {
            modal.style.opacity = '0';
            setTimeout(() => {
                modal.style.display = 'none';
                logoutForm.style.display = 'block';
                logoutForm.style.opacity = '0';
                requestAnimationFrame(() => {
                    logoutForm.style.opacity = '1';
                    logoutForm.style.transition = 'opacity 0.3s ease';
                });
            }, 300);
        });

        // 判断表单数据合法性
        logoutForm.addEventListener('submit', function(e) {
            let isValid = true;

            // 重置错误提示
            [usernameError, passwordError].forEach(error => {
                error.style.display = 'none';
            });

            // 用户名合法
            if (!username.value.trim()) {
                usernameError.style.display = 'block';
                username.classList.add('error');
                isValid = false;
            }

            // 当前密码合法
            if (!password.value.trim()) {
                passwordError.style.display = 'block';
                password.classList.add('error');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
                // Shake animation for invalid fields
                const invalidInputs = document.querySelectorAll('.error');
                invalidInputs.forEach(input => {
                    input.style.animation = 'none';
                    requestAnimationFrame(() => {
                        input.style.animation = 'shake 0.4s ease-in-out';
                    });
                });
            }
        });

        // 输入框获得焦点时，放大输入框
        [username, password].forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('error');
                const errorElement = document.getElementById(this.id + 'Error');
                if (errorElement) {
                    errorElement.style.display = 'none';
                }
            });

            input.addEventListener('focus', function() {
                this.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.style.transform = 'scale(1)';
            });
        });
    });

    //axios异步请求LogoutServlet发送POST表单，返回值为1时注销成功，跳转到Login页面，返回值为0时注销失败弹出弹窗提醒用户输入用户名或密码错误
    document.querySelector('#logoutForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = {
            username: document.querySelector('#username').value,
            password: document.querySelector('#password').value
        };
        axios.post('/Employee_war_exploded/Logout', formData)
            .then(response => {
                if (response.data === 1) {
                    //弹出注销成功弹窗后两秒返回登录页面
                    alert('注销成功，两秒后返回登录页面');
                    setTimeout(function () {
                        window.location.href = 'index.jsp';
                    }, 2000);
                } else {
                    alert('用户名或密码错误');
                }
            })
            .catch(error => {
                console.error(error);
            });
    });
</script>
</body>
</html>
