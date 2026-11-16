package vn.iostart.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iostart.service.IUserService;
import vn.iostart.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = (String) req.getSession().getAttribute("pendingEmail");
        String otp = req.getParameter("otp");

        IUserService service = new UserServiceImpl();
        if (email != null && service.verifyOtp(email, otp)) {
            req.getSession().removeAttribute("pendingEmail");
            req.setAttribute("alert", "Kích hoạt tài khoản thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Mã OTP không chính xác!");
            req.getRequestDispatcher("/views/verify_otp.jsp").forward(req, resp);
        }
    }
}