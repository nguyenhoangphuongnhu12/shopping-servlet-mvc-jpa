package vn.iostart.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iostart.service.IUserService;
import vn.iostart.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/forgot-password".equals(path)) {
            req.getRequestDispatcher("/views/forgot_password.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/reset_password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        IUserService service = new UserServiceImpl();

        if ("/forgot-password".equals(path)) {
            String email = req.getParameter("email");
            if (service.sendForgotPasswordOtp(email)) {
                req.getSession().setAttribute("resetEmail", email);
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/forgot_password.jsp").forward(req, resp);
            }
        } else if ("/reset-password".equals(path)) {
            String email = (String) req.getSession().getAttribute("resetEmail");
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");

            if (email != null && service.resetPasswordWithOtp(email, otp, newPassword)) {
                req.getSession().removeAttribute("resetEmail");
                req.setAttribute("alert", "Đổi mật khẩu thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("alert", "Mã OTP không hợp lệ!");
                req.getRequestDispatcher("/views/reset_password.jsp").forward(req, resp);
            }
        }
    }
}