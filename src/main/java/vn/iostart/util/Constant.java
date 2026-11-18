package vn.iostart.util;

public class Constant {
    // Khóa lưu tên đăng nhập trong Session và Cookie (dùng cho chức năng ghi nhớ đăng nhập)
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";
    
     // Thư mục trên ổ cứng dùng để lưu trữ file ảnh tải lên
    public static final String DIR = "D:\\LT_Web\\shopping_servelt_service_mvc\\upload";
    
    // Đường dẫn cố định tới các trang giao diện JSP
    public static final String REGISTER = "/views/register.jsp";
    public static final String LOGIN = "/views/login.jsp";

    public static final String UPLOAD_DIRECTORY = "D:\\LT_Web\\shopping_servelt_service_mvc\\upload";
    public static final String DEFAULT_FILENAME = "default.file";
}
