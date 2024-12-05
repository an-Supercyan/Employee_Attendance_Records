<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考勤管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-100: #0077C2;
            --primary-200: #59a5f5;
            --primary-300: #466be5;
            --accent-100: #466be5;
            --accent-200: #54abe6;
            --text-100: #333333;
            --text-200: #5c5c5c;
            --bg-100: #FFFFFF;
            --bg-200: #f5f5f5;
            --bg-300: #cccccc;
            --shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
        }

        body {
            color: var(--text-100);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: var(--bg-100) linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .container {
            width: 100%;
            max-width: 800px;
            margin: 20px;
            padding: 40px;
            background-color: var(--bg-200);
            border-radius: 20px;
            box-shadow: var(--shadow);
        }

        h1 {
            color: var(--primary-100);
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 40px;
            font-weight: 600;
            position: relative;
        }

        h1::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--primary-200);
            margin: 10px auto;
            border-radius: 2px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .menu-item {
            background: var(--bg-200);
            padding: 20px;
            border-radius: 15px;
            transition: all 0.3s ease;
            border: 1px solid var(--bg-300);
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
            border-color: var(--primary-200);
        }

        .menu-item i {
            font-size: 24px;
            margin-right: 15px;
            color: var(--primary-100);
        }

        .menu-item-content {
            flex-grow: 1;
        }

        .menu-item-title {
            font-size: 1.1em;
            color: var(--text-100);
            margin: 0;
            font-weight: 500;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background-color: var(--bg-200);
            margin: 5% auto;
            padding: 30px;
            border-radius: 20px;
            width: 90%;
            max-width: 600px;
            box-shadow: var(--shadow);
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .modal-header h2 {
            margin: 0;
            color: var(--text-100);
            font-size: 1.8em;
        }

        .close {
            font-size: 28px;
            color: var(--text-200);
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .close:hover {
            color: var(--accent-200);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-200);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--bg-300);
            border-radius: 10px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            font-size: 1em;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-200);
            box-shadow: 0 0 0 3px var(--primary-300);
        }

        .btn-submit {
            background-color: var(--accent-100);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1em;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background-color: var(--accent-200);
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 20px;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }

            .modal-content {
                margin: 10% auto;
                padding: 20px;
            }
        }

        /* 弹窗容器样式 */
        .alert-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }

        /* 弹窗主体样式 */
        .alert-box {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 105, 255, 0.15);
            padding: 30px;
            max-width: 400px;
            width: 90%;
            text-align: center;
            transform: scale(0.7);
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        /* 弹窗标题样式 */
        .alert-title {
            color: #0069FF;
            font-size: 22px;
            margin-bottom: 15px;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        /* 弹窗消息样式 */
        .alert-message {
            color: #333;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 25px;
            font-weight: 400;
        }

        /* 按钮样式 */
        .alert-button {
            background-color: #0069FF;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .alert-button:hover {
            background-color: #0056d3;
        }

        /* 显示状态 */
        .alert-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .alert-overlay.show .alert-box {
            transform: scale(1);
            opacity: 1;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>考勤管理系统</h1>
    <div class="menu-grid">
        <div class="menu-item" onclick="window.location.href='<%=request.getContextPath()%>/Page'">
            <i class="fas fa-clipboard-list"></i>
            <div class="menu-item-content">
                <h3 class="menu-item-title">考勤信息管理系统</h3>
            </div>
        </div>
        <div class="menu-item" onclick="openModal()">
            <i class="fas fa-plus-circle"></i>
            <div class="menu-item-content">
                <h3 class="menu-item-title">新增考勤信息</h3>
            </div>
        </div>
        <div class="menu-item" onclick="window.location.href='logout.jsp'">
            <i class="fas fa-trash-alt"></i>
            <div class="menu-item-content">
                <h3 class="menu-item-title">注销账户</h3>
            </div>
        </div>
        <div class="menu-item" onclick="window.location.href='login.jsp'">
            <i class="fas fa-sign-out-alt"></i>
            <div class="menu-item-content">
                <h3 class="menu-item-title">退出登录</h3>
            </div>
        </div>
    </div>
</div>

<!-- 弹窗容器 -->
<div class="alert-overlay" id="alertOverlay">
    <div class="alert-box">
        <h2 class="alert-title" id="alertTitle"></h2>
        <p class="alert-message" id="alertMessage"></p>
        <button class="alert-button" onclick="AnotherCloseAlert()">否</button>
        <button class="alert-button" onclick="closeAlert()">是</button>
    </div>
</div>

<div id="attendanceModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>新增考勤信息</h2>
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
        <form id="attendanceForm">
            <div class="form-group">
                <label for="employeeName"><i class="fas fa-user"></i> 员工姓名</label>
                <input type="text" id="employeeName" name="employeeName" required>
            </div>
            <div class="form-group">
                <label for="department"><i class="fas fa-building"></i> 部门</label>
                <input type="text" id="department" name="department" required>
            </div>
            <div class="form-group">
                <label for="requiredHours"><i class="fas fa-clock"></i> 规定工时</label>
                <input type="number" id="requiredHours" name="requiredHours" required>
            </div>
            <div class="form-group">
                <label for="punchTime"><i class="fas fa-fingerprint"></i> 打卡次数</label>
                <input type="number" id="punchTime" name="punchTime" required>
            </div>
            <div class="form-group">
                <label for="totalHours"><i class="fas fa-hourglass-half"></i> 实际工时</label>
                <input type="number" id="totalHours" name="totalHours" required>
            </div>
            <div class="form-group">
                <label for="overTimeHours"><i class="fas fa-business-time"></i> 加班工时</label>
                <input type="number" id="overTimeHours" name="overTimeHours" required>
            </div>
            <div class="form-group">
                <label for="absenceCount"><i class="fas fa-user-clock"></i> 缺勤次数</label>
                <input type="number" id="absenceCount" name="absenceCount" required>
            </div>
            <button type="submit" class="btn-submit" onclick="insertData()">
                <i class="fas fa-save"></i> 提交
            </button>
        </form>
    </div>
</div>

<%--引入axios相关依赖--%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    //axios实现异步插入数据
    document.getElementById('attendanceForm').addEventListener('submit', function (event) {
        event.preventDefault();
        const formData = new FormData(this);
        const f = Object.fromEntries(formData.entries())
        formData.append('jsonData', JSON.stringify(f));
        console.log(formData);
        axios.post('insert.action', f)
            .then(response => {
                showAlert('操作成功', '员工考勤信息添加成功!\n\n是否跳转到搜索页面?')
            })
            .catch(error => {
                showAlert('数据插入失败', '请将问题反馈给管理员')
                console.error(error);
                closeModal();
            })
    })

    //新增考勤信息弹窗相关函数 弹窗显示与关闭
    function openModal() {
        document.getElementById('attendanceModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    //关闭新增考勤信息弹窗 并恢复滚动
    function closeModal() {
        document.getElementById('attendanceModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }

    //点击空白处关闭弹窗
    window.onclick = function (event) {
        const modal = document.getElementById('attendanceModal');
        if (event.target === modal) {
            closeModal();
        }
    }

    //退出登录时

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
        //跳转到/Page页面
        window.location.href = '/Employee_war_exploded/Page';
    }

    function AnotherCloseAlert() {
        document.getElementById('alertOverlay').classList.remove('show');
        //刷新页面
        window.location.reload();
    }
</script>
</body>
</html>