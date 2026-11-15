package vn.iostart.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iostart.util.Constant;

@WebServlet(urlPatterns = "/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hủy session
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("account");
            session.invalidate();
        }

        // Xóa Cookie Remember Me
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(Constant.COOKIE_REMEMBER)) {
                    cookie.setMaxAge(0);
                    cookie.setPath(req.getContextPath());
                    resp.addCookie(cookie);
                }
            }
        }

        // Chuyển về lại trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}