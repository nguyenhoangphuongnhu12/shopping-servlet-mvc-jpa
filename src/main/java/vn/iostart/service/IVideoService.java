package vn.iostart.service;

import java.util.List;
import vn.iostart.entity.Video;

public interface IVideoService {
    void insert(Video video);
    void update(Video video);
    void delete(int videoId);
    Video findById(int videoId);
    List<Video> findLatestVideos(int limit);
    List<Video> findByUserId(int userId, int page, int pageSize);
    long countByUserId(int userId);
    void incrementViews(int videoId);
}