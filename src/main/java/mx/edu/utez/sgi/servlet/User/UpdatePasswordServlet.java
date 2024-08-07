package mx.edu.utez.sgi.servlet.User;

import mx.edu.utez.sgi.dao.UserDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdatePasswordServlet", value = "/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        UserDao userDao = new UserDao();

        String userChange = request.getParameter("nombre");
        String oldPassword = request.getParameter("contraseñaA");
        String emailChange = request.getParameter("emailC");

        boolean isValidUser = userDao.findUsernameAndPassword(userChange, emailChange, oldPassword);

        if (isValidUser) {
            String newPassword = request.getParameter("contraseñaN");
            boolean isPasswordChanged = userDao.changePassword(userChange, newPassword);
            if (isPasswordChanged) {
                System.out.println("Contraseña cambiada");
                response.sendRedirect("index.jsp");
            } else {
                System.out.println("Error al cambiar la contraseña");
                response.sendRedirect("index.jsp"); // Redirigir a una página de error o mostrar un mensaje de error
            }
        } else {
            System.out.println("Contraseña incorrecta");
            response.sendRedirect("index.jsp");
        }
    }
}