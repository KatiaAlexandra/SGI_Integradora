package mx.edu.utez.sgi.dao;

import mx.edu.utez.sgi.entities.User;
import mx.edu.utez.sgi.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    private final DBConnection DB_CONNECTION = new DBConnection();
    private PreparedStatement pstm;
    private ResultSet rs;
    private Connection con;
    private final String[] QUERIES = {
            "SELECT * FROM user WHERE password = SHA2( ?, 256) AND username = ? AND email = ? LIMIT 1;",
            "UPDATE user SET password = ? WHERE username = ? OR email = ?;",
            "INSERT INTO user (username, password, email) VALUES (?, SHA2( ?, 256), ?);",
            "SELECT id, username, email FROM user;",
            "DELETE FROM user WHERE id=?;",
            "UPDATE user SET username=?, email=? WHERE id=?;",
            "SELECT * FROM user WHERE id=?;"
    };

    public boolean findUsernameAndPassword(String username, String password, String email) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setString(1, password);
            pstm.setString(2, username);
            pstm.setString(3, email);
            rs = pstm.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean changePassword(String user, String newPassword) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            pstm.setString(1, newPassword);
            pstm.setString(2, user);
            pstm.setString(3, user);

            int rowsAffected = pstm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean addUser(User user){
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            pstm.setString(1, user.getUsername());
            pstm.setString(2,user.getPassword());
            pstm.setString(3,user.getEmail());
            int result=pstm.executeUpdate();
            return result>0;
        }catch(SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            closeConnection();
        }
    }

    public boolean deleteUser(Long id){
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[4]);
            pstm.setLong(1, id);
            int result=pstm.executeUpdate();
            return result>0;
        }catch(SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            closeConnection();
        }
    }

    public boolean updateUser(User user){
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[5]);
            pstm.setString(1, user.getUsername());
            pstm.setString(2,user.getEmail());
            pstm.setLong(3,user.getId());
            int result=pstm.executeUpdate();
            return result>0;
        }catch(SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            closeConnection();
        }
    }

    public User findUserById(long id) {
        User found = null;
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[6]);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            if(rs.next()) {
                found = new User();
                found.setId(rs.getLong("id"));
                found.setUsername(rs.getString("username"));
                found.setEmail(rs.getString("email"));
                found.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return found;
    }

    public List<User> viewUser() {
        List<User> users = new ArrayList<>();
        try{
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[3]);
            rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setId(rs.getLong("id"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return users;
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

