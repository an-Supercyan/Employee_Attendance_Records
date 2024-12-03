<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/17
  Time: 下午5:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考勤信息管理系统</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+SC:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4686e5 0%, #5eaeff 100%);
            --secondary-gradient: linear-gradient(135deg, #E5E7EB 0%, #F3F4F6 100%);
            --surface-gradient: linear-gradient(135deg, #FFFFFF 0%, #F9FAFB 100%);
            --primary: #466be5;
            --primary-light: #818CF8;
            --primary-dark: #3844ca;
            --text-primary: #111827;
            --text-secondary: #4B5563;
            --background: #F3F4F6;
            --surface: #FFFFFF;
            --border: #E5E7EB;
            --success: #059669;
            --warning: #D97706;
            --error: #DC2626;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans SC', sans-serif;
            background: var(--background);
            color: var(--text-primary);
            line-height: 1.5;
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
            padding-bottom: 1rem;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .search-container {
            background: var(--surface);
            border-radius: 24px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05),
            0 8px 10px -6px rgba(0, 0, 0, 0.02);
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .search-container:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 35px -10px rgba(0, 0, 0, 0.08),
            0 10px 20px -8px rgba(0, 0, 0, 0.04);
        }

        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .form-group {
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 0.875rem 1.25rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.2s ease;
            background: var(--surface);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }

        .table-container {
            background: var(--surface);
            border-radius: 24px;
            overflow-x: auto;
            padding: 2rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05),
            0 8px 10px -6px rgba(0, 0, 0, 0.02);
            margin-bottom: 2rem;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        th {
            background: var(--primary-gradient);
            color: white;
            font-weight: 600;
            padding: 1.25rem 1.5rem;
            text-align: left;
            font-size: 0.875rem;
            letter-spacing: 0.05em;
            position: sticky;
            top: 0;
        }

        td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        tr {
            background: var(--surface);
            transition: all 0.3s ease;
        }

        tr:hover {
            background: var(--background);
            transform: scale(1.01);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .button.primary {
            background: var(--primary-gradient);
            color: white;
        }

        .button.secondary {
            background: var(--secondary-gradient);
            color: var(--text-secondary);
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 1000;
        }

        .modal-content {
            background: var(--surface);
            border-radius: 24px;
            padding: 2.5rem;
            width: 90%;
            max-width: 600px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        .modal-header {
            margin-bottom: 2rem;
            text-align: center;
        }

        .modal-header h2 {
            font-size: 1.5rem;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .close {
            position: absolute;
            right: 1.5rem;
            top: 1.5rem;
            width: 2rem;
            height: 2rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--background);
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .close:hover {
            background: var(--error);
            color: white;
            transform: rotate(90deg);
        }

        .edit-form {
            display: grid;
            gap: 1.5rem;
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .pagination button {
            padding: 0.75rem 1.25rem;
            border: none;
            border-radius: 12px;
            background: var(--surface);
            color: var(--text-secondary);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .pagination button.active {
            background: var(--primary-gradient);
            color: white;
        }

        .pagination button:hover:not(.active) {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 删除警告窗口样式 */
        .button.danger {
            background: linear-gradient(135deg, #DC2626 0%, #EF4444 100%);
            color: white;
        }

        .button.cancel {
            background: linear-gradient(135deg, #9CA3AF 0%, #D1D5DB 100%);
            color: white;
        }

        .confirm-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 1001;
        }

        .confirm-content {
            background: var(--surface);
            border-radius: 16px;
            padding: 2rem;
            width: 90%;
            max-width: 400px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        .confirm-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 悬浮窗遮罩层 */
        #searchResultsOverlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        /* 悬浮窗容器 */
        #searchResultsModal {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 1200px;
            max-height: 80vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            position: relative;
            animation: slideIn 0.3s ease-out;
        }

        /* 悬浮窗头部 */
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background-color: #f0f4f8;
            border-bottom: 1px solid #e6e9ee;
        }

        .modal-header h2 {
            margin: 0;
            color: #2c5282;
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* 关闭按钮 */
        #closeModalBtn {
            width: 35px;
            height: 35px;
            background-color: #e6f2ff;
            color: #2c5282;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 20px;
            font-weight: bold;
        }

        #closeModalBtn:hover {
            background-color: #d1e7ff;
            transform: rotate(90deg);
        }

        /* 搜索表格样式 */
        #searchResultsTable {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }


        #searchResultsTable thead {
            position: sticky;
            top: 0;
            background-color: #f0f4f8;
            z-index: 10;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow-x: hidden;
            height: 40px;
        }

        #searchResultsTable th {
            padding: 12px;
            text-align: left;
            color: #2c5282;
            font-weight: 600;
            border-bottom: 1px solid #e6e9ee;
            font-size: 0.9rem;
            overflow: hidden;
        }

        #searchResultsTable td {
            padding: 10px 12px;
            border-bottom: 1px solid #f0f4f8;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
        }

        #searchResultsTable tbody tr:hover {
            background-color: #f5f9ff;
        }

        /* 动画效果 */
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }

        /* 无结果提示 */
        #noResultsMessage {
            text-align: center;
            padding: 30px;
            color: #2c5282;
            background-color: #f0f4f8;
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
    <button onclick="window.location.href='index.jsp'" class="return-button">
        返回主页
    </button>
    <header class="header fade-in">
        <h1>考勤信息管理系统</h1>
    </header>
    <div class="search-container fade-in">
        <form class="search-form">
            <div class="form-group">
                <label for="employeeName">员工姓名</label>
                <input type="text" id="employeeName" name="employeeName" placeholder="请输入员工姓名">
            </div>
            <div class="form-group">
                <label for="department">部门</label>
                <input type="text" id="department" name="department" placeholder="请输入部门名称">
            </div>
            <div class="form-group">
                <label for="entryTime">日期</label>
                <input type="date" id="entryTime" name="entryTime">
            </div>
            <div class="form-group" style="display: flex; align-items: flex-end; gap: 1rem;">
                <button type="submit" class="button primary">搜索</button>
                <button type="reset" class="button secondary">重置</button>
            </div>
        </form>
    </div>
    <div class="table-container fade-in">
        <table>
            <thead>
            <tr>
                <th>员工姓名</th>
                <th>工号</th>
                <th>部门</th>
                <th>打卡时间</th>
                <th>缺勤次数</th>
                <th>工作时长</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%--使用隐藏标签将attendances的长度能够被JavaScript使用--%>
            <input type="hidden" id="attendancesLength" value="${fn:length(attendances)}">
            <c:forEach var="attendance" items="${attendances}">
                <tr>
                    <td>${attendance.employeeName}</td>
                    <td>${attendance.id}</td>
                    <td>${attendance.department}</td>
                    <td>${attendance.punchTime}</td>
                    <td>${attendance.absenceCount}</td>
                    <td>${attendance.totalHours}</td>
                    <td style="display: flex; gap: 0.5rem;">
                        <button class="button primary" onclick="openEditModal(${attendance.id})">编辑</button>
                        <button class="button danger" onclick="confirmDelete(${attendance.id})">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination fade-in">

        <%--使用隐藏标签将totalPages能够被JavaScript使用--%>
        <input type="hidden" id="totalPages" value="${totalPages}">
        <%--使用隐藏标签将currentPage能够被JavaScript使用--%>
        <input type="hidden" id="currentPage" value="${currentPage}">

        <button onclick="changePage(${currentPage - 1})">上一页</button>
        <c:forEach var="pageNum" begin="1" end="${totalPages}">
            <button class="${pageNum == currentPage ? 'active' : ''}"
                    onclick="changePage(${pageNum})">${pageNum}</button>
        </c:forEach>
        <button onclick="changePage(${currentPage + 1})">下一页</button>
    </div>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>编辑考勤记录</h2>
            <span class="close" onclick="closeEditModal()">&times;</span>
        </div>
        <form class="edit-form">
            <input type="hidden" id="editId" name="id">
            <div class="form-group">
                <label for="editName">员工姓名</label>
                <input type="text" id="editName" name="employeeName" required>
            </div>
            <div class="form-group">
                <label for="editDepartment">部门</label>
                <input type="text" id="editDepartment" name="department" required>
            </div>
            <div class="form-group">
                <label for="editCheckInTime">打卡时间</label>
                <input type="datetime-local" id="editCheckInTime" name="punchTime" required>
            </div>
            <%--缺勤次数--%>
            <div class="form-group">
                <label for="editAbsenceCount">缺勤次数</label>
                <input type="number" id="editAbsenceCount" name="absenceCount" required>
            </div>
            <div class="form-group">
                <label for="editWorkHours">工作时长</label>
                <input type="number" id="editWorkHours" name="totalHours" step="0.5" required>
            </div>
            <div class="actions">
                <button type="button" class="button secondary" onclick="closeEditModal()">取消</button>
                <button type="submit" class="button primary">保存</button>
            </div>
        </form>
    </div>
</div>

<!-- 弹窗容器 -->
<div class="alert-overlay" id="alertOverlay">
    <div class="alert-box">
        <h2 class="alert-title" id="alertTitle">提示</h2>
        <p class="alert-message" id="alertMessage">弹窗容器</p>
        <button class="alert-button" onclick="closeAlert()">确认</button>
    </div>
</div>

<div id="searchResultsOverlay">
    <div id="searchResultsModal">
        <div class="modal-header">
            <h2>搜索结果</h2>
            <div id="closeModalBtn">&times;</div>
        </div>
        <div class="table-container">
            <table id="searchResultsTable">
                <thead>
                <tr>
                    <th>工号</th>
                    <th>员工姓名</th>
                    <th>部门</th>
                    <th>规定工时</th>
                    <th>打卡时间</th>
                    <th>实际工时</th>
                    <th>加班时长</th>
                    <th>缺勤次数</th>
                    <th>入职时间</th>
                </tr>
                </thead>
                <tbody id="searchResultsBody">
                <!-- 搜索结果将动态插入此处 -->
                </tbody>
            </table>
            <div id="noResultsMessage" style="display:none;">未找到匹配的记录</div>
        </div>
    </div>
</div>

<!-- 新增的确认删除模态框 -->
<div id="confirmModal" class="confirm-modal">
    <div class="confirm-content">
        <h3 style="margin-bottom: 1rem;">确认删除</h3>
        <p>您确定要删除这条考勤记录吗？此操作不可撤销。</p>
        <div class="confirm-actions">
            <button class="button cancel" onclick="closeConfirmModal()">取消</button>
            <button class="button danger" onclick="executeDelete()">确认删除</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    let currentDeleteId = null;
    //axios实现搜索框search-form搜索
    document.querySelector('.search-form').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = {
            employeeName: document.getElementById('employeeName').value,
            department: document.getElementById('department').value,
            entryTime: document.getElementById('entryTime').value
        };

        axios.post('/Employee_war_exploded/search.action', formData)
            .then(response => {
                //弹出搜索弹窗
                const searchResults = response.data;
                displaySearchResults(searchResults);
            })
            .catch(error => {
                console.error('搜索失败:', error);
                showAlert('操作失败', '出现未知错误请反馈给管理员')
            });
    });

    // 显示搜索结果
    function displaySearchResults(results) {
        const overlay = document.getElementById('searchResultsOverlay');
        const tbody = document.getElementById('searchResultsBody');
        const noResults = document.getElementById('noResultsMessage');

        tbody.innerHTML = '';
        if (results && results.length > 0) {
            results.forEach(result => {
                const row = document.createElement('tr');
                row.innerHTML =
                    '<td>' + result.id + '</td>' +
                    '<td>' + result.employeeName + '</td>' +
                    '<td>' + result.department + '</td>' +
                    '<td>' + result.requiredHours + '</td>' +
                    '<td>' + handleDate(result.punchTime) + '</td>' +
                    '<td>' + result.totalHours + '</td>' +
                    '<td>' + result.overTimeHours + '</td>' +
                    '<td>' + result.absenceCount + '</td>' +
                    '<td>' + handleDate(result.entryTime) + '</td>';
                tbody.appendChild(row);
            });
            noResults.style.display = 'none';
        } else {
            noResults.style.display = 'block';
        }
        overlay.style.display = 'flex';
    }

    // 关闭搜索结果窗口
    document.getElementById('closeModalBtn').addEventListener('click', function () {
        document.getElementById('searchResultsOverlay').style.display = 'none';
    });


    // 打开编辑模态框
    function openEditModal(id) {
        const modal = document.getElementById('editModal');
        modal.style.display = 'block';
        // 使用axios获取数据
        axios.post('/Employee_war_exploded/Back', {id: id})
            .then(response => {
                console.log(response.data);
                const editForm = document.querySelector('.edit-form');
                editForm.elements.id.value = response.data.id;
                editForm.elements.employeeName.value = response.data.employeeName;
                editForm.elements.department.value = response.data.department;
                //必须进行日期转换
                editForm.elements.punchTime.value = handleDate(response.data.punchTime);
                editForm.elements.totalHours.value = response.data.totalHours;
                editForm.elements.absenceCount.value = response.data.absenceCount;
            })
            .catch(error => {
                console.error('Error fetching attendance data:', error);
                showAlert('操作失败', '出现未知错误请反馈给管理员')
            });
    }

    //点击保存按钮使用axios的post请求，将输入框中的数据请求给update.action页面执行更新操作
    document.querySelector('.edit-form').addEventListener('submit', function (e) {
        // 阻止表单默认提交行为
        e.preventDefault();
        const formData = new FormData(this);
        //将表单数据转为json
        const jsonData = Object.fromEntries(formData.entries());
        formData.append('jsonData', JSON.stringify(jsonData));
        console.log(jsonData);
        axios.post('/Employee_war_exploded/update.action', jsonData)
            .then(response => {
                console.log('更新成功');
                showAlert('操作完成', '更新成功')
                // 重新加载页面
            })
            .catch(error => {
                console.error('更新失败:', error);
                showAlert('操作失败', '出现未知错误请反馈给管理员')
            })
    });

    // 解析 ISO 日期字符串
    function parseISODate(isoString) {
        return new Date(isoString);
    }

    // 格式化日期时间为 datetime-local 格式
    function formatDateTime(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
        return year + `-` + month + `-` + day + ` ` + hours + `:` + minutes + `:` + seconds;
    }

    // 搜索框中的处理日期
    function handleDate(isoString) {
        const dateObject = parseISODate(isoString);
        const formattedDateTime = formatDateTime(dateObject);
        console.log('Formatted DateTime:', formattedDateTime);
        // 将格式化的日期时间设置到表单中
        return formattedDateTime;
    }

    //执行删除操作
    function executeDelete() {
        if (!currentDeleteId) return;
        axios.post('/Employee_war_exploded/delete.action', {id: currentDeleteId})
            .then(response => {
                showAlert('操作完成', '删除成功');
            })
            .catch(error => {
                console.error('Error deleting attendance:', error);
                showAlert('操作失败', '出现未知错误请反馈给管理员')
            })
            .finally(() => {
                currentDeleteId = null;
                closeConfirmModal();
            });
    }

    /*window点击事件处理*/
    window.onclick = function (event) {
        const editModal = document.getElementById('editModal');
        const confirmModal = document.getElementById('confirmModal');
        const searchModal = document.getElementById('searchResultsModal');

        if (event.target === editModal) {
            closeEditModal();
        }
        if (event.target === confirmModal) {
            closeConfirmModal();
        }
        if (event.target === searchModal) {
            closeSearchModal();
        }
    }


    // 关闭编辑模态框
    function closeEditModal() {
        const modal = document.getElementById('editModal');
        modal.style.display = 'none';
    }

    // 显示确认删除模态框
    function confirmDelete(id) {
        currentDeleteId = id;
        const modal = document.getElementById('confirmModal');
        modal.style.display = 'block';
    }

    // 关闭确认删除模态框
    function closeConfirmModal() {
        const modal = document.getElementById('confirmModal');
        modal.style.display = 'none';
        currentDeleteId = null;
    }

    // 关闭悬浮窗
    function closeOverlay() {
        const overlay = document.getElementById('overlay');
        overlay.style.display = 'none';
    }

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
        //关闭窗口后刷新页面
        location.reload();
    }

    //翻页
    function changePage(page) {
        //使用const以及document获取totalPages
        const totalPages = document.getElementById('totalPages').value;
        //翻页不能小于1或大于当前总页数
        if (page < 1 || page > totalPages) {
            return;
        }
        window.location.href = "Page?page=" + page;
    }
</script>
</body>
</html>