package model;

import java.time.LocalDateTime;

public class PasswordResetCode {
    private String code;
    private LocalDateTime expirationTime;

    public PasswordResetCode(String code, LocalDateTime expirationTime) {
        this.code = code;
        this.expirationTime = expirationTime;
    }

    public String getCode() {
        return code;
    }

    public LocalDateTime getExpirationTime() {
        return expirationTime;
    }

    public void setCode(String code) {

        this.code = code;
    }

    public void setExpirationTime(LocalDateTime expirationTime) {
        this.expirationTime = expirationTime;
    }


}