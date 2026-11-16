package vn.iostart.service.impl;

import java.sql.Date;
import vn.iostart.dao.IUserDao;
import vn.iostart.dao.impl.UserDao;
import vn.iostart.entity.User;
import vn.iostart.service.IUserService;
import vn.iostart.util.EmailUtil;
import vn.iostart.util.PasswordUtil;

public class UserServiceImpl implements IUserService {
    IUserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        // Kiểm tra user tồn tại, khớp mật khẩu hash và đã kích hoạt OTP (status == true)
        if (user != null && PasswordUtil.checkPassword(password, user.getPassWord()) && user.getStatus()) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        String otp = EmailUtil.generateOTP();

        User user = new User();
        user.setEmail(email);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPassWord(PasswordUtil.hashPassword(password)); // Hash mật khẩu
        user.setAvatar(null);
        user.setRoleid(3);
        user.setPhone(phone);
        user.setCreatedDate(date);
        user.setStatus(false); // Chưa kích hoạt
        user.setOtpCode(otp);

        userDao.insert(user);
        EmailUtil.sendEmail(email, "Ma OTP kich hoat tai khoan", "Ma xac thuc cua ban la: " + otp);
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user != null && otp != null && otp.equals(user.getOtpCode())) {
            user.setStatus(true);
            user.setOtpCode(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendForgotPasswordOtp(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }
        String otp = EmailUtil.generateOTP();
        user.setOtpCode(otp);
        userDao.update(user);
        return EmailUtil.sendEmail(email, "Ma OTP khoi phuc mat khau", "Ma OTP dat lai mat khau cua ban la: " + otp);
    }

    @Override
    public boolean resetPasswordWithOtp(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user != null && otp != null && otp.equals(user.getOtpCode())) {
            user.setPassWord(PasswordUtil.hashPassword(newPassword));
            user.setOtpCode(null);
            user.setStatus(true);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean checkExistEmail(String email) { return userDao.checkExistEmail(email); }

    @Override
    public boolean checkExistUsername(String username) { return userDao.checkExistUsername(username); }

    @Override
    public boolean checkExistPhone(String phone) { return userDao.checkExistPhone(phone); }

    @Override
    public void updatePassword(String email, String newPassword) {
        userDao.updatePassword(email, PasswordUtil.hashPassword(newPassword));
    }
}