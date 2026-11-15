package vn.iostart.dao.impl;

import jakarta.persistence.*;
import vn.iostart.config.JPAConfig;
import vn.iostart.dao.IUserDao;
import vn.iostart.entity.User;

public class UserDao implements IUserDao {
    @Override
    public User get(String username) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u WHERE u.userName = :username", User.class);
            query.setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public void insert(User user) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            Long count = enma.createQuery("SELECT count(u) FROM User u WHERE u.email = :email", Long.class)
                             .setParameter("email", email).getSingleResult();
            return count > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            Long count = enma.createQuery("SELECT count(u) FROM User u WHERE u.userName = :username", Long.class)
                             .setParameter("username", username).getSingleResult();
            return count > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            Long count = enma.createQuery("SELECT count(u) FROM User u WHERE u.phone = :phone", Long.class)
                             .setParameter("phone", phone).getSingleResult();
            return count > 0;
        } finally {
            enma.close();
        }
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Query query = enma.createQuery("UPDATE User u SET u.passWord = :newPass WHERE u.email = :email");
            query.setParameter("newPass", newPassword);
            query.setParameter("email", email);
            query.executeUpdate();
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
        } finally {
            enma.close();
        }
    }
}