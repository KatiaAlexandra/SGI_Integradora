package mx.edu.utez.sgi.servlet.Article;

import mx.edu.utez.sgi.dao.ArticleDao;
import mx.edu.utez.sgi.dao.ClassroomDao;
import mx.edu.utez.sgi.entities.Article;
import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.entities.Classroom;
import mx.edu.utez.sgi.entities.Manager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateArticleServlet", value = "/UpdateArticleServlet")
public class UpdateArticleServlet extends HttpServlet {
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
        long id = Long.parseLong(request.getParameter("id"));
        String articleName = request.getParameter("u_article_name");
        String brandModel = request.getParameter("u_brand_model");
        String serialNum = request.getParameter("u_serial_num");
        String specifications = request.getParameter("u_specifications");
        long managerId = Long.parseLong(request.getParameter("u_manager"));
        long classroomId = Long.parseLong(request.getParameter("u_aula"));

        Manager manager = new Manager();
        manager.setManager_ID(managerId);

        Classroom classroom = new Classroom();
        classroom.setClassroom_id(classroomId);

        Article article = new Article();
        article.setArticle_id(id);  // Añadir el ID para actualizar
        article.setInventory_number(inventoryNumber);
        article.setArticle_name(articleName);
        article.setBrand_model(brandModel);
        article.setSerial_num(serialNum);
        article.setSpecifications(specifications);
        article.setManager(manager);
        article.setClassroom(classroom);

        ArticleDao articleDao = new ArticleDao();
        articleDao.updateArticle(article);

        doGet(request, response);
    }
}