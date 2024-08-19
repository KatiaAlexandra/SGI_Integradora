package mx.edu.utez.sgi.servlet.Classroom;

import mx.edu.utez.sgi.dao.ClassroomDao;
import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.entities.Classroom;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateClassroomServlet", value = "/UpdateClassroomServlet")
public class UpdateClassroomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/ubicaciones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String classroomName = request.getParameter("aula");
        Long id = Long.parseLong(request.getParameter("id"));
        int building = Integer.parseInt(request.getParameter("building"));
        Building buildingObj = new Building();
        buildingObj.setBuilding_ID(building);


        Classroom classroom = new Classroom();
        classroom.setClassroom_id(id);
        classroom.setClassroom_name(classroomName);
        classroom.setBuilding(buildingObj);

        ClassroomDao classroomDao = new ClassroomDao();
        classroomDao.modificarUbicacion(classroom);

        doGet(request, response);
    }
}