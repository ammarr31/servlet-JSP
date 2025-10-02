package com.item.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import com.item.model.User;
import com.item.service.UserService;

public class UserServiceImpl implements UserService {

    private DataSource datasource;

    public UserServiceImpl(DataSource datasource) {
        this.datasource = datasource;
    }

    @Override
    public boolean registerUser(User user) {
        try (Connection conn = datasource.getConnection();
             Statement stmt = conn.createStatement()) {

            String query = "INSERT INTO users (username, password, full_name) VALUES ('"
                    + user.getUsername() + "', '"
                    + user.getPassword() + "', '"
                    + user.getFullName() + "')";
            stmt.executeUpdate(query);
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User loginUser(String username, String password) {
        try (Connection conn = datasource.getConnection();
             Statement stmt = conn.createStatement()) {

            String query = "SELECT * FROM users WHERE username = '" + username
                    + "' AND password = '" + password + "'";
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean deleteUser(String username) {
        try (Connection conn = datasource.getConnection();
             Statement stmt = conn.createStatement()) {
            String query = "DELETE FROM users WHERE username = '" + username + "'";
            stmt.executeUpdate(query);
            return true;
        } catch(SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public User findUserByUsername(String username) {
        try (Connection conn = datasource.getConnection();
             Statement stmt = conn.createStatement()) {

            String query = "SELECT * FROM users WHERE username = '" + username + "'";
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updatePassword(String username, String newPassword) {
        try (Connection conn = datasource.getConnection();
             Statement stmt = conn.createStatement()) {

            String query = "UPDATE users SET password = '" + newPassword + "' WHERE username = '" + username + "'";
            int rows = stmt.executeUpdate(query);
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
