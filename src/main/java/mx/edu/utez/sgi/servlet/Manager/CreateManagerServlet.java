package mx.edu.utez.sgi.servlet.Manager;

import mx.edu.utez.sgi.dao.ManagerDao;
import mx.edu.utez.sgi.entities.Manager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CreateManagerServlet", value = "/CreateManagerServlet")
public class CreateManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/asignados.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset UTF-8");

        ManagerDao managerDao = new ManagerDao();
        boolean activo = Boolean.parseBoolean(request.getParameter("activo"));
        String status = activo ? "Activo" : "Inactivo";

        String nombre1A = request.getParameter("nombre1A");
        String nombre2A = request.getParameter("nombre2A");
        String apellido1A = request.getParameter("apellido1A");
        String apellido2A = request.getParameter("apellido2A");
        long numEmpleado = Long.parseLong(request.getParameter("numEmpleado"));
        String fechaResguardo = request.getParameter("fechaResguardo");

        Manager manager = new Manager(status, nombre1A, nombre2A, apellido1A, apellido2A, numEmpleado, fechaResguardo);
        request.setAttribute("success", managerDao.createManager(manager));

        doGet(request, response);
    }
}