package vn.iostart.controller.admin;

import java.io.*;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import vn.iostart.entity.Category;
import vn.iostart.service.ICategoryService;
import vn.iostart.service.impl.CategoryServiceImpl;
import vn.iostart.util.Constant;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 25)
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = cateService.findById(id);
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String images = req.getParameter("images");

            Category category = new Category();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String ext = filename.substring(filename.lastIndexOf(".") + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages("avatar.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/update")) {
            int categoryid = Integer.parseInt(req.getParameter("categoryid"));
            String categoryname = req.getParameter("categoryname");
            int status = Integer.parseInt(req.getParameter("status"));
            String images = req.getParameter("images");

            Category category = cateService.findById(categoryid);
            String fileold = category.getImages();

            category.setCategoryname(categoryname);
            category.setStatus(status);

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String ext = filename.substring(filename.lastIndexOf(".") + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + File.separator + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty() && !images.trim().equals(fileold)) {
                    category.setImages(images.trim());
                } else {
                    category.setImages(fileold);
                }
            } catch (Exception e) {
                e.printStackTrace();
                category.setImages(fileold);
            }

            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}