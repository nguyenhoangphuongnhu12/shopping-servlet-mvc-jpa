package vn.iostart.controller;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iostart.util.Constant;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        File file = new File(Constant.DIR + File.separator + fileName);
        if (file.exists()) {
            resp.setContentType("image/jpeg");
            try (FileInputStream in = new FileInputStream(file); OutputStream out = resp.getOutputStream()) {
                in.transferTo(out);
            }
        }
    }
}