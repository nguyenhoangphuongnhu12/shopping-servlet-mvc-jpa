package vn.iostart.controller.web;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iostart.entity.Video;
import vn.iostart.service.IVideoService;
import vn.iostart.service.impl.VideoServiceImpl;

@WebServlet(urlPatterns = "/home")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IVideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Video> latestVideos = videoService.findLatestVideos(10);
        req.setAttribute("videos", latestVideos);
        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}