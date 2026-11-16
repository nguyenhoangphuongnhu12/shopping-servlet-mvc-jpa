package vn.iostart.service;

import vn.iostart.entity.User;

public interface IUserService {
    User login(String username, String password);
    User get(String username);
    void insert(User user);
    boolean register(String email, String password, String username, String fullname, String phone);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    void updatePassword(String email, String newPassword);
    boolean verifyOtp(String email, String otp);
    boolean sendForgotPasswordOtp(String email);
    boolean resetPasswordWithOtp(String email, String otp, String newPassword);
}