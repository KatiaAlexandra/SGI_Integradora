package mx.edu.utez.sgi.servlet.Classroom;

import com.google.gson.Gson;
import mx.edu.utez.sgi.dao.ClassroomDao;
import mx.edu.utez.sgi.entities.Classroom;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GetClassroomServlet", value = "/GetClassroomServlet")
public class GetClassroomServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        if (request.getSession(false)!= null && request.getSession(false).getAttribute("user") != null){
            long id = Long.parseLong(request.getParameter("id"));
            Classroom classroom = new ClassroomDao().findClassroomById(id);
            String json = new Gson().toJson(classroom);
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