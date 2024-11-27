package com.employee_records.servlet;


import com.employee_records.dao.AttendanceService;
import com.employee_records.dao.impl.AttendanceServiceImpl;
import com.employee_records.pojo.dto.AttendanceDTO;

import com.employee_records.pojo.vo.AttendanceVO;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.List;

@Slf4j
@WebServlet("*.action")
public class AttendanceServlet extends HttpServlet {
    private AttendanceService attendanceService;
    private AttendanceDTO attendanceDTO;


    @Override
    public void init() throws ServletException {
        attendanceService = new AttendanceServiceImpl();
        attendanceDTO = new AttendanceDTO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        req.setCharacterEncoding("utf-8");
        //设置响应编码(必须，主要是将数据库中查询到的数据以UTF-8的形式进行返回)
        resp.setCharacterEncoding("utf-8");
        log.info("请求方式：" + req.getMethod());
        log.info("请求路径：" + req.getServletPath());

        //获取路径参数
        String action = req.getServletPath();

        //读取前端POST请求传输的字节流(获取json格式的数据)
        BufferedReader reader = new BufferedReader(new InputStreamReader(req.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }


        //将json格式的数据通过反射转换为Java对象
        reader.close();
        Gson gson = new Gson();
        attendanceDTO = gson.fromJson(sb.toString(), AttendanceDTO.class);

        /*if (!StringUtils.isEmpty(req.getParameter("employeeName"))) {
            //存入到数据库时不需要进行转码
            attendanceDTO.setEmployeeName(req.getParameter("employeeName"));
        }
        if (!StringUtils.isEmpty(req.getParameter("department"))) {
            attendanceDTO.setDepartment(req.getParameter("department"));
        }
        if (!StringUtils.isEmpty(req.getParameter("employeeName"))) {
            attendanceDTO.setEmployeeName(req.getParameter("employeeName"));
        }
        if (!StringUtils.isEmpty(req.getParameter("department"))) {
            attendanceDTO.setDepartment(req.getParameter("department"));
        }
        if (!StringUtils.isEmpty(req.getParameter("requiredHours"))) {
            attendanceDTO.setRequiredHours(Integer.parseInt(req.getParameter("requiredHours")));
        }
        if (!StringUtils.isEmpty(req.getParameter("punchTime"))) {
            attendanceDTO.setPunchTime(req.getParameter("punchTime"));
        }
        if (!StringUtils.isEmpty(req.getParameter("totalHours"))) {
            attendanceDTO.setTotalHours(Integer.parseInt(req.getParameter("totalHours")));
        }
        if (!StringUtils.isEmpty(req.getParameter("overTimeHours"))) {
            attendanceDTO.setOverTimeHours(Integer.parseInt(req.getParameter("overTimeHours")));
        }
        if (!StringUtils.isEmpty(req.getParameter("absenceCount"))) {
            attendanceDTO.setAbsenceCount(Integer.parseInt(req.getParameter("absenceCount")));
        }
        if(!StringUtils.isEmpty(req.getParameter("entryTime"))){
            attendanceDTO.setEntryTime(req.getParameter("entryTime"));
        }
        if (!StringUtils.isEmpty(req.getParameter("id"))) {
            attendanceDTO.setId(Long.parseLong(req.getParameter("id")));
        }*/

        try {
            switch (action) {
                // TODO 细化业务逻辑 插入不存在的部门的用户信息时，新创建该部门
                case "/insert.action":
                    if (attendanceService.addAttendanceInfo(attendanceDTO)) {
                        log.info("添加成功");
                        String json = gson.toJson("成功");
                        PrintWriter out = resp.getWriter();
                        out.print(json);
                        out.flush();
                    } else {
                        System.err.println("添加时未知错误，请检查");
                    }
                    break;
                // TODO 细化业务逻辑 删除部门的最后一个员工时，删除该部门
                case "/delete.action":
                    if (attendanceService.deleteAttendanceInfo(attendanceDTO)) {
                        log.info("删除成功");
                        String json = gson.toJson("成功");
                        PrintWriter out = resp.getWriter();
                        out.print(json);
                        out.flush();
                    } else {
                        System.err.println("删除时未知错误，请检查");
                    }
                    break;
                case "/update.action":
                    if (attendanceService.updateAttendanceInfo(attendanceDTO)) {
                        log.info("修改成功");
                        String json = gson.toJson("成功");
                        PrintWriter out = resp.getWriter();
                        out.print(json);
                        out.flush();
                    } else {
                        System.err.println("修改时未知错误，请检查");
                    }
                    break;
                case "/search.action":
                    List<AttendanceVO> attendanceVOS = attendanceService.selectAttendanceInfo(attendanceDTO);
                    /*RequestDispatcher dispatcher = req.getRequestDispatcher("search.jsp");
                    req.setAttribute("searchResults", searchAtdanVOS);
                    dispatcher.forward(req, resp);*/
                    System.out.println("由java程序获取到Servlet时对象数据格式");
                    for (AttendanceVO attendanceVO : attendanceVOS) {
                        System.out.println(attendanceVO.toString());
                    }
                    String json = gson.toJson(attendanceVOS);
                    PrintWriter out = resp.getWriter();
                    out.print(json);
                    out.flush();
                    break;
                default:
                    resp.sendRedirect("erro.jsp");
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
