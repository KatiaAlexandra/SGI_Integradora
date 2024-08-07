package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.History;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HomeDao {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final DBConnection DB_CONNECTION = new DBConnection();
    private final String[] QUERIES = {
            "SELECT COUNT(*) AS total_articles FROM articles;",
            "SELECT COUNT(*) AS deleted_articles FROM history WHERE type_transaction='DELETE';",
            "SELECT * FROM history ORDER BY date_creation DESC LIMIT 3;"
    };

    public int getTotalArticles() {
        int total = 0;
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            rs = pstm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total_articles");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return total;
    }

    public int getDeletedArticles() {
        int total = 0;
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            rs = pstm.executeQuery();
            if (rs.next()) {
                total = rs.getInt("deleted_articles");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return total;
    }

    public List<History> getRecentMovements() {
        List<History> movements = new ArrayList<>();
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            rs = pstm.executeQuery();
            while (rs.next()) {
                History history = new History();
                history.setDate_creation(rs.getString("Date_Creation"));
                history.setInventory_number(rs.getString("Inventory_Number"));
                history.setArticle(rs.getString("Article"));
                history.setType_transaction(rs.getString("Type_Transaction"));
                history.setUsername(rs.getString("Username"));
                movements.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return movements;
    }

    public void closeConnection() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
