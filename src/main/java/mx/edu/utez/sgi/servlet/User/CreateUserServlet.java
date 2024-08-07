package mx.edu.utez.sgi.servlet.User;

import mx.edu.utez.sgi.dao.UserDao;
import mx.edu.utez.sgi.entities.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CreateUserServlet", value = "/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/gestionUsuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String username=request.getParameter("nombreU");
        String email=request.getParameter("correo");
        String password=request.getParameter("contraseña");

        User user=new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);

        UserDao dao = new UserDao();

        dao.addUser(user);
        doGet(request, response);

    }
}