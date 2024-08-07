package mx.edu.utez.sgi.servlet.Classroom;

import com.google.gson.Gson;
import mx.edu.utez.sgi.dao.ClassroomDao;
import mx.edu.utez.sgi.entities.Classroom;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetClassroomsServlet", value = "/GetClassroomsServlet")
public class GetClassroomsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        if (request.getSession(false)!= null && request.getSession(false).getAttribute("user") != null){
            ClassroomDao ClassroomDao = new ClassroomDao();
            List<Classroom> classrooms = ClassroomDao.viewClassrooms();
            String json = new Gson().toJson(classrooms);
            response.getWriter().write(json);
        }else{
            String forbidden = "{"+
                    "\"error\":403,"+
                    "\"message\":\"Acceso no autorizado\""+
                    "}";
            response.getWriter().write(forbidden);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}