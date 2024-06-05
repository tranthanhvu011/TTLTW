package dao;

import config.JDBIConnector;
import model.Account;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServlet;
import java.sql.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class UserDAO {

    public List<Account> getAllUsers(   int limit, int offset) {

        String query = "SELECT * FROM accounts limit ? offset ?";

        List<Account> users = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, limit)
                        .bind(1, offset)
                        .mapToBean(Account.class)
                        .list());
        return users.isEmpty() ? null : users;
    }

    public static boolean checkLogin(String email, String password) {
        String query = "select password from accounts where email = :email";
        try {
            String hashedPassword = JDBIConnector.me().withHandle(handle ->
                    handle.createQuery(query)
                            .bind("email", email)
                            .mapTo(String.class)
                            .one()
            );
            // Kiểm tra mật khẩu đã nhập với hash mật khẩu trong cơ sở dữ liệu
            return BCrypt.checkpw(password, hashedPassword);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Account findUserByEmailAndPassword(String email, String password) {
        String query = "SELECT * FROM Accounts WHERE email = ?";
        try {
            Optional<Account> user = JDBIConnector.me().withHandle(handle -> {
                return handle.createQuery(query)
                        .bind(0, email)
                        .mapToBean(Account.class)
                        .findFirst();
            });

            if (user.isPresent() && BCrypt.checkpw(password, user.get().getPassword())) {
                return user.get();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Account> findUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM accounts WHERE email = ?";
        List<Account> users = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, email)
                    .mapToBean(Account.class)
                    .list();
        });
        return users.isEmpty() ? null : users;
    }
    public boolean updateIPAndCountry(String ip, String country, String userEmail) {
        String query = "update accounts set lastIPLogin = ?, countryLoginByIp = ?,last_login = CURRENT_TIMESTAMP where email = ?";
        int count = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, ip)
                        .bind(1, country)
                        .bind(2, userEmail)
                        .execute()
        );
        return count > 0;
    }

    public static boolean save(Account user) throws SQLException {
        String query = "INSERT INTO Accounts (email,first_name,last_name,password,address,gender,dob,phone_number,role,is_active, lastIPLogin, countryLoginByIp) VALUES (?,?,?, ?, ?, ?,?, ?, ?, ?, ?,?)";
        int rowUpdated = 0;
        if (user.getRole() == null) {
            user.setRole("user");
        }
        rowUpdated = JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, user.getEmail())
                    .bind(1, user.getFirst_name())
                    .bind(2, user.getLast_name())
                    .bind(3, user.getPassword())
                    .bind(4, user.getAddress())
                    .bind(5, user.getGender())
                    .bind(6, user.getDob())
                    .bind(7, user.getPhone_number())
                    .bind(8, user.getRole())
                    .bind(9, user.getIs_active())
                    .bind(10, user.getLastIPLogin())
                    .bind(11, user.getCountryLoginByIp())
                    .execute();
        });
        return rowUpdated > 0;
    }

    public static int Update_Active(String email, int active) throws Exception {
        int rowsUpdated = JDBIConnector.me().inTransaction(handle -> {
            return handle.createUpdate("UPDATE accounts SET is_active = ? WHERE email = ?")
                    .bind(0, active)
                    .bind(1, email)
                    .execute();
        });
        return rowsUpdated;
    }

    public int activeUserById(int idUser) {
        int rowUpdated = 0;
        String query = "UPDATE Accounts SET is_active = 1 WHERE id = ?";
        rowUpdated = JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, idUser)
                    .execute();
        });
        return rowUpdated;
    }

    public int blockUserById(int idUser) {
        int rowUpdated = 0;
        String query = "UPDATE Accounts SET is_active = 0 WHERE id = ?";
        rowUpdated = JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate(query)
                    .bind(0, idUser).execute();
        });
        return rowUpdated;
    }

    public Account getUserById(int idUser) {
        String query = "SELECT * FROM Accounts WHERE id = ?";
        Optional<Account> user = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, idUser)
                    .mapToBean(Account.class)
                    .findFirst();
        });
        return user.orElse(null);
    }

    public int updateUserById(int idUser, Map<String, Object> user1) {
        StringBuffer stringBuffer = new StringBuffer();
        user1.forEach((key, value) -> {
            stringBuffer.append(key).append(" = ");
            if (String.class.isAssignableFrom(value.getClass())) {
                stringBuffer.append("'").append(value).append("',");
            } else {
                stringBuffer.append(value).append(",");
            }
        });
        String query = "UPDATE Accounts SET " + stringBuffer.substring(0, stringBuffer.length() - 1) + " WHERE id = ?";
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, idUser)
                        .execute()
        );
    }

