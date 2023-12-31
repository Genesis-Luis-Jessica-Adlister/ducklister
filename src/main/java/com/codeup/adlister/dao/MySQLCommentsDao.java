package com.codeup.adlister.dao;

import com.codeup.adlister.models.Comment;
import com.codeup.adlister.models.User;
import com.mysql.cj.jdbc.Driver;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MySQLCommentsDao implements Comments {

    private Connection connection;

    public MySQLCommentsDao(Config config) {
        try {
            DriverManager.registerDriver(new Driver());
            connection = DriverManager.getConnection(
                    config.getUrl(),
                    config.getUsername(),
                    config.getPassword()
            );
        } catch (SQLException e) {
            throw new RuntimeException("Error connecting to the database!", e);
        }

    }

    @Override
    public long insertComment(Comment comment) {
        try {
            String query = "INSERT INTO comments(comment, ad_id, user_id) VALUES (?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, comment.getComment());
            stmt.setLong(2, comment.getAdId());
            stmt.setLong(3, comment.getUserId());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getLong(1);
            } else {
                return 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error creating a new comment.", e);
        }

    }

    @Override
    public void deleteComment(long commentId) {
        try {
            String query = "DELETE FROM comments WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, commentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting comment.", e);
        }


    }

    @Override
    public void updateComment(String comment, long commentId) {
        try {
            String query = "UPDATE comments SET comment = ? WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, comment);
            stmt.setLong(2, commentId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating comment.", e);
        }

    }

    @Override
    public List<Comment> all() {
        try {
            String query = "SELECT * FROM comments";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            return createCommentsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving comments.", e);
        }
    }

    @Override
    public List<Comment> getCommentsByAdId(long adId) {
        try {
            String query = "SELECT * FROM comments WHERE ad_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, adId);
            ResultSet rs = stmt.executeQuery();
            return createCommentsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving comments.", e);
        }
    }

    private List<Comment> createCommentsFromResults(ResultSet rs) {
        List<Comment> comments = new ArrayList<>();
        try {
            while (rs.next()) {
                comments.add(extractComment(rs));
            }
            return comments;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving comments.", e);
        }
    }

    private Comment extractComment(ResultSet rs) {
        try {
            return new Comment(
                    rs.getLong("id"),
                    rs.getLong("user_id"),
                    rs.getLong("ad_id"),
                    rs.getString("comment")
            );
        } catch (SQLException e) {
            throw new RuntimeException("Error extracting comment.", e);
        }
    }

    @Override
    public List<Comment> getCommentsByUser(long userId) {
        try {
            String query = "SELECT * FROM comments WHERE user_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, userId);
            ResultSet rs = stmt.executeQuery();
            return createCommentsFromResults(rs);
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving comments.", e);
        }
    }

    @Override
    public HashMap<String, User> mapCommentToUsers(long adId) {
        try {
            String query = "SELECT username, users.id, users.first_name, users.last_name, comment FROM users JOIN comments ON users.id = comments.user_id JOIN ads ON comments.ad_id = ads.id WHERE ad_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setLong(1, adId);
            ResultSet rs = stmt.executeQuery();
            HashMap<String, User> commentMap = new HashMap<>();
            while (rs.next()) {
                User user =
                        new User(
                                rs.getString("username"),
                                rs.getLong("id"),
                                rs.getString("first_name"),
                                rs.getString("last_name")

                        );
                commentMap.put(rs.getString("comment"), user);
            }
            return commentMap;
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving comments.", e);
        }
    }
}
