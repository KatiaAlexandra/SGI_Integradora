package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.Manager;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManagerDao {
    private Connection con;
    private PreparedStatement pstm;
    private ResultSet rs;
    private final DBConnection DB_CONNECTION= new DBConnection();;
    private final String [] QUERIES = {
            "SELECT * FROM Article_Manager;",
            "SELECT * FROM Article_Manager WHERE Manager_ID=?;",
            "INSERT INTO Article_Manager (Manager_Status, First_Name, Second_Name, First_Lastname, Second_Lastname, Employee_Num, Custody_date)VALUES(?,?,?,?,?,?,?);",
            "UPDATE Article_Manager SET Manager_Status =?, First_Name=?, Second_Name=?, First_Lastname=?, Second_Lastname=?, Employee_Num=?, Custody_date=? WHERE Manager_ID =?;",
            "DELETE FROM Article_Manager WHERE Manager_ID=?;",
            "UPDATE Article_Manager SET Manager_Status =? WHERE Manager_ID=?;"
    };

    public List<Manager> findAllManagers(){
        List<Manager> list = new ArrayList<>();
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            rs = pstm.executeQuery();
            while(rs.next()) {
                Manager manager = new Manager(
                        rs.getLong("Manager_ID"),
                        rs.getBoolean("Manager_Status"),
                        rs.getString("First_Name"),
                        rs.getString("Second_Name"),
                        rs.getString("First_Lastname"),
                        rs.getString("Second_Lastname"),
                        rs.getLong("Employee_Num"),
                        rs.getString("Custody_date")
                );
                list.add(manager);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }

        return list;
    }

    public Manager findManagerById(long Manager_ID){
        Manager found = null;
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            pstm.setLong(1, Manager_ID);
            rs = pstm.executeQuery();
            if(rs.next()) {
                found = new Manager(
                        rs.getLong("Manager_ID"),
                        rs.getBoolean("Manager_Status"),
                        rs.getString("First_Name"),
                        rs.getString("Second_Name"),
                        rs.getString("First_Lastname"),
                        rs.getString("Second_Lastname"),
                        rs.getLong("Employee_Num"),
                        rs.getString("Custody_date")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return found;
    }

    public boolean createManager(Manager manager){
        boolean flag = false;
        try {
            con = DB_CONNECTION.getConnection();
            pstm=con.prepareStatement(QUERIES[2]);
            pstm.setBoolean(1, manager.getManager_Status());
            pstm.setString(2, manager.getFirst_Name());
            pstm.setString(3, manager.getSecond_Name());
            pstm.setString(4, manager.getFirst_Lastname());
            pstm.setString(5, manager.getSecond_Lastname());
            pstm.setLong(6, manager.getEmployee_Num());
            pstm.setString(7, manager.getCustody_date());
            return pstm.executeUpdate() == 1;
        } catch (SQLException e){
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean updateManager(Manager manager){
        Manager found = findManagerById(manager.getManager_ID());
        if(found != null){
            try {
                con = DB_CONNECTION.getConnection();
                pstm=con.prepareStatement(QUERIES[3]);
                pstm.setBoolean(1, manager.getManager_Status());
                pstm.setString(2, manager.getFirst_Name());
                pstm.setString(3, manager.getSecond_Name());
                pstm.setString(4, manager.getFirst_Lastname());
                pstm.setString(5, manager.getSecond_Lastname());
                pstm.setLong(6, manager.getEmployee_Num());
                pstm.setString(7, manager.getCustody_date());
                pstm.setLong(8, manager.getManager_ID());
                return pstm.executeUpdate() == 1;
            } catch (SQLException e){
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        } else {
            return false;
        }
    }

    public boolean deleteManager(long Manager_ID){
        if(findManagerById(Manager_ID) != null){
            try {
                con = DB_CONNECTION.getConnection();
                pstm=con.prepareStatement(QUERIES[4]);
                pstm.setLong(1, Manager_ID);
                return pstm.executeUpdate() == 1;
            } catch (SQLException e){
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        } else {
            return false;
        }
    }

    public boolean changeManagerStatus(long Manager_ID){
        Manager found = findManagerById(Manager_ID);
        if(found != null){
            try {
                con = DB_CONNECTION.getConnection();
                pstm=con.prepareStatement(QUERIES[5]);
                pstm.setBoolean(1, !found.getManager_Status());
                pstm.setLong(2, Manager_ID);
                return pstm.executeUpdate() == 1;
            } catch (SQLException e){
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        } else {
            return false;
        }
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