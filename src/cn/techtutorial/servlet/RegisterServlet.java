package cn.techtutorial.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.UserDao;
import cn.techtutorial.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();

        if (!password.equals(confirmPassword)) {
            session.setAttribute("message", "Passwords do not match!");
            response.sendRedirect("register.jsp");
            return;
        }

        try {
            Connection con = DbCon.getConnection();
            UserDao userDao = new UserDao(con);
            
            if (userDao.checkUserExists(email)) {
                session.setAttribute("message", "Email already registered!");
                response.sendRedirect("register.jsp");
            } else {
                User user = new User(name, email, password);
                if (userDao.registerUser(user)) {
                    session.setAttribute("message", "Registration successful! Please log in.");
                    response.sendRedirect("login.jsp");
                } else {
                    session.setAttribute("message", "Registration failed, try again.");
                    response.sendRedirect("register.jsp");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            session.setAttribute("message", "Database error!");
            response.sendRedirect("register.jsp");
        }
    }
}

