package mx.edu.utez.sgi.servlet.User;

import mx.edu.utez.sgi.dao.UserDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteUser", value = "/DeleteUser")
public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/gestionUsuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        UserDao userDao = new UserDao();
        long id = Long.parseLong(request.getParameter("d_id"));
        request.setAttribute("success",userDao.deleteUser(id));

        doGet(request, response);
    }
}