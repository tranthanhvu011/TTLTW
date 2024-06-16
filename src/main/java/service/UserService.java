package service;

import dao.EmailDAO;
import dao.OrderDAO;
import dao.OrderProductVariantDAO;
import dao.UserDAO;
import model.Account;
import org.mindrot.jbcrypt.BCrypt;

import javax.inject.Inject;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class UserService {

    @Inject
    private UserDAO userDAO;

    @Inject
    private OrderProductVariantDAO orderProductVariantDAO;

    @Inject
    private OrderDAO orderDAO;

    public List<Account> getAllUsers(int limit, int offset) {
        userDAO = new UserDAO();
        List<Account> users = userDAO.getAllUsers(limit, offset);
        return users.isEmpty() ? null : users;
    }

    public boolean activeUserById(int idUser) {
        int rowUpdated = userDAO.activeUserById(idUser);
        return rowUpdated > 0;
    }


    public boolean blockUserById(int idUser) {
        int rowUpdated = userDAO.blockUserById(idUser);
        return rowUpdated > 0;
    }


    public Account getUserById(int idUser) {
        return userDAO.getUserById(idUser);
    }

    public boolean updateUserById(int idUser, Map<String, Object> user1) {
        int rowUpdated = userDAO.updateUserById(idUser, user1);
        return rowUpdated > 0;
    }

    public boolean deleteUserById(int idUser) {
        int rowUpdated = userDAO.deleteUserById(idUser);
        return rowUpdated > 0;
    }

    public Account findUserByEmailAndPassword(String email, String password) {
        try {
            return userDAO.findUserByEmailAndPassword(email, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Account> findUserByEmail(String email){
        userDAO = new UserDAO();
        List<Account> list = null;
        try {
            list = userDAO.findUserByEmail(email);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public boolean save(Account user) throws  SQLException {
        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        return userDAO.save(user);
    }
    public List<Account> searchUserWithCondition(String keyword) {

        return userDAO.searchUserWithCondition(keyword);
    }

    public int activateAccount(String email) {
        EmailDAO emailDAO = new EmailDAO();
        emailDAO.deleteVerificationCode(email);
        emailDAO.deleteExpiredVerificationCodes();
        try {
            int rowsUpdated = UserDAO.Update_Active(email, 1);
            if (rowsUpdated > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // Hoặc một mã lỗi khác tùy theo yêu cầu của bạn
        }
    }
    public boolean checkUserEmail(String email) throws SQLException {
        UserDAO userDao2 = new UserDAO();
        List<Account> emailAccount = userDao2.findUserByEmail(email);
        if (emailAccount != null) {
            return false;
        }
        return true;
    }
    public boolean checkPassword(String email, String oldPassword) {
        UserDAO userDaoCheck = new UserDAO();
        return userDaoCheck.checkPassword(email, oldPassword);
    }
    public boolean updatePasswordChange(String email, String oldPassword, String newPassword) {
        UserDAO userDaoCheck = new UserDAO();

        if (!checkPassword(email, oldPassword)) {
            return false;
        }
        newPassword = hashPassword(newPassword);
        return userDaoCheck.updatePasswordChange(email, newPassword);
    }
    private String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }
    public boolean updateProfile(String email, String firstName, String lastName, String address, String phoneNumber, String dob, String gender) {
        UserDAO userDaoCheck = new UserDAO();
        return userDaoCheck.updateProfile(email, firstName, lastName, address, phoneNumber, dob, gender);
    }

    public int countNumberPage() {
        return userDAO.countNumberPage();
    }
}
