package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/Admin/*")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Admin";
        }

        switch (path) {
            case "/Admin":
                ServletUtills.forward("/views/vwAdministrator/AdminManager.jsp", request, response);
                break;

            case "/Product":
                List<Product> productList = ProductModel.findAll();
                request.setAttribute("products", productList);
                ServletUtills.forward("/views/vwAdministrator/AdminProduct.jsp", request, response);
                break;

            case "/User":
                List<User> userList = UserModel.findAll();
                request.setAttribute("users", userList);
                ServletUtills.forward("/views/vwAdministrator/AdminUser.jsp", request, response);
                break;

            case "/Category":
                List<Category> categoryList = CategoryModel.findAll();
                request.setAttribute("categories", categoryList);
                ServletUtills.forward("/views/vwAdministrator/AdminCategory.jsp", request, response);
                break;

            case "/Category/AddCategory":
//                List<Category> listC = CategoryModel.findParent();
//                request.setAttribute("catParent",listC);
                ServletUtills.forward("/views/vwAdministrator/AddCategory.jsp", request, response);
                break;

            case "/Category/EditCategory":
                int id1 = 0;
                try {
                    id1 = Integer.parseInt(request.getParameter("id"));
                }catch (NumberFormatException e){

                }
                Category c1 = CategoryModel.findById(id1);
                if(c1 != null) {
                    request.setAttribute("category", c1);
                    ServletUtills.forward("/views/vwAdministrator/EditCategory.jsp", request, response);
                } else{
                    ServletUtills.forward("/views/204.jsp", request, response);
                }
                break;

            case "/EditUser":
                int id  = Integer.parseInt(request.getParameter("uid"),10);
                User user = UserModel.findById(id);
                request.setAttribute("users",user);
                ServletUtills.forward("/views/vwAdministrator/AdminEditUser.jsp", request, response);
                break;

            case "/Upgrage":
                int bidderid  = Integer.parseInt(request.getParameter("uid"),10);
                int reQ = 1;
                User upgrage = new User(bidderid,reQ);
                UserModel.upgrage(upgrage);
                break;

            case "/UpgrageSeller":
                int userid = Integer.parseInt(request.getParameter("uid"),10);
                int role = 2;
                int reQu = 0;
                User upseller = new User(userid,role,reQu);
                UserModel.upgrageSeller(upseller);
                ServletUtills.redirect("/Admin/User",request,response);
                break;

            case "/DownSeller":
                int sellid = Integer.parseInt(request.getParameter("uid"),10);
                int roledown = 1;
                int requ = 0;
                User downseller = new User(sellid,roledown,requ);
                UserModel.downSeller(downseller);
                ServletUtills.redirect("/Admin/User",request,response);
                break;

            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/Category/AddCategory":
                addCategory(request,response);
                break;

            case "/Delete":
                deleteCategory(request, response);
                break;

            case "/Update":
                updateCategory(request, response);
                break;

            case "/EditUser":
                updateUser(request,response);
                break;

            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }

    }
    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("uid"));
        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);
        String name = request.getParameter("name");
        String address = request.getParameter("address");

        User c = new User(name,address,dob,id);
        UserModel.update(c);

       /* User user = UserModel.findById(id);
        HttpSession session = request.getSession();
        session.setAttribute("auth", true);
        session.setAttribute("authUser", user);
        String url = (String) (session.getAttribute("retUrl"));
        if(url == null) url = "/Account/Profile";*/
        ServletUtills.redirect("/Admin/User",request,response);

    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("CatName");
        int catPID = Integer.parseInt(request.getParameter("catpid"),10);
        int level =0;
        if(catPID==0)
        {
            level = 1;
        }
        Category c = new Category(name,level,catPID);
        CategoryModel.add(c);
        request.setAttribute("hasSuccess", true);
        request.setAttribute("Message", "Add Successfully !");
        List<Category> listC = CategoryModel.findParent();
        request.setAttribute("catParent",listC);
        ServletUtills.forward("/views/vwAdministrator/AddCategory.jsp", request, response);
//        ServletUtills.redirect("/Admin/Category/AddCategory", request, response);
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("CatID"));
        String name = request.getParameter("CatName");
        Category c = new Category(id, name);
        CategoryModel.update(c);
        ServletUtills.redirect("/Admin/Category", request, response);
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("CatID"));
        List<Product> litsP = ProductModel.findByCatIDAdmin(id);
        List<Category> listPidC = CategoryModel.findChildByPid(id);
        if(litsP.size()==0 && listPidC.size()==0)
        {
            CategoryModel.delete(id);
        }
        else{
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "This Category have Child Category or Product. Cannot Delete");
            Category c1 = CategoryModel.findById(id);
            request.setAttribute("category", c1);
            ServletUtills.forward("/views/vwAdministrator/EditCategory.jsp", request, response);
        }
        ServletUtills.redirect("/Admin/Category",request,response);
    }
}
