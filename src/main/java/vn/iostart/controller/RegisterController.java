package vn.iostart.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iostart.service.IUserService;
import vn.iostart.service.impl.UserServiceImpl;
import vn.iostart.util.Constant;
import vn.iostart.util.ValidationUtil;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    session = req.getSession(true);
                    session.setAttribute("username", cookie.getValue());
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    return;
                }
            }
        }
        req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        if (confirmPassword == null) {
            confirmPassword = req.getParameter("repassword");
        }
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // 1. Validation dữ liệu đầu vào
        String alertMsg = null;
        if (!ValidationUtil.isValidUsername(username)) {
            alertMsg = "Tên đăng nhập phải từ 4-20 ký tự, chỉ gồm chữ, số và dấu gạch dưới!";
        } else if (ValidationUtil.isBlank(fullname)) {
            alertMsg = "Họ và tên không được để trống!";
        } else if (!ValidationUtil.isValidEmail(email)) {
            alertMsg = "Địa chỉ Email không đúng định dạng!";
        } else if (!ValidationUtil.isValidPhone(phone)) {
            alertMsg = "Số điện thoại không hợp lệ (phải gồm 10 chữ số, bắt đầu bằng 0 hoặc +84)!";
        } else if (!ValidationUtil.isValidPassword(password)) {
            alertMsg = "Mật khẩu phải có ít nhất 6 ký tự!";
        } else if (confirmPassword != null && !password.equals(confirmPassword)) {
            alertMsg = "Mật khẩu nhập lại không khớp!";
        }

        if (alertMsg != null) {
            forwardWithError(req, resp, alertMsg, username, email, fullname, phone);
            return;
        }

        username = username.trim();
        email = email.trim();
        fullname = fullname.trim();
        phone = phone.trim();

        IUserService service = new UserServiceImpl();

        // 2. Kiểm tra trùng lặp trong Database
        if (service.checkExistEmail(email)) {
            forwardWithError(req, resp, "Email đã tồn tại!", username, email, fullname, phone);
            return;
        }

        if (service.checkExistUsername(username)) {
            forwardWithError(req, resp, "Tài khoản đã tồn tại!", username, email, fullname, phone);
            return;
        }

        // 3. Đăng ký và chuyển sang xác thực OTP
        boolean isSuccess = service.register(email, password, username, fullname, phone);
        if (isSuccess) {
            req.getSession().setAttribute("pendingEmail", email);
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            forwardWithError(req, resp, "System error!", username, email, fullname, phone);
        }
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse resp, String alertMsg,
            String username, String email, String fullname, String phone) throws ServletException, IOException {
        req.setAttribute("alert", alertMsg);
        req.setAttribute("username", username);
        req.setAttribute("email", email);
        req.setAttribute("fullname", fullname);
        req.setAttribute("phone", phone);
        req.getRequestDispatcher(Constant.REGISTER).forward(req, resp);
    }
}