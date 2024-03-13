package service;

import dao.EmailDAO;
import dao.UserDAO;
import model.Account;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;
import java.util.Random;

public class PasswordResetService {
    private EmailDAO emailDAO;
    private UserDAO userDAO;

    public PasswordResetService(EmailDAO emailDAO, UserDAO userDAO) {
        this.emailDAO = emailDAO;
        this.userDAO = userDAO;
    }

    public String createAndSendResetCode(String userEmail) {
        String resetCode = generateResetCode();
        LocalDateTime expirationTime = LocalDateTime.now().plusHours(1); // Mã hết hạn sau 1 giờ
        emailDAO.addVerificationCode(userEmail, resetCode, expirationTime);
        EmailSender.sendEmail(
                userEmail,
                "Quen Mat Khau",
                "GIFTCODE CUA BAN LA " + resetCode + " THOI GIAN 1 PHUT HET HAN "
        );
        return resetCode;
    }
    private String generateResetCode() {
        return String.format("%06d", new Random().nextInt(999999));
    }
    public boolean verifyResetCode(String userEmail, String code) {
        return emailDAO.validateVerificationCode(userEmail, code);
    }
    public boolean resetPassword(String userEmail, String code, String newPassword) {
        if (verifyResetCode(userEmail, code)) {
            String hashedPassword = hashPassword(newPassword);
            userDAO.updatePassword(userEmail, hashedPassword); // Sử dụng thực thể userDAO, không phải UserDAO static
            emailDAO.deleteVerificationCode(userEmail);
            return true;
        }
        return false;
    }
    private String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }
    public boolean emailExists(String userEmail) {
        return userDAO.emailExists(userEmail);
    }
}