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

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = (String) req.getSession().getAttribute("pendingEmail");
        String otp = req.getParameter("otp");

        // Validation phiên làm việc và định dạng mã OTP
        if (ValidationUtil.isBlank(email)) {
            req.setAttribute("alert", "Phiên xác thực đã hết hạn. Vui lòng đăng ký lại!");
            req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
            return;
        }

        if (ValidationUtil.isBlank(otp) || !otp.trim().matches("^\\d{6}$")) {
            req.setAttribute("alert", "Mã OTP không được để trống và phải gồm đúng 6 chữ số!");
            req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
            return;
        }

        IUserService service = new UserServiceImpl();
        if (service.verifyOtp(email, otp.trim())) {
            req.getSession().removeAttribute("pendingEmail");
            req.setAttribute("alert", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
        }
    }
}