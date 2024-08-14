package mx.edu.utez.sgi.servlet.Manager;

import mx.edu.utez.sgi.dao.ManagerDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ChangeManagerStatusServlet", value = "/ChangeManagerStatusServlet")
public class ChangeManagerStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/asignados.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ManagerDao managerDao = new ManagerDao();
        long id = Long.parseLong(request.getParameter("ch_id"));
        request.setAttribute("success", managerDao.changeManagerStatus(id));

        doGet(request, response);
    }
}