package vn.iostart.service.impl;

import java.util.List;
import vn.iostart.dao.IVideoDao;
import vn.iostart.dao.impl.VideoDao;
import vn.iostart.entity.Video;
import vn.iostart.service.IVideoService;

public class VideoServiceImpl implements IVideoService {
    private IVideoDao videoDao = new VideoDao();

    @Override public void insert(Video video) { videoDao.insert(video); }
    @Override public void update(Video video) { videoDao.update(video); }
    @Override public void delete(int videoId) { videoDao.delete(videoId); }
    @Override public Video findById(int videoId) { return videoDao.findById(videoId); }
    @Override public List<Video> findLatestVideos(int limit) { return videoDao.findLatestVideos(limit); }
    @Override public List<Video> findByUserId(int userId, int page, int pageSize) { return videoDao.findByUserId(userId, page, pageSize); }
    @Override public long countByUserId(int userId) { return videoDao.countByUserId(userId); }
    @Override public void incrementViews(int videoId) { videoDao.incrementViews(videoId); }
}