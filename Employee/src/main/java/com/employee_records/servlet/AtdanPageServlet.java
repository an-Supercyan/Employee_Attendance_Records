package com.employee_records.servlet;

import com.employee_records.dao.AttendanceService;
import com.employee_records.dao.impl.AttendanceServiceImpl;
import com.employee_records.pojo.vo.AttendanceVO;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@WebServlet("/Page")
public class AtdanPageServlet extends HttpServlet {
    private AttendanceService attendanceService;
    public static final int PAGE_SIZE = 10;
    @Override
    public void init() throws ServletException {
        attendanceService = new AttendanceServiceImpl();
        List<AttendanceVO> attendanceVOList = new ArrayList<>();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        try {
            int pageNum = 1;
            //页码不能小于等于0，若小于等于0则自动识别为第一页
            String page = req.getParameter("page");
            pageNum = page == null ? 1 : Integer.parseInt(page);
            //获取当前页面展示的数据
            List<AttendanceVO> attendanceVOS = attendanceService.PageAttendanceInfo(pageNum, PAGE_SIZE);
            int total =  attendanceService.getTotalPages(PAGE_SIZE);

            //设置返回的页面参数，包括页面展示的数据列表，页面当前页号，页面展示的总页数
            RequestDispatcher dispatcher = req.getRequestDispatcher("/attendanceQuery.jsp");
            req.setAttribute("attendances",attendanceVOS);
            req.setAttribute("currentPage",pageNum);
            req.setAttribute("totalPages",total);
            System.out.println(pageNum);
            System.out.println(total);
            dispatcher.forward(req,resp);
        }
        catch (NumberFormatException e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
