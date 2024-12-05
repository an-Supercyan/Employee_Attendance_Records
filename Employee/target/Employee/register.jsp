<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/20
  Time: 下午3:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
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

    <form id="registrationForm" onsubmit="return validateForm()">
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
                    id="secretKeyId"
                    name="secretKeyId"
                    class="form-input"
                    placeholder="邀请码(可以选择不填)"
            >
            <div id="secretKeyIdError" class="error-text"></div>
        </div>

        <button type="submit" class="submit-btn">注册</button>
        <div class="login-link">
            <a href="<%=request.getContextPath()%>/login.jsp">已有账号？立即登录</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const secretKeyId = document.getElementById('secretKeyId').value;
        let isValid = true;

        //各信息合法性校验
        document.getElementById('passwordError').textContent = '';
        document.getElementById('confirmPasswordError').textContent = '';
        document.getElementById('secretKeyIdError').textContent = '';

        //用户名只能使用中英文字符或者. _-
        if (!/^[a-zA-Z0-9._-]+$/.test(username)) {
            document.getElementById('usernameError').textContent = '用户名只能使用中英文字符或者. _-';
            Swal.fire({
                icon: 'warning',
                title: '用户名格式错误',
                text: '用户名只能使用中英文字符或者. _-',
                background: '#fff',
                confirmButtonColor: '#0077C2'
            });
            isValid= false;
        }

        //用户名长度必须大于等于4
        if (username.length < 4) {
            document.getElementById('usernameError').textContent = '用户名长度必须大于4';
            Swal.fire({
                icon: 'warning',
                title: '用户名长度错误',
                text: '用户名长度必须大于等于4',
                background: '#fff',
                confirmButtonColor: '#0077C2'
            });
            isValid = false;
        }

        // 确认密码
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
        //密码只能使用数字与字母以及._-共同进行组合
        if (!/^[a-zA-Z0-9._-]+$/.test(password)) {
            document.getElementById('passwordError').textContent = '密码只能使用数字与字母以及._-共同进行组合';
            Swal.fire({
                icon: 'warning',
                title: '密码格式错误',
                text: '密码只能使用包含数字与字母以及._-的组合',
                background: '#fff',
                confirmButtonColor: '#0077C2'
            });
            isValid = false;
        }

        //密码长度规定
        if (password.length < 6) {
            document.getElementById('passwordError').textContent = '密码长度至少为6位';
            Swal.fire({
                icon: 'warning',
                title: '密码长度不足',
                text: '密码长度至少为6位',
                background: '#fff',
            })
            isValid = false;
        }

        // 邀请码合法校验(可以不填写)邀请码必须为7位数字与字母的组合
        if (secretKeyId !== '') {
            if (!/^[a-zA-Z0-9]{7}$/.test(secretKeyId)) {
                document.getElementById('secretKeyIdError').textContent = '邀请码必须为7位数字与字母的组合';
                Swal.fire({
                    icon: 'warning',
                    title: '邀请码格式错误',
                    text: '邀请码必须为7位数字与字母的组合',
                    background: '#fff',
                    confirmButtonColor: '#0077C2'
                })
            }
        }
        return isValid;
    }

    //若isValid为false则阻止表单提交
    document.getElementById('registrationForm').addEventListener('submit', function (event) {
        if (!validateForm()) {
            event.preventDefault();
        }
    });

    // 使用axios异步提交表单(注册失败则返回状态码0，注册成功则返回状态码 1:表示管理员 或 2:表示普通员工)
    const form = document.getElementById('registrationForm');
    form.addEventListener('submit', function (event) {
        event.preventDefault();
        if (validateForm()) {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const secretKeyId = document.getElementById('secretKeyId').value;
            if (typeof Swal === 'undefined') {
                console.error('Swal未定义');
                return;
            }
            axios.post('/Employee_war_exploded/Register', {
                userName: username,
                passWord: password,
                secretKeyId: secretKeyId
            }).then(function (response) {
                if (response.data > 0) {
                    Swal.fire({
                        icon: 'success',
                        title: '注册成功',
                        text: response.data === 1 ? '欢迎您成为本公司系统维护者' : '欢迎您未来为本公司作出杰出贡献',
                        background: '#fff',
                        confirmButtonColor: '#0077C2'
                    }).then(function () {
                        window.location.href ='login.jsp';
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '注册失败,您未拥有注册权限',
                       text: response.data.message,
                    })
                }
                })
                .catch(function (error) {
                    console.log(error);
                });
        }
    });
</script>
</body>
</html>
