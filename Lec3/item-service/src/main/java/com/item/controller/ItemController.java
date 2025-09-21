package com.item.controller;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.item.impl.ItemServiceImpl;
import com.item.model.Item;
import com.item.service.ItemService;

@WebServlet("/ItemController")
public class ItemController extends HttpServlet {

    @Resource(name = "jdbc/item")
    private DataSource datasource;

    private ItemService itemService; // instance واحد فقط

    @Override
    public void init() throws ServletException {
        super.init();
        // إنشاء الـ service مرة واحدة عند تهيئة الـ Servlet
        itemService = new ItemServiceImpl(datasource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (Objects.isNull(action)) {
            action = "show-items";
        }

        switch (action) {
            case "show-items":
                showAllItems(request, response);
                break;
            case "show-item":
                showItem(request, response);
                break;
            case "add-item":
                addItem(request, response);
                break;
            case "update-item":
                updateItem(request, response);
                break;
            case "delete-item":
                deleteItem(request, response);
                break;
            default:
                showAllItems(request, response);
        }
    }

    private void showAllItems(HttpServletRequest request, HttpServletResponse response) {
        List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);
        try {
            request.getRequestDispatcher("/show-items.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("---> " + e.getMessage());
        }
    }

    private void showItem(HttpServletRequest request, HttpServletResponse response) {
        long id = Long.parseLong(request.getParameter("id"));
        Item item = itemService.getItem(id);
        request.setAttribute("item", item);
        try {
            request.getRequestDispatcher("/updateItem.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("---> " + e.getMessage());
        }
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response) {
        try {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int total = Integer.parseInt(request.getParameter("total_number"));

            Item item = new Item(name, price, total);
            Boolean isAdded = itemService.addItem(item);

            if (isAdded) {
                response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) {
        try {
            long id = Long.parseLong(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int total = Integer.parseInt(request.getParameter("total_number"));

            Item item = new Item(id, name, price, total);
            Boolean isUpdated = itemService.updateItem(item);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) {
        long id = Long.parseLong(request.getParameter("id"));
        Boolean isDeleted = itemService.deleteItem(id);

        if (isDeleted) {
            showAllItems(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
