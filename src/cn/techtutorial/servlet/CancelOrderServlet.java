package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.OrderDao;
import cn.techtutorial.model.User;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
          Date date = new Date();

          User auth = (User) request.getSession().getAttribute("auth");
		try(PrintWriter out = response.getWriter()) {
			String id = request.getParameter("id");
			if(id != null) {
				String orderId = "ORD" + System.currentTimeMillis();

                String deliveryDate = formatter.format(new Date(System.currentTimeMillis() + (6 * 24 * 60 * 60 * 1000))); // 3 days later
				OrderDao orderDao = new OrderDao(DbCon.getConnection());
				orderDao.cancelOrder(Integer.parseInt(id));
				
				sendOrderConfirmationEmail(auth.getEmail(), orderId, deliveryDate);
			}
            
			
			response.sendRedirect("orders.jsp");
		} catch (ClassNotFoundException|SQLException e) {
			// TODO Auto-generated catch block
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
           message.setSubject("Order Cancellation - " + orderId);
           message.setText("Thank you for your order!\n\n"
                   + "Your order " + orderId + " has been cancelled successfully.\n"
                   + "Estimated Refund Date: " + deliveryDate + "\n\n"
                   + "If this was a mistake, you can place a new order anytime.\n\n"
                   + "Thank you for using our service!");

           Transport.send(message);
           System.out.println("✅ Order cancellation email sent successfully!");
           mailSent = true; // Email sent successfully
       } catch (MessagingException e) {
           e.printStackTrace();
           mailSent = false; // Email failed
       }
   }

}
