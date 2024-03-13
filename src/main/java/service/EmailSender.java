package service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailSender {

    public static boolean sendEmail(String recipientEmail, String subject, String text) {

        // Địa chỉ email và mật khẩu của tài khoản Gmail bạn sẽ sử dụng để gửi email
        final String username = "vutranorhilsun@gmail.com";
        final String password = "neycdgkvxxcwnfuq";

        // Cài đặt các thuộc tính cho session
        Properties props = new Properties();
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo session với thông tin xác thực
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("vutranorhilsun@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setText(text);
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace(); // Xử lý lỗi ở đây
        }
        return false;
    }
//        public static void main(String[] args) {
//            String toEmail = "vipnrorg@gmail.com";
//            String subject = "Test Email";
//            String message = "Anh Vu Dep Trai";
//
//            EmailSender.sendEmail(toEmail, subject, message);
//            System.out.println("Email sent successfully!");
//
//
//    }
}
