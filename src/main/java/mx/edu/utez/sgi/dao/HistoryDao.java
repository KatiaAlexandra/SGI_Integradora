package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.Article;
import mx.edu.utez.sgi.entities.History;
import mx.edu.utez.sgi.entities.User;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HistoryDao {
    private final DBConnection DB_CONNECTION = new DBConnection();
    private PreparedStatement pstm;
    private ResultSet rs;
    private Connection con;


    public List<History> getAllHistory() {
        List<History> histories = new ArrayList<>();
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement("SELECT * FROM History;");
            rs = pstm.executeQuery();
            while (rs.next()) {
                History history= new History();
                history.setDate_creation(rs.getString("Date_Creation"));
                history.setInventory_number(rs.getString("Inventory_Number"));
                history.setArticle(rs.getString("Article"));
                history.setType_transaction(rs.getString("Type_Transaction"));
                history.setUsername(rs.getString("Username"));

                histories.add(history);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return histories;
    }


    private void closeConnection() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}