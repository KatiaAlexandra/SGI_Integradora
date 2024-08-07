package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BuildingDao {
    private final DBConnection DB_CONNECTION = new DBConnection();
    private ResultSet rs;
    private PreparedStatement pstm;
    private Connection con;
    private final String[] QUERIES = {
            "select * from buildings",
            "select * from buildings where Building_ID = ?"
    };

    public List<Building> getAllBuildings() {
        List<Building> buildings = new ArrayList<>();
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Building building = new Building();
                building.setBuilding_ID(rs.getInt("Building_id"));
                building.setBuilding_name(rs.getString("Building_name"));
                buildings.add(building);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return buildings;
    }

    public Building findBuilding(long building_ID) {
        Building found = null;
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            pstm.setLong(1, building_ID);
            rs = pstm.executeQuery();
            if (rs.next()) {
                found = new Building();
                found.setBuilding_ID(rs.getLong("Building_ID"));
                found.setBuilding_name(rs.getString("Building_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return found;
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

    public static void main(String[] args) {
        BuildingDao dao = new BuildingDao();
        dao.findBuilding(1);
        System.out.println(dao.findBuilding(1).getBuilding_name());
    }
}