package vn.iostart.dao;

import vn.iostart.entity.User;

public interface IUserDao {
    User get(String username);
    void insert(User user);
    boolean checkExistEmail(String email);
    boolean checkExistUsername(String username);
    boolean checkExistPhone(String phone);
    void updatePassword(String email, String newPassword);
    User findByEmail(String email);
    void update(User user);
}