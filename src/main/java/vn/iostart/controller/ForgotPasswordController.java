package vn.iostart.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iostart.service.IUserService;
import vn.iostart.service.impl.UserServiceImpl;
import vn.iostart.util.ValidationUtil;

@WebServlet(urlPatterns = { "/forgot-password", "/reset-password" })
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;

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
        resp.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        IUserService service = new UserServiceImpl();

        if ("/forgot-password".equals(path)) {
            String email = req.getParameter("email");

            // Validation email nhập vào
            if (!ValidationUtil.isValidEmail(email)) {
                req.setAttribute("alert", "Vui lòng nhập đúng định dạng Email!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/forgot_password.jsp").forward(req, resp);
                return;
            }

            email = email.trim();
            if (service.sendForgotPasswordOtp(email)) {
                req.getSession().setAttribute("resetEmail", email);
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/forgot_password.jsp").forward(req, resp);
            }

        } else if ("/reset-password".equals(path)) {
            String email = (String) req.getSession().getAttribute("resetEmail");
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            // Validation phiên làm việc, mã OTP và mật khẩu mới
            String alertMsg = null;
            if (ValidationUtil.isBlank(email)) {
                alertMsg = "Phiên đặt lại mật khẩu đã hết hạn. Vui lòng nhập lại Email!";
            } else if (ValidationUtil.isBlank(otp) || !otp.trim().matches("^\\d{6}$")) {
                alertMsg = "Mã OTP phải gồm đúng 6 chữ số!";
            } else if (!ValidationUtil.isValidPassword(newPassword)) {
                alertMsg = "Mật khẩu mới phải có ít nhất 6 ký tự!";
            } else if (confirmPassword != null && !newPassword.equals(confirmPassword)) {
                alertMsg = "Mật khẩu xác nhận không khớp!";
            }

            if (alertMsg != null) {
                req.setAttribute("alert", alertMsg);
                req.getRequestDispatcher("/views/reset_password.jsp").forward(req, resp);
                return;
            }

            if (service.resetPasswordWithOtp(email, otp.trim(), newPassword)) {
                req.getSession().removeAttribute("resetEmail");
                req.setAttribute("alert", "Đổi mật khẩu thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("alert", "Mã OTP không hợp lệ hoặc đã hết hạn!");
                req.getRequestDispatcher("/views/reset_password.jsp").forward(req, resp);
            }
        }
    }
}