package vn.iostart.service.impl;

import java.sql.Date;
import vn.iostart.dao.IUserDao;
import vn.iostart.dao.impl.UserDao;
import vn.iostart.entity.User;
import vn.iostart.service.IUserService;

public class UserServiceImpl implements IUserService {
    IUserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) { return userDao.get(username); }

    @Override
    public void insert(User user) { userDao.insert(user); }

    @Override
    public boolean register(String email, String password, String username, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        userDao.insert(new User(email, username, fullname, password, null, 3, phone, date));
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) { return userDao.checkExistEmail(email); }

    @Override
    public boolean checkExistUsername(String username) { return userDao.checkExistUsername(username); }

    @Override
    public boolean checkExistPhone(String phone) { return userDao.checkExistPhone(phone); }

    @Override
    public void updatePassword(String email, String newPassword) { userDao.updatePassword(email, newPassword); }
}