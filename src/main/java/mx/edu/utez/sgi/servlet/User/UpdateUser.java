package mx.edu.utez.sgi.servlet.User;

import mx.edu.utez.sgi.dao.UserDao;
import mx.edu.utez.sgi.entities.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateUser", value = "/UpdateUser")
public class UpdateUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/gestionUsuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String username = request.getParameter("u_username");
        String email = request.getParameter("u_email");
        Long id = Long.parseLong(request.getParameter("id"));

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setId(id);

        UserDao dao = new UserDao();
        dao.updateUser(user);

        doGet(request, response);
    }
}