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
import vn.iostart.util.ValidationUtil;

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
            boolean isEdit = (videoIdStr != null && !videoIdStr.trim().isEmpty());

            Part posterPart = req.getPart("posterFile");
            Part videoPart = req.getPart("videoFile");

            String rawPoster = (posterPart != null && posterPart.getSize() > 0
                    && posterPart.getSubmittedFileName() != null && !posterPart.getSubmittedFileName().trim().isEmpty())
                    ? Paths.get(posterPart.getSubmittedFileName()).getFileName().toString() : null;

            String rawVideo = (videoPart != null && videoPart.getSize() > 0
                    && videoPart.getSubmittedFileName() != null && !videoPart.getSubmittedFileName().trim().isEmpty())
                    ? Paths.get(videoPart.getSubmittedFileName()).getFileName().toString() : null;

            // 1. Validation dữ liệu form insert / edit
            String validationError = null;
            if (ValidationUtil.isBlank(title)) {
                validationError = "Tiêu đề video không được để trống!";
            } else if (title.trim().length() < 3 || title.trim().length() > 200) {
                validationError = "Tiêu đề video phải từ 3 đến 200 ký tự!";
            } else if (rawPoster != null && !ValidationUtil.isImageFile(rawPoster)) {
                validationError = "Ảnh bìa chỉ chấp nhận định dạng JPG, JPEG, PNG hoặc WEBP!";
            } else if (!isEdit && rawVideo == null) {
                validationError = "Vui lòng chọn file video (.mp4) khi thêm mới!";
            } else if (rawVideo != null && !ValidationUtil.isVideoFile(rawVideo)) {
                validationError = "Hệ thống chỉ hỗ trợ tải lên file video định dạng .mp4!";
            }

            if (validationError != null) {
                Video draft = isEdit ? videoService.findById(Integer.parseInt(videoIdStr)) : new Video();
                draft.setTitle(title);
                draft.setDescription(description);
                draft.setActive(active);
                req.setAttribute("error", validationError);
                req.setAttribute("video", draft);
                req.getRequestDispatcher("/views/web/video-form.jsp").forward(req, resp);
                return;
            }

            // 2. Lưu file sau khi dữ liệu hợp lệ
            String posterFileName = null;
            if (rawPoster != null) {
                posterFileName = System.currentTimeMillis() + "_img_" + rawPoster;
                posterPart.write(uploadPath + File.separator + posterFileName);
            }

            String videoFileName = null;
            if (rawVideo != null) {
                videoFileName = System.currentTimeMillis() + "_vid_" + rawVideo;
                videoPart.write(uploadPath + File.separator + videoFileName);
            }

            Video video;
            if (isEdit) {
                video = videoService.findById(Integer.parseInt(videoIdStr));
            } else {
                video = new Video();
                video.setViews(0);
                video.setUser(user);
            }

            video.setTitle(title.trim());
            video.setDescription(description != null ? description.trim() : "");
            video.setActive(active);
            if (posterFileName != null) video.setPoster(posterFileName);
            if (videoFileName != null) video.setVideoUrl(videoFileName);

            if (isEdit) {
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