package mx.edu.utez.sgi.dao;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
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
            "SELECT * FROM user WHERE username = ? AND email = ? LIMIT 1;",
            "UPDATE user SET password = ? WHERE username = ? OR email = ?;",
            "INSERT INTO user (username, password, email) VALUES (?, ?, ?);",
            "SELECT id, username, email FROM user;",
            "DELETE FROM user WHERE id=?;",
            "UPDATE user SET username=?, email=? WHERE id=?;",
            "SELECT * FROM user WHERE id=?;"
    };

    public boolean findUsernameAndPassword(String username, String password, String email) {
        Argon2 argon2 = Argon2Factory.create();

        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[0]);
            pstm.setString(1, username);
            pstm.setString(2, email);
            rs = pstm.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                return argon2.verify(storedHash, password);
            } else {
                return false;  // Usuario no encontrado
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            argon2.wipeArray(password.toCharArray());  // Limpiar la memoria
            closeConnection();
        }
    }

    public boolean changePassword(String user, String newPassword) {
        Argon2 argon2 = Argon2Factory.create();
        String hashedPassword = argon2.hash(10, 65536, 1, newPassword);

        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[1]);
            pstm.setString(1, hashedPassword);
            pstm.setString(2, user);
            pstm.setString(3, user);

            int rowsAffected = pstm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            argon2.wipeArray(newPassword.toCharArray());  // Limpiar la memoria
            closeConnection();
        }
    }

    public boolean addUser(User user) {
        Argon2 argon2 = Argon2Factory.create();
        String hashedPassword = argon2.hash(10, 65536, 1, user.getPassword());

        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[2]);
            pstm.setString(1, user.getUsername());
            pstm.setString(2, hashedPassword);
            pstm.setString(3, user.getEmail());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            argon2.wipeArray(user.getPassword().toCharArray());  // Limpiar la memoria
            closeConnection();
        }
    }

    public boolean deleteUser(Long id) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[4]);
            pstm.setLong(1, id);
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnection();
        }
    }

    public boolean updateUser(User user) {
        try {
            con = DB_CONNECTION.getConnection();
            pstm = con.prepareStatement(QUERIES[5]);
            pstm.setString(1, user.getUsername());
            pstm.setString(2, user.getEmail());
            pstm.setLong(3, user.getId());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
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
            if (rs.next()) {
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
        try {
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
    public static void main(String[] args) {
        UserDao userDao = new UserDao();

        User katia = new User();
        katia.setUsername("Katia");
        katia.setEmail("20233tn166@utez.edu.mx");
        katia.setPassword("Katia");
        userDao.addUser(katia);

        User daniel = new User();
        daniel.setUsername("Daniel");
        daniel.setEmail("20233tn175@utez.edu.mx");
        daniel.setPassword("Daniel");
        userDao.addUser(daniel);

        User martin = new User();
        martin.setUsername("Martin");
        martin.setEmail("20233tn170@utez.edu.mx");
        martin.setPassword("Martin");
        userDao.addUser(martin);

        User aquino = new User();
        aquino.setUsername("Aquino");
        aquino.setEmail("20233tn183@utez.edu.mx");
        aquino.setPassword("Aquino");
        userDao.addUser(aquino);

        User aldo = new User();
        aldo.setUsername("Aldo");
        aldo.setEmail("20233tn180@utez.edu.mx");
        aldo.setPassword("Aldo");
        userDao.addUser(aldo);

        System.out.println("Usuarios creados exitosamente.");
    }
}