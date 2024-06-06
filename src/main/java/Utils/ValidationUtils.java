package Utils;

public class ValidationUtils {
    public static boolean isValidEmail(String email) {
        String emailRegex = "^.+@.+\\..+$";
        return email.matches(emailRegex);
    }

    public static boolean isValidPhone(String phone) {
        String phoneRegex = "^[0-9]{10,11}$";
        return phone.matches(phoneRegex);
    }

    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,20}$";
        return password.matches(passwordRegex);
    }
    public static boolean isValidUsername(String username) {
        String usernameRegex = "^[a-zA-Z0-9._-]{3,}$";
        return username.matches(usernameRegex);
    }
}
