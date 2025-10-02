package com.item.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.item.impl.ItemDetailsServiceImpl;
import com.item.model.Item;
import com.item.model.ItemDetails;
import com.item.service.ItemDetailsService;

@WebServlet("/ItemDetailsController")
public class ItemDetailsController extends HttpServlet {

    @Resource(name = "jdbc/item")
    private DataSource datasource;

    private ItemDetailsService itemDetailsService;

    @Override
    public void init() throws ServletException {
        super.init();
        itemDetailsService = new ItemDetailsServiceImpl(datasource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

            if (action == null) {
            	response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
            }

            switch (action) {
                case "add-details":
                    addDetails(request, response);
                    break;
                case "delete-details":
                    deleteDetails(request, response);
                    break;
                case "show-details":
                	showAllDetails(request, response);
                default:
                    response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");
                    break;
            }
    }

	private void showAllDetails(HttpServletRequest request, HttpServletResponse response) {
        List<ItemDetails> details = itemDetailsService.getAllDetails();
        request.setAttribute("details", details);
        try {
            request.getRequestDispatcher("/allDetails.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("---> " + e.getMessage());
        }
    }
    
    private void addDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("item_id"));
            String model = request.getParameter("model");
            String issuedBy = request.getParameter("issued_by");
            java.sql.Date expiryDate = java.sql.Date.valueOf(request.getParameter("expiry_date"));

            ItemDetails details = new ItemDetails(itemId, model, issuedBy, expiryDate);
            itemDetailsService.addItemDetails(details);

            response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int itemId = Integer.parseInt(request.getParameter("item_id"));
            itemDetailsService.deleteItemDetails(itemId);

            response.sendRedirect(request.getContextPath() + "/ItemController?action=show-items");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
