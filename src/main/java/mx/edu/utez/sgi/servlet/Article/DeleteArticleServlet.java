package mx.edu.utez.sgi.servlet.Article;

import mx.edu.utez.sgi.dao.ArticleDao;
import mx.edu.utez.sgi.dao.ClassroomDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteArticleServlet", value = "/DeleteArticleServlet")
public class DeleteArticleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("view/articulos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ArticleDao articleDao = new ArticleDao();
        long id = Long.parseLong(request.getParameter("d_id"));
        request.setAttribute("success",articleDao.deleteArticle(id));

        doGet(request, response);
    }
}