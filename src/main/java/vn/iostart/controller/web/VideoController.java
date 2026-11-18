package vn.iostart.controller.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iostart.entity.User;
import vn.iostart.entity.Video;
import vn.iostart.service.IVideoService;
import vn.iostart.service.impl.VideoServiceImpl;
import vn.iostart.util.Constant;

@WebServlet(urlPatterns = { "/video", "/video/detail", "/video/add", "/video/edit", "/video/delete" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,    // 2MB
    maxFileSize = 1024 * 1024 * 100,        // 100MB
    maxRequestSize = 1024 * 1024 * 150      // 150MB
)
public class VideoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IVideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        // 1. Chi tiết và phát video (/video/detail?id=...)
        if (uri.endsWith("/video/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            videoService.incrementViews(id);
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/web/video-detail.jsp").forward(req, resp);
            return;
        }

        // Bắt buộc đăng nhập cho trang /video cá nhân và CRUD
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Form thêm video
        if (uri.endsWith("/video/add")) {
            req.getRequestDispatcher("/views/web/video-form.jsp").forward(req, resp);
            return;
        }

        // 3. Form sửa video
        if (uri.endsWith("/video/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.getRequestDispatcher("/views/web/video-form.jsp").forward(req, resp);
            return;
        }

        // 4. Xóa video
        if (uri.endsWith("/video/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            videoService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/video");
            return;
        }

        // 5. Danh sách video của user phân trang 6 video/trang (/video)
        int page = 1;
        int pageSize = 6;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        List<Video> videos = videoService.findByUserId(user.getId(), page, pageSize);
        long totalVideos = videoService.countByUserId(user.getId());
        int totalPages = (int) Math.ceil((double) totalVideos / pageSize);

        req.setAttribute("videos", videos);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/views/web/video-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uploadPath = Constant.UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            String videoIdStr = req.getParameter("videoId");
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            boolean active = Boolean.parseBoolean(req.getParameter("active"));

            // Xử lý file ảnh Poster
            String posterFileName = null;
            Part posterPart = req.getPart("posterFile");
            if (posterPart != null && posterPart.getSize() > 0 && posterPart.getSubmittedFileName() != null && !posterPart.getSubmittedFileName().isEmpty()) {
                String rawPoster = Paths.get(posterPart.getSubmittedFileName()).getFileName().toString();
                posterFileName = System.currentTimeMillis() + "_img_" + rawPoster;
                posterPart.write(uploadPath + File.separator + posterFileName);
            }

            // Xử lý file Video (.mp4)
            String videoFileName = null;
            Part videoPart = req.getPart("videoFile");
            if (videoPart != null && videoPart.getSize() > 0 && videoPart.getSubmittedFileName() != null && !videoPart.getSubmittedFileName().isEmpty()) {
                String rawVideo = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
                videoFileName = System.currentTimeMillis() + "_vid_" + rawVideo;
                videoPart.write(uploadPath + File.separator + videoFileName);
            }

            Video video;
            if (videoIdStr != null && !videoIdStr.isEmpty()) {
                video = videoService.findById(Integer.parseInt(videoIdStr));
            } else {
                video = new Video();
                video.setViews(0);
                video.setUser(user);
            }

            video.setTitle(title);
            video.setDescription(description);
            video.setActive(active);
            if (posterFileName != null) video.setPoster(posterFileName);
            if (videoFileName != null) video.setVideoUrl(videoFileName);

            if (videoIdStr != null && !videoIdStr.isEmpty()) {
                videoService.update(video);
            } else {
                videoService.insert(video);
            }

            resp.sendRedirect(req.getContextPath() + "/video");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi lưu video: " + e.getMessage());
            req.getRequestDispatcher("/views/web/video-form.jsp").forward(req, resp);
        }
    }
}