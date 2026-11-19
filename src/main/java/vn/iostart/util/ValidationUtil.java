package vn.iostart.util;

public class ValidationUtil {
    public static boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static boolean isValidUsername(String username) {
        return !isBlank(username) && username.trim().matches("^[a-zA-Z0-9_]{4,20}$");
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    public static boolean isValidEmail(String email) {
        return !isBlank(email) && email.trim().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$");
    }

    public static boolean isValidPhone(String phone) {
        return !isBlank(phone) && phone.trim().matches("^(0|\\+84)[0-9]{9}$");
    }

    public static boolean isValidOtp(String otp) {
        return !isBlank(otp) && otp.trim().matches("^[0-9]{6}$");
    }

    public static boolean isImageFile(String fileName) {
        if (isBlank(fileName)) return false;
        String lower = fileName.toLowerCase();
        return lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png") || lower.endsWith(".webp");
    }

    public static boolean isVideoFile(String fileName) {
        return !isBlank(fileName) && fileName.toLowerCase().endsWith(".mp4");
    }
}