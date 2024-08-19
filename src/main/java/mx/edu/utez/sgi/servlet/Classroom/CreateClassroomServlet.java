package mx.edu.utez.sgi.servlet.Classroom;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

import mx.edu.utez.sgi.dao.ClassroomDao;
import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.entities.Classroom;

@WebServlet(name = "CreateClassroomServlet}", value = "/CreateClassroomServlet")
public class CreateClassroomServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/ubicaciones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String classroomName = request.getParameter("aula");
        int building = Integer.parseInt(request.getParameter("building"));
        Building buildingObj = new Building();
        buildingObj.setBuilding_ID(building);


        Classroom classroom = new Classroom();
        classroom.setClassroom_name(classroomName);
        classroom.setBuilding(buildingObj);

        ClassroomDao classroomDao = new ClassroomDao();
        classroomDao.agregarUbicacion(classroom);

        doGet(request, response);
    }
}