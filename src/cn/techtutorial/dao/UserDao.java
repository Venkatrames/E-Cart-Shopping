package cn.techtutorial.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cn.techtutorial.model.User;

public class UserDao {
	private Connection con;

	private String query;
    private PreparedStatement pst;
    private ResultSet rs;

	public UserDao(Connection con) {
		this.con = con;
	}
	public boolean registerUser(User user) {
        String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // You should hash this in a real-world application.
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public User userLogin(String email, String password) {
		User user = null;
        try {
            query = "select * from users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if(rs.next()){
            	user = new User();
            	user.setId(rs.getInt("id"));
            	user.setName(rs.getString("name"));
            	user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }
	public boolean checkUserExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        try {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // If count > 0, user exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
