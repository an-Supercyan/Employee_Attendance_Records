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
        /*配色*/
        :root {
            --primary-gradient: linear-gradient(135deg, #4686e5 0%, #5eaeff 100%);
            --primary-blue: #4299e1;
            --primary-blue-dark: #2b6cb0;
            --danger-red: #e53e3e;
            --danger-red-dark: #c53030;
            --gray-light: #e2e8f0;
            --gray-medium: #718096;
            --gray-dark: #4a5568;
            --text-primary: #2c5282;
        }

        /*容器卡片样式*/
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

        /*表单样式*/
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

        /*确认注销按钮样式*/
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

        /*悬浮窗样式*/
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

        /*错误信息样式*/
        .error-message {
            color: var(--danger-red);
            font-size: 0.9rem;
            margin-top: 0.75rem;
            display: none;
            animation: shake 0.4s ease-in-out;
        }

        /*返回按钮样式*/
        .return-button {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            padding: 1rem 2rem;
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            z-index: 100;
        }

        .return-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
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
<button onclick="window.location.href='index.jsp'" class="return-button">
    返回主页
</button>
<div class="container">
    <div class="logout-card">
        <form id="logoutForm"  style="display: none;">
            <h2 style="color: #2c5282; margin-bottom: 2.5rem; text-align: center; font-size: 1.75rem;">
                账户注销确认
            </h2>
            <div class="form-group">
                <input type="text" id="userName" name="userName" class="form-control"
                                                     placeholder="输入用户名" required>
                <div id="usernameError" class="error-message">请输入有效的用户名</div>
            </div>
            <div class="form-group">
                <input type="password" id="passWord" name="passWord" class="form-control"
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
    //点击确认注销弹窗的确认按钮提交表单时用户名和密码不能为空，若为空则提示
    document.getElementById("logoutForm").addEventListener("submit", function (event) {
        event.preventDefault();
        var userName = document.getElementById("userName").value;
        var passWord = document.getElementById("passWord").value;
        if (userName === "" || passWord === "") {
            // 显示错误信息
            document.getElementById("usernameError").style.display = "block";
            document.getElementById("passwordError").style.display = "block";
        } else {
            // 隐藏错误信息
            document.getElementById("usernameError").style.display = "none";
            document.getElementById("passwordError").style.display = "none";
            //使用axios异步提交表单
            //格式化表单数据为json格式
            const formData = new FormData(this);
            //将表单数据转为json
            const jsonData = Object.fromEntries(formData.entries());
            formData.append('jsonData', JSON.stringify(jsonData));
            console.log(jsonData);
            //如果表单合法则使用axios的Post请求方式异步传输logoutForm表单内容
            axios.post('/Employee_war_exploded/Logout',jsonData)
                .then(response => {
                    if (response.data === 1) {
                        //弹出注销成功弹窗后两秒返回登录页面
                        showAlert('注销成功!','两秒后返回登录页面');
                        setTimeout(function () {
                            window.location.href = 'login.jsp';
                        }, 2000);
                    } else if(response.data === 0) {
                        showAlert('注销失败','用户名或密码错误');
                    }
                }).catch(error => {
                    console.error(error);
                });
        }
    });
    //显示表单
    document.getElementById("logoutForm").style.display = "block";
    //点击确认注销按钮弹出注销确认弹窗
    document.getElementById("btnYes").addEventListener("click", function () {
        document.getElementById("logoutModal").style.display = "block";
    });
    //点击弹窗的取消按钮返回index.jsp
    document.getElementById("btnNo").addEventListener("click", function () {
        window.location.href = 'index.jsp';
    });

    // 显示alert弹窗的函数，可以动态设置标题和消息
    function showAlert(title, message) {
        // 如果没有传入参数，使用默认值
        title = title || '温馨提示';
        message = message || '默认弹窗';

        // 更新弹窗内容
        document.getElementById('alertTitle').textContent = title;
        document.getElementById('alertMessage').textContent = message;

        // 显示弹窗
        document.getElementById('alertOverlay').classList.add('show');
    }

    // 关闭弹窗的函数
    function closeAlert() {
        document.getElementById('alertOverlay').classList.remove('show');
    }

</script>
</body>
</html>
