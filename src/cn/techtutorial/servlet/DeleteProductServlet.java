package cn.techtutorial.servlet;

import java.io.IOException;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDao productDao = new ProductDao(DbCon.getConnection());
            boolean success = productDao.deleteProduct(id);

            if (success) {
                response.sendRedirect("admin.jsp?msg=deleted");
            } else {
                response.sendRedirect("admin.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=error");
        }
    }
}
