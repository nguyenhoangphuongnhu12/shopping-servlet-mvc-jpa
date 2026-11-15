package vn.iostart.dao.impl;

import java.util.List;
import jakarta.persistence.*;
import vn.iostart.config.JPAConfig;
import vn.iostart.dao.ICategoryDao;
import vn.iostart.entity.Category;

public class CategoryDao implements ICategoryDao {
    @Override
    public void insert(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(category);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy");
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            return enma.find(Category.class, cateid);
        } finally {
            enma.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c WHERE c.categoryname = :catename", Category.class);
            query.setParameter("catename", name);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            return enma.createNamedQuery("Category.findAll", Category.class).getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createQuery("SELECT c FROM Category c WHERE c.categoryname LIKE :catname", Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } finally {
            enma.close();
        }
    }

    @Override
    public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        try {
            Query query = enma.createQuery("SELECT count(c) FROM Category c");
            return ((Long) query.getSingleResult()).intValue();
        } finally {
            enma.close();
        }
    }
}