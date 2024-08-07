package mx.edu.utez.sgi.servlet.Article;

import mx.edu.utez.sgi.dao.ArticleDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import mx.edu.utez.sgi.entities.Article;
import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.entities.Classroom;
import mx.edu.utez.sgi.dao.ManagerDao;
import mx.edu.utez.sgi.entities.Manager;

@WebServlet(name = "CreateArticleServlet", value = "/CreateArticleServlet")
public class CreateArticleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/articulos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // Recuperar parámetros del formulario
        String inventoryNumber = request.getParameter("no_inventario");
        String articleName = request.getParameter("nombre_articulo");
        String brandModel = request.getParameter("marca_modelo");
        String serialNum = request.getParameter("serie");
        String specifications = request.getParameter("especificaciones");
        long managerId = Long.parseLong(request.getParameter("encargado"));
        long classroomId = Long.parseLong(request.getParameter("aula"));

        // Crear objetos Manager y Classroom
        Manager manager = new Manager();
        manager.setManager_ID(managerId);

        Classroom classroom = new Classroom();
        classroom.setClassroom_id(classroomId);

        // Crear objeto Article y asignar valores
        Article article = new Article();
        article.setInventory_number(inventoryNumber);
        article.setArticle_name(articleName);
        article.setBrand_model(brandModel);
        article.setSerial_num(serialNum);
        article.setSpecifications(specifications);
        article.setManager(manager);
        article.setClassroom(classroom);

        // Llamar al DAO para guardar el objeto Article
        ArticleDao articleDao = new ArticleDao();
        boolean isAdded = articleDao.createArticle(article);

        doGet(request, response);
    }
}