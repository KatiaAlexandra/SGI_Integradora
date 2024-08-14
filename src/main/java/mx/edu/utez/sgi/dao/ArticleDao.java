package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.Article;
import mx.edu.utez.sgi.entities.Classroom;
import mx.edu.utez.sgi.entities.Manager;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {
    private final DBConnection DB_CONNECTION = new DBConnection();
    private final ManagerDao Manager_Dao= new ManagerDao();
    private final ClassroomDao Classroom_Dao= new ClassroomDao();
    private ResultSet rs;
    private PreparedStatement pstm;
    private Connection con;
    private final String[] QUERIES = {
            "SELECT * FROM articles LIMIT 100;",
            "SELECT * FROM articles WHERE article_id= ?;",
            "INSERT INTO articles(inventory_number, article_name, brand_model, serial_num, specifications, manager,classroom) VALUES(?, ?, ?, ?, ?, ?, ?);",
            "UPDATE articles SET inventory_number = ?, article_name= ?, brand_model= ?, serial_num= ?, specifications= ?, manager= ?, classroom= ? WHERE article_id = ?;",
            "DELETE FROM articles WHERE article_id = ?;",
    };

    public List<Article> findArticles() {
        List<Article> list = new ArrayList<>();
        try {
            con = DB_CONNECTION.getConnection();
            pstm= con.prepareStatement(QUERIES[0]);
            rs = pstm.executeQuery();
            while(rs.next()){
                Article article = new Article(
                        rs.getLong("article_id"),
                        rs.getString("inventory_number"),
                        rs.getString("article_name"),
                        rs.getString("brand_model"),
                        rs.getString("serial_num"),
                        rs.getString("specifications"),
                        Manager_Dao.findManagerById(rs.getLong("manager")), // Verifica si es int o long
                        Classroom_Dao.findClassroomById(rs.getLong("classroom")) // Verifica si es int o long
                );
                list.add(article);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return list;
    }

    public Article findArticleById(long article_id) {
        Article found = null;
        try {
            con = DB_CONNECTION.getConnection();
            pstm= con.prepareStatement(QUERIES[1]);
            pstm.setLong(1, article_id);
            rs = pstm.executeQuery();
            if(rs.next()){
                found = new Article(
                        rs.getLong("article_id"),
                        rs.getString("inventory_number"),
                        rs.getString("article_name"),
                        rs.getString("brand_model"),
                        rs.getString("serial_num"),
                        rs.getString("specifications"),
                        Manager_Dao.findManagerById(rs.getLong("manager")), // Verifica si es int o long
                        Classroom_Dao.findClassroomById(rs.getLong("classroom")) // Verifica si es int o long
                );
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeConnection();
        }
        return found;
    }

    public boolean createArticle (Article article){
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            pstm.setString(1, article.getInventory_number());
            pstm.setString(2, article.getArticle_name());
            pstm.setString(3, article.getBrand_model());
            pstm.setString(4, article.getSerial_num());
            pstm.setString(5, article.getSpecifications());
            pstm.setLong(6, article.getManager().getManager_ID()); // Cambia String por objeto Manager
            pstm.setLong(7, article.getClassroom().getClassroom_id()); // Cambia String por objeto Classroom
            return pstm.executeUpdate() == 1;
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean updateArticle (Article article){
        Article found = findArticleById(article.getArticle_id());
        if(found != null) {
            try{
                con = DB_CONNECTION.getConnection();
                pstm = con.prepareStatement(QUERIES[3]);
                pstm.setString(1, article.getInventory_number());
                pstm.setString(2, article.getArticle_name());
                pstm.setString(3, article.getBrand_model());
                pstm.setString(4, article.getSerial_num());
                pstm.setString(5, article.getSpecifications());
                pstm.setLong(6, article.getManager().getManager_ID()); // Cambia String por objeto Manager
                pstm.setLong(7, article.getClassroom().getClassroom_id()); // Cambia String por objeto Classroom
                pstm.setLong(8, article.getArticle_id());
                return pstm.executeUpdate() == 1;
            } catch (SQLException e){
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        }else {
            return false;
        }
    }

    public boolean deleteArticle (long article_id){
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[4]);
            pstm.setLong(1, article_id);
            int result = pstm.executeUpdate();
            return result>0;
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public static void main(String[] args) {
        ArticleDao articleDao = new ArticleDao();
        System.out.println(articleDao.findArticleById(100));
    }

    public void closeConnection(){
        try{
            if(con != null){
                con.close();
            }
            if(pstm!= null){
                pstm.close();
            }
            if(rs!=null){
                rs.close();
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
    }

}