//    public static void main(String[] args) {
//        UserDAO userDAO = new UserDAO();
//        try {
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    public int deleteUserById(int idUser) {
        String query = "DELETE FROM Accounts WHERE id = ?";
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query).
                        bind(0, idUser).
                        execute());
    }

    public List<Account> searchUserWithCondition(String keyword) {

        System.out.println("Key" + keyword);
        String query = "SELECT * FROM Accounts WHERE email LIKE :searchItem OR first_name LIKE :searchItem OR last_name LIKE :searchItem OR phone_number LIKE :searchItem";

        List<Account> users = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind("searchItem", keyword)
                        .mapToBean(Account.class)
                        .list());
        return users.isEmpty() ? null : users;
    }

    public void updatePassword(String userEmail, String hashedPassword) {
        JDBIConnector.me().inTransaction(handle -> {
            handle.execute("UPDATE accounts SET password = ? WHERE email = ?", hashedPassword, userEmail);
            return null;
        });
    }

    public boolean emailExists(String userEmail) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM accounts WHERE email = ?")
                        .bind(0, userEmail)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0) > 0
        );
    }

    public boolean checkPassword(String email, String oldPassword) {
        try {
            return JDBIConnector.me().withHandle(handle -> {
                String query = "SELECT password FROM accounts WHERE email = :email";
                String storedHashedPassword = handle.createQuery(query)
                        .bind("email", email)
                        .mapTo(String.class)
                        .findOne()
                        .orElse(null);

                if (storedHashedPassword == null) {
                    return false;
                }
                return BCrypt.checkpw(oldPassword, storedHashedPassword);
            });
        } catch (Exception e) {
            // Log: lỗi xảy ra khi thực hiện truy vấn
            return false;
        }
    }

    public boolean updatePasswordChange(String email, String newHashedPassword) {
        try {
            return JDBIConnector.me().inTransaction(handle -> {
                String query = "UPDATE accounts SET password = :password WHERE email = :email";
                int updatedRows = handle.createUpdate(query)
                        .bind("email", email)
                        .bind("password", newHashedPassword)
                        .execute();
                return updatedRows > 0;
            });
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateProfile(String email, String firstName, String lastName, String address, String phoneNumber, String dob, String gender) {
        try {
            return JDBIConnector.me().inTransaction(handle -> {
                String query = "UPDATE accounts SET first_name = :firstName, last_name = :lastName, address = :address, " +
                        "phone_number = :phoneNumber, dob = :dob, Gender = :gender WHERE email = :email";
                handle.createUpdate(query)
                        .bind("firstName", firstName)
                        .bind("lastName", lastName)
                        .bind("address", address)
                        .bind("phoneNumber", phoneNumber)
                        .bind("dob", dob)
                        .bind("gender", gender)
                        .bind("email", email)
                        .execute();
                return true; // Trả về true nếu cập nhật thành công
            });
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra màn hình hoặc xử lý lỗi theo cách bạn muốn
            return false; // Trả về false nếu xảy ra lỗi
        }
    }

    public int countNumberPage() {
        String query = "SELECT COUNT(*) FROM accounts";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .mapTo(Integer.class)
                        .findOne()
                        .orElse(0)
        );
    }
}
