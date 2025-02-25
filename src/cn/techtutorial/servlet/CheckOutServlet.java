package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.OrderDao;
import cn.techtutorial.model.Cart;
import cn.techtutorial.model.Order;
import cn.techtutorial.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Ensure both GET & POST work
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
            User auth = (User) request.getSession().getAttribute("auth");

            if (cart_list != null && auth != null) {
                String orderId = "ORD" + System.currentTimeMillis(); // Generate Order ID
                String deliveryDate = formatter.format(new Date(System.currentTimeMillis() + (3 * 24 * 60 * 60 * 1000))); // 3 days later

                for (Cart c : cart_list) {
                    Order order = new Order();
                    order.setId(c.getId());
                    order.setUid(auth.getId());
                    order.setQunatity(c.getQuantity());
                    order.setDate(formatter.format(date));

                    OrderDao oDao = new OrderDao(DbCon.getConnection());
                    boolean result = oDao.insertOrder(order);
                    if (!result) break;
                }

                // ✅ Send Confirmation Email AFTER Order is Placed
                sendOrderConfirmationEmail(auth.getEmail(), orderId, deliveryDate);

                cart_list.clear();
                response.sendRedirect("orders.jsp");
            } else {
                if (auth == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                response.sendRedirect("cart.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private void sendOrderConfirmationEmail(String userEmail, String orderId, String deliveryDate) {
    	 // Email credentials (Replace with actual credentials)
        final String senderEmail = "209y1a0438@ksrmce.ac.in";  // Admin Email (Sender)
        final String senderPassword = "Ramesh123";  // Generate an App Password

        // SMTP Properties
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        // Create a session
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        boolean mailSent = false;

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject("Order Confirmation - " + orderId);
            message.setText("Thank you for your order!\n\n"
                    + "Your order " + orderId + " has been placed successfully.\n"
                    + "Estimated Delivery Date: " + deliveryDate + "\n\n"
                    + "We appreciate your business and look forward to serving you again!");

            Transport.send(message);
            System.out.println("✅ Order confirmation email sent successfully!");
            mailSent = true; // Email sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            mailSent = false; // Email failed
        }
    }
}
