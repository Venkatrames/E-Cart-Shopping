package cn.techtutorial.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminProductServlet")
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = getAllProducts();
        request.setAttribute("products", productList);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection con = DbCon.getConnection()) {
            String query = "INSERT INTO products (name, category, price, image) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("category"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setString(4, request.getParameter("image"));
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminProductServlet");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection con = DbCon.getConnection()) {
            String query = "UPDATE products SET name=?, category=?, price=?, image=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("category"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setString(4, request.getParameter("image"));
            ps.setInt(5, Integer.parseInt(request.getParameter("id")));
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminProductServlet");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection con = DbCon.getConnection()) {
            String query = "DELETE FROM products WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminProductServlet");
    }

    private List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        try (Connection con = DbCon.getConnection()) {
            String query = "SELECT * FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productList.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getDouble("price"),
                    rs.getString("image")
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return productList;
    }
}
