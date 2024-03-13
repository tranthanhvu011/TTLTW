package dao;

import config.JDBIConnector;
import model.PasswordResetCode;
import org.jdbi.v3.core.Jdbi;

import java.time.LocalDateTime;
import java.util.Optional;

public class EmailDAO {
    private static final Jdbi jdbi = JDBIConnector.me();
    public EmailDAO() {
        // Cấu hình bổ sung nếu cần
    }

    /**
     * Thêm mã xác nhận và thời gian hết hạn cho email người dùng vào cơ sở dữ liệu.
     *
     * @param userEmail Email của người dùng.
     * @param code      Mã xác nhận.
     * @param expirationTime Thời gian hết hạn của mã xác nhận.
     */
    public void addVerificationCode(String userEmail, String code, LocalDateTime expirationTime) {
        jdbi.useHandle(handle ->
                handle.execute("INSERT INTO passwordresetcodes (email, code, expiration_time) VALUES (?, ?, ?)",
                        userEmail, code, expirationTime)
        );
    }
    /**
     * Lấy mã xác nhận và thời gian hết hạn dựa trên email người dùng.
     *
     * @param userEmail Email của người dùng.
     * @return Optional chứa thông tin mã xác nhận và thời gian hết hạn, nếu có.
     */
    public Optional<PasswordResetCode> getVerificationCode(String userEmail) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT code, expiration_time FROM passwordresetcodes WHERE email = ?")
                        .bind(0, userEmail)
                        .map((rs, ctx) -> new PasswordResetCode(
                                rs.getString("code"),
                                rs.getTimestamp("expiration_time").toLocalDateTime()))
                        .findOne()
        );
    }

    /**
     * Xóa mã xác nhận cho email người dùng khỏi cơ sở dữ liệu.
     *
     * @param userEmail Email của người dùng.
     */
    public void deleteVerificationCode(String userEmail) {
        jdbi.useHandle(handle ->
                handle.execute("DELETE FROM passwordresetcodes WHERE email = ?", userEmail)
        );
    }
    public static Optional<PasswordResetCode> getLatestVerificationCode(String userEmail) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT code, expiration_time FROM passwordresetcodes WHERE email = ? ORDER BY id DESC LIMIT 1")
                        .bind(0, userEmail)
                        .map((rs, ctx) -> new PasswordResetCode(
                                rs.getString("code"),
                                rs.getTimestamp("expiration_time").toLocalDateTime()))
                        .findFirst()
        );
    }

    public static boolean validateVerificationCode(String userEmail, String code) {
        Optional<PasswordResetCode> resetCode = getLatestVerificationCode(userEmail);
        if (!resetCode.isPresent()) {
            return false;
        }
        boolean codeMatches = resetCode.get().getCode().equals(code);
        boolean codeNotExpired = resetCode.get().getExpirationTime().isAfter(LocalDateTime.now());
        return codeMatches && codeNotExpired;
    }


    // Các phương thức khác liên quan đến việc xử lý mã xác nhận

    /**
     * Cập nhật mã xác nhận và thời gian hết hạn cho email người dùng.
     *
     * @param userEmail Email của người dùng.
     * @param newCode   Mã xác nhận mới.
     * @param newExpirationTime Thời gian hết hạn mới.
     */
    public void updateVerificationCode(String userEmail, String newCode, LocalDateTime newExpirationTime) {
        jdbi.useHandle(handle ->
                handle.execute("UPDATE passwordresetcodes SET code = ?, expiration_time = ? WHERE email = ?",
                        newCode, newExpirationTime, userEmail)
        );
    }
    /**
     * Kiểm tra xem mã xác nhận có hết hạn hay không.
     *
     * @param code Mã xác nhận cần kiểm tra.
     * @return true nếu mã đã hết hạn, false nếu còn hạn.
     */
    public boolean isCodeExpired(String code) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT expiration_time FROM passwordresetcodes WHERE code = ?")
                        .bind(0, code)
                        .mapTo(LocalDateTime.class)
                        .findOne()
                        .map(expirationTime -> expirationTime.isBefore(LocalDateTime.now()))
                        .orElse(true)
        );
    }

    /**
     * Xóa tất cả các mã xác nhận hết hạn.
     */
    public void deleteExpiredVerificationCodes() {
        jdbi.useHandle(handle ->
                handle.execute("DELETE FROM passwordresetcodes WHERE expiration_time < ?", LocalDateTime.now())
        );
    }
    /**
     * Xóa mã xác nhận cụ thể bằng code.
     *
     * @param code Mã xác nhận cần xóa.
     */
    public void deleteVerificationCodeByCode(String code) {
        jdbi.useHandle(handle ->
                handle.execute("DELETE FROM passwordresetcodes WHERE code = ?", code)
        );
    }

}

