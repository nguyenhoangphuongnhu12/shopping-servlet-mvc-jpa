package vn.iostart.util;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {
    private static final String FROM_EMAIL = "nguyenhoangphuongnhu12@gmail.com"; // Thay Gmail của bạn
    private static final String APP_PASSWORD = "xdko zjzy fydd qtpf"; // Thay App Password 16 ký tự

    public static String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    public static boolean sendEmail(String toEmail, String subject, String body) {
        System.out.println(">>> ĐANG GỬI OTP TỚI [" + toEmail + "]: " + body);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL.trim(), APP_PASSWORD.replace(" ", ""));
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL.trim()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail.trim()));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            System.out.println(">>> GỬI MAIL THÀNH CÔNG!");
            return true;
        } catch (MessagingException e) {
            System.out.println(">>> LỖI GỬI MAIL: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}