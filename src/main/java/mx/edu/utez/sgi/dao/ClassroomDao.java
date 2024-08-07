package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.Building;
import mx.edu.utez.sgi.entities.Classroom;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClassroomDao {
    private final DBConnection DB_CONNECTION = new DBConnection();
    private PreparedStatement pstm;
    private Connection con;
    private ResultSet rs;
    private final BuildingDao buildingDao = new BuildingDao();
    private final String[] QUERIES = {
            "INSERT INTO Classrooms (classroom_id, classroom_name, building) VALUES (?, ?, ?) ",
            "SELECT * FROM Classrooms",
            "SELECT * FROM Classrooms WHERE classroom_id = ? ",
            "UPDATE classrooms SET classroom_id = ?, classroom_name = ?, building = ? WHERE classroom_id = ?",
            "DELETE FROM Classrooms WHERE classroom_id = ?",
    };

    public boolean agregarUbicacion(Classroom classroom) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setLong(1, classroom.getClassroom_id());
            pstm.setString(2, classroom.getClassroom_name());
            pstm.setLong(3, classroom.getBuilding().getBuilding_ID());
            int result = pstm.executeUpdate();
            return result>0;
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
        finally {
            closeConnection();
        }
    }

    public boolean modificarUbicacion(Classroom classroom) {
        Classroom found = findClassroomById(classroom.getClassroom_id());
        if (found != null){
            try {
                con = DB_CONNECTION.getConnection();
                pstm = con.prepareStatement(QUERIES[3]);
                pstm.setLong(1, classroom.getClassroom_id());
                pstm.setString(2, classroom.getClassroom_name());
                pstm.setLong(3, classroom.getBuilding().getBuilding_ID());
                pstm.setLong(4, classroom.getClassroom_id());
                int result = pstm.executeUpdate();
                return result > 0;
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            } finally {
                closeConnection();
            }
        } else {
            return false;
        }
    }

    public List<Classroom> viewClassrooms() {
        List<Classroom> classrooms = new ArrayList<>();
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Classroom classroom = new Classroom();
                classroom.setClassroom_id(rs.getLong("classroom_id"));
                classroom.setClassroom_name(rs.getString("classroom_name"));
                // Asegúrate de que el nombre de la columna es correcto y consistente con tu base de datos
                long buildingId = rs.getLong("building");
                Building building = buildingDao.findBuilding(buildingId);
                classroom.setBuilding(building);
                classrooms.add(classroom);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return classrooms;
    }

    public boolean deleteClassroom(long id) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[4]);
            pstm.setLong(1, id);
            int result = pstm.executeUpdate();
            return result>0;
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
        finally {
            closeConnection();
        }
    }

    public Classroom findClassroomById(long id) {
        Classroom found = null;
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            if(rs.next()) {
                found = new Classroom();
                found.setClassroom_id(rs.getLong("classroom_id"));
                found.setClassroom_name(rs.getString("classroom_name"));
                Building building = buildingDao.findBuilding(rs.getLong("building")); // Asegúrate de que "building" es el nombre correcto de la columna
                found.setBuilding(building);
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

    public List<Classroom> viewClassroomsByBuildingId(long id) {
        List<Classroom> classrooms = new ArrayList<>();
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[5]);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Classroom classroom = new Classroom();
                classroom.setClassroom_id(rs.getLong("classroom_id"));
                classroom.setClassroom_name(rs.getString("classroom_name"));
                long buildingId = rs.getLong("building");
                Building building = buildingDao.findBuilding(buildingId);
                classroom.setBuilding(building);
                classrooms.add(classroom);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return classrooms;
    }

    /*public static void main(String[] args) {
        ClassroomDao dao = new ClassroomDao();
        Classroom classroom = new Classroom(
                42,
                "CC10",
                new Building(3)
        );
        System.out.println(dao.modificarOAgregarUbicacion(classroom));
    }*/
}