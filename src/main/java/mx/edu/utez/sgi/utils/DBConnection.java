package mx.edu.utez.sgi.utils;

import java.sql.DriverManager;
import java.sql.Connection;

public class DBConnection {
    public Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/Inventory", "root", "root");
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        DBConnection con = new DBConnection();
        con.getConnection();
    }
}
