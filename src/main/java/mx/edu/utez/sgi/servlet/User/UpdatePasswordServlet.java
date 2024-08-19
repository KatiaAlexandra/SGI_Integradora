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
        request.getRequestDispatcher("/view/inicio.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        UserDao userDao = new UserDao();

        String nombre = request.getParameter("nombre");
        String oldPassword = request.getParameter("contraseñaA");
        String email = request.getParameter("emailC");
        String newPassword = request.getParameter("contraseñaN");

        // Validaciones adicionales
        if (newPassword.equals(oldPassword)) {
            request.setAttribute("message", "La nueva contraseña no puede ser igual a la anterior.");
            request.setAttribute("showMessageModal", true);
            request.getRequestDispatcher("/view/inicio.jsp").forward(request, response);
            return;
        }

        if (oldPassword == null || oldPassword.isEmpty()) {
            request.setAttribute("message", "Debe ingresar la contraseña anterior.");
            request.setAttribute("showMessageModal", true);
            request.getRequestDispatcher("/view/inicio.jsp").forward(request, response);
            return;
        }

        boolean isValidUser = userDao.findUsernameAndPassword(nombre, oldPassword, email);

        if (isValidUser) {
            boolean isPasswordChanged = userDao.changePassword(nombre, newPassword);
            if (isPasswordChanged) {
                request.setAttribute("message", "Contraseña cambiada exitosamente.");
            } else {
                request.setAttribute("message", "Error al cambiar la contraseña.");
            }
        } else {
            request.setAttribute("message", "Contraseña anterior incorrecta.");
        }

        // Mostrar el modal de mensaje
        request.setAttribute("showMessageModal", true);
        request.getRequestDispatcher("/view/inicio.jsp").forward(request, response);
    }
}