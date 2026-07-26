package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.User;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // Helper method to ensure a valid, non-null database connection
    private Connection getConnection() throws SQLException {
        if (this.conn == null || this.conn.isClosed()) {
            this.conn = DBConnect.getConn();
        }
        return this.conn;
    }

    // ✅ Register new user
    public boolean register(User user) {
        String sql = "INSERT INTO users(name, email, mobile, password) VALUES(?,?,?,?)";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getMobile());
                ps.setString(4, user.getPassword());

                return ps.executeUpdate() == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Login method
    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return null;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setId(rs.getInt("id"));
                        user.setName(rs.getString("name"));
                        user.setEmail(rs.getString("email"));
                        user.setMobile(rs.getString("mobile"));
                        user.setPassword(rs.getString("password"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Check if email already exists
    public boolean checkEmail(String email) {
        String sql = "SELECT * FROM users WHERE email=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Get user by ID
    public User getUserById(int id) {
        User user = null;
        String sql = "SELECT * FROM users WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return null;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setInt(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user = new User();
                        user.setId(rs.getInt("id"));
                        user.setName(rs.getString("name"));
                        user.setEmail(rs.getString("email"));
                        user.setMobile(rs.getString("mobile"));
                        user.setPassword(rs.getString("password"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ Get all users
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) {
                System.err.println("❌ Database connection failed in UserDAO.getAllUsers()");
                return list;
            }

            try (PreparedStatement ps = activeConn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setMobile(rs.getString("mobile"));
                    u.setPassword(rs.getString("password"));
                    list.add(u);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Update user
    public boolean updateUser(User u) {
        String sql = "UPDATE users SET name=?, email=?, mobile=?, password=? WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setString(1, u.getName());
                ps.setString(2, u.getEmail());
                ps.setString(3, u.getMobile());
                ps.setString(4, u.getPassword());
                ps.setInt(5, u.getId());

                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Delete user by ID
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id=?";
        try {
            Connection activeConn = getConnection();
            if (activeConn == null) return false;

            try (PreparedStatement ps = activeConn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}