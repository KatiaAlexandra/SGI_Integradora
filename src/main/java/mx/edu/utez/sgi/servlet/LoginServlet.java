package mx.edu.utez.sgi.servlet;

import mx.edu.utez.sgi.dao.UserDao;
import mx.edu.utez.sgi.entities.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean flag = (boolean) request.getAttribute("flag");
        request.setAttribute("errorMessage", flag);
        request.getRequestDispatcher(flag ? "/view/inicio.jsp" : "index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        UserDao dao = new UserDao();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (dao.findUsernameAndPassword(username, password, email)) {
            if (request.getSession(false) == null) {
                request.getSession(true);

            }
            request.getSession().setAttribute("user",email);
            request.getSession().setAttribute("username",username);
            request.setAttribute("flag", true);
        } else {
            request.setAttribute("flag", false);
        }
        doGet(request, response);
    }
}