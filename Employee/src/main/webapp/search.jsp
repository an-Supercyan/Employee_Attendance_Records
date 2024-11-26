<%--
  Created by IntelliJ IDEA.
  User: 25312
  Date: 2024/11/22
  Time: 下午9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>搜索结果</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <style>
        {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #searchResultsOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        #searchResultsModal {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 800px;
            overflow: hidden;
            animation: fadeIn 0.5s ease-in-out;
        }

        .modal-header {
            background-color: #007bff;
            color: #fff;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
        }

        #closeModalBtn {
            cursor: pointer;
            font-size: 20px;
        }

        .table-container {
            padding: 20px;
        }

        #searchResultsTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        #searchResultsTable th,
        #searchResultsTable td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #searchResultsTable th {
            background-color: #e0eaf1;
            color: #0056b3;
            font-weight: bold;
        }

        #searchResultsTable tr:hover {
            background-color: #f1f8ff;
        }

        #noResultsMessage {
            color: #888;
            text-align: center;
            margin-top: 20px;
        }

        #returnButton {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        #returnButton:hover {
            background-color: #0056b3;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
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
                <c:forEach var="searchResult" items="${searchResults}">
                    <tr>
                        <td>${searchResult.id}</td>
                        <td>${searchResult.employeeName}</td>
                        <td>${searchResult.department}</td>
                        <td>${searchResult.requriedHours}</td>
                        <td>${searchResult.punchTime}</td>
                        <td>${searchResult.totalHours}</td>
                        <td>${searchResult.overtimeHours}</td>
                        <td>${searchResult.absenceCount}</td>
                        <td>${searchResult.entryTime}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div id="noResultsMessage" style="display:none;">未找到匹配的记录</div>
            <button id="returnButton">返回搜索页面</button>
        </div>
    </div>
</div>
</body>

<script>
    //返回搜索页面
    document.getElementById("returnButton").addEventListener("click", function() {
        window.location.href = "/Page";
    });
</script>
</html>
