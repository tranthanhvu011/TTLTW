package service;

public class EmailService {
    public EmailService() {
    }
    public boolean sendEmail(String to, String subject, String content) {
        return EmailSender.sendEmail(to, subject, content);
    }
    public boolean sendEmailRegister(String to, String subject, String content) {
        return EmailSender.sendEmail(to, subject, content);
    }
}
