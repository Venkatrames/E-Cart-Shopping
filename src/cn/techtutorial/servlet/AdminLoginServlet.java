package cn.techtutorial.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hardcoded admin credentials (you can replace with DB authentication)
    private static final String ADMIN_EMAIL = "admin@example.com";
    private static final String ADMIN_PASSWORD = "admin123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check admin credentials
        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin-auth", true);
            response.sendRedirect("admin.jsp"); // Redirect to Admin Dashboard
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}
