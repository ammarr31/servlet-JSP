package com.item.controller;

import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.item.impl.UserServiceImpl;
import com.item.model.User;
import com.item.service.UserService;

@WebServlet("/UserController")
public class UserController extends HttpServlet {

    @Resource(name="jdbc/item")
    private DataSource datasource;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl(datasource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        switch(action) {
            case "register":
                register(request, response);
                break;
            case "login":
                login(request, response);
                break;
            case "delete-account":
                deleteAccount(request, response);
                break;
            case "forget-password":
                forgetPassword(request, response);
                break;
            case "reset-password":
                resetPassword(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");

        User user = new User(username, password, fullName);
        boolean success = userService.registerUser(user);

        if(success) response.sendRedirect(request.getContextPath() + "/login.jsp");
        else response.sendRedirect(request.getContextPath() + "/register.jsp?error=1");
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userService.loginUser(username, password);
        if(user != null) {
            session = request.getSession();
            session.setAttribute("loggedUser", user);

            Cookie userCookie = new Cookie("userLogin", user.getUsername());
            userCookie.setPath(request.getContextPath());
            userCookie.setMaxAge(5 * 24 * 60 * 60);
            response.addCookie(userCookie);

            response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        }
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User loggedUser = (User) session.getAttribute("loggedUser");
            if (loggedUser != null) {
                userService.deleteUser(loggedUser.getUsername());
                session.invalidate();
            }
        }
        // حذف الكوكيز
        Cookie cookie = new Cookie("userLogin", "");
        cookie.setPath(request.getContextPath());
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        response.sendRedirect(request.getContextPath() + "/login.jsp?deleted=1");
    }
    
    private void forgetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");

        User user = userService.findUserByUsername(username);
        if (user != null) {
            response.sendRedirect(request.getContextPath() + "/reset-password.jsp?username=" + username);
        } else {
            response.sendRedirect(request.getContextPath() + "/forget-password.jsp?error=1");
        }
    }

    
    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        User user = userService.findUserByUsername(username);
        if (user != null) {
            userService.updatePassword(username, newPassword);
            response.sendRedirect(request.getContextPath() + "/login.jsp?reset=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/reset-password.jsp?error=1");
        }
    }

    


}
