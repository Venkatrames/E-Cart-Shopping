package cn.techtutorial.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import cn.techtutorial.connection.DbCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddProductServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection con = DbCon.getConnection()) {
            // Get product details from form
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            Double price = Double.parseDouble(request.getParameter("price"));
            Part part = request.getPart("image");
            String fileName = part.getSubmittedFileName();

            // Define the dynamic upload path
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "product-image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save file to the directory
            String filePath = uploadPath + File.separator + fileName;
            if (!fileName.isEmpty()) {
                part.write(filePath);
            }

            // Insert into database
            String query = "INSERT INTO products (name, category, price, image) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, category);
            pst.setDouble(3, price);
            pst.setString(4, fileName);

            int row = pst.executeUpdate();
            if (row > 0) {
                response.getWriter().println("<script>alert('Product added successfully!'); window.location='admin.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('Failed to add product!'); window.location='admin.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Something went wrong!'); window.location='admin.jsp';</script>");
        }
    }
}

