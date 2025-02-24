package cn.techtutorial.servlet;

import java.io.IOException;
import java.util.Properties;

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

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Check if user is logged in
        User auth = (User) request.getSession().getAttribute("auth");
        if (auth == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

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
            // Email to user (confirmation)
            Message userMail = new MimeMessage(session);
            userMail.setFrom(new InternetAddress(senderEmail));
            userMail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            userMail.setSubject("Contact Request Received");
            userMail.setText("Dear " + name + ",\n\nThank you for reaching out! We will solve this issue very soon. Keep using our website...\n\nMessage: " + message + "\n\nBest Regards,\nSupport Team");

            Transport.send(userMail);

            // Email to sender (admin receives the message too)
            Message adminMail = new MimeMessage(session);
            adminMail.setFrom(new InternetAddress(senderEmail));
            adminMail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(senderEmail)); // Admin gets the message too
            adminMail.setSubject("New Contact Request from " + name);
            adminMail.setText("You received a new message from " + name + " (" + email + "):\n\n" + message);

            Transport.send(adminMail);

            mailSent = true; // Email sent successfully
        } catch (MessagingException e) {
            e.printStackTrace();
            mailSent = false; // Email failed
        }

        // Redirect to contact.jsp with popup message
        if (mailSent) {
            response.sendRedirect("contact.jsp?message=success");
        } else {
            response.sendRedirect("contact.jsp?message=failure");
        }
    }

}