<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/22
  Time: 下午2:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        /* 新增的样式 */
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

        .fade-in {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <header class="header fade-in">
        <h1>考勤信息管理系统</h1>
    </header>
    <div class="search-container fade-in">
        <form class="search-form" action="search.action" method="post">
            <div class="form-group">
                <label for="employeeName">员工姓名</label>
                <input type="text" id="employeeName" name="employeeName" placeholder="请输入员工姓名">
            </div>
            <div class="form-group">
                <label for="department">部门</label>
                <input type="text" id="department" name="department" placeholder="请输入部门名称">
            </div>
            <div class="form-group">
                <label for="entryDate">日期</label>
                <input type="date" id="entryDate" name="entryDate">
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
            <c:forEach var="attendance" items="${attendances}">
                <tr>
                    <td>${attendance.employeeName}</td>
                    <td>${attendance.id}</td>
                    <td>${attendance.department}</td>
                    <td>${attendance.punchTime}</td>
                    <td>${attendance.absenceCount}</td>
                    <td>${attendance.totalHours}</td>
                    <td style="display: flex; gap: 0.5rem;">
                        <button class="button primary" onclick="openEditModal('${attendance.id}')">编辑</button>
                        <button class="button danger" onclick="confirmDelete('${attendance.id}')">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination fade-in">
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
        <form class="edit-form" action="update.action" method="post">
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

<script src="https://cdn.bootcdn.net/ajax/libs/axios/0.21.1/axios.js"></script>
<script>
    let currentDeleteId = null;

    function openEditModal(id) {
        const modal = document.getElementById('editModal');
        modal.style.display = 'block';

        // 使用axios获取数据
        axios.get(`/attendance/get?id=${id}`)
            .then(response => {
                const data = response.data;
                document.getElementById('editId').value = data.id;
                document.getElementById('editName').value = data.employeeName;
                document.getElementById('editDepartment').value = data.department;
                document.getElementById('editCheckInTime').value = formatDateTime(data.punchTime);
                document.getElementById('editWorkHours').value = data.totalHours;
            })
            .catch(error => {
                console.error('Error fetching attendance data:', error);
                alert('获取数据失败，请重试');
            });
    }

    function closeEditModal() {
        const modal = document.getElementById('editModal');
        modal.style.display = 'none';
    }

    function confirmDelete(id) {
        currentDeleteId = id;
        const modal = document.getElementById('confirmModal');
        modal.style.display = 'block';
    }

    function closeConfirmModal() {
        const modal = document.getElementById('confirmModal');
        modal.style.display = 'none';
        currentDeleteId = null;
    }

    function executeDelete() {
        if (!currentDeleteId) return;

        axios.delete(`/attendance/delete?id=${currentDeleteId}`)
            .then(response => {
                if (response.data.success) {
                    window.location.reload();
                } else {
                    alert('删除失败：' + response.data.message);
                }
            })
            .catch(error => {
                console.error('Error deleting attendance:', error);
                alert('删除失败，请重试');
            })
            .finally(() => {
                closeConfirmModal();
            });
    }

    function formatDateTime(dateString) {
        const date = new Date(dateString);
        return date.toISOString().slice(0, 16);
    }

    window.onclick = function(event) {
        const editModal = document.getElementById('editModal');
        const confirmModal = document.getElementById('confirmModal');
        if (event.target === editModal) {
            closeEditModal();
        }
        if (event.target === confirmModal) {
            closeConfirmModal();
        }
    }

    function changePage(page) {
        window.location.href = "Page?page=" + page;
    }
</script>
</body>
</html>