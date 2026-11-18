package vn.iostart.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iostart.config.JPAConfig;
import vn.iostart.dao.IVideoDao;
import vn.iostart.entity.Video;

public class VideoDao implements IVideoDao {

    @Override
    public void insert(Video video) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Video video) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int videoId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video video = em.find(Video.class, videoId);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }

    @Override
    public Video findById(int videoId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            return em.find(Video.class, videoId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findLatestVideos(int limit) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.videoId DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setMaxResults(limit);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video> findByUserId(int userId, int page, int pageSize) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT v FROM Video v WHERE v.user.id = :userId ORDER BY v.videoId DESC";
            TypedQuery<Video> query = em.createQuery(jpql, Video.class);
            query.setParameter("userId", userId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByUserId(int userId) {
        EntityManager em = JPAConfig.getEntityManager();
        try {
            String jpql = "SELECT COUNT(v) FROM Video v WHERE v.user.id = :userId";
            TypedQuery<Long> query = em.createQuery(jpql, Long.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public void incrementViews(int videoId) {
        EntityManager em = JPAConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.createQuery("UPDATE Video v SET v.views = COALESCE(v.views, 0) + 1 WHERE v.videoId = :id")
              .setParameter("id", videoId)
              .executeUpdate();
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }
}