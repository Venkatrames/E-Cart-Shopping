package cn.techtutorial.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.techtutorial.connection.DbCon;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateProductServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection con = DbCon.getConnection()) {
            // Get product details from form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            Double price = Double.parseDouble(request.getParameter("price"));
            Part part = request.getPart("image");
            String newFileName = part.getSubmittedFileName();

            // Define the upload path
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "product-image";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Fetch the existing image name if no new image is uploaded
            String currentImage = null;
            if (newFileName.isEmpty()) {
                String selectQuery = "SELECT image FROM products WHERE id=?";
                PreparedStatement selectPst = con.prepareStatement(selectQuery);
                selectPst.setInt(1, id);
                ResultSet rs = selectPst.executeQuery();
                if (rs.next()) {
                    currentImage = rs.getString("image");
                }
                newFileName = currentImage; // Keep old image if no new image is provided
            } else {
                // Delete old image before uploading a new one
                String oldImagePath = uploadPath + File.separator + currentImage;
                File oldFile = new File(oldImagePath);
                if (oldFile.exists() && !currentImage.equals("default.jpg")) {
                    oldFile.delete();
                }
                // Save the new file
                String filePath = uploadPath + File.separator + newFileName;
                part.write(filePath);
            }

            // Update the product in the database
            String query = "UPDATE products SET name=?, category=?, price=?, image=? WHERE id=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, category);
            pst.setDouble(3, price);
            pst.setString(4, newFileName);
            pst.setInt(5, id);

            int row = pst.executeUpdate();
            if (row > 0) {
                response.getWriter().println("<script>alert('Product updated successfully!'); window.location='admin.jsp';</script>");
            } else {
                response.getWriter().println("<script>alert('Failed to update product!'); window.location='admin.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Something went wrong!'); window.location='admin.jsp';</script>");
        }
    }
}

