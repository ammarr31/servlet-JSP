package com.item.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.item.model.Item;
import com.item.model.ItemDetails;
import com.item.service.ItemDetailsService;

public class ItemDetailsServiceImpl implements ItemDetailsService {

    private DataSource datasource;

    public ItemDetailsServiceImpl(DataSource datasource) {
        this.datasource = datasource;
    }
    @Override
    public List<ItemDetails> getAllDetails() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<ItemDetails> details = new ArrayList<>();

        try {
            connection = datasource.getConnection();
            statement = connection.createStatement();
            String sql = "SELECT * FROM item i FULL OUTER JOIN ITEM_DETAILS d ON (i.ID = d.ITEM_ID)";
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                ItemDetails detail = new ItemDetails();
                detail.setItemId(resultSet.getInt("id"));
                detail.setModel(resultSet.getString("name"));
                detail.setPrice(resultSet.getInt("price"));
                detail.setTotalNumber(resultSet.getInt("total_number"));
                detail.setModel(resultSet.getString("model"));
                detail.setIssuedBy(resultSet.getString("issued_by"));
                
                java.sql.Date sqlDate = resultSet.getDate("expiry_date");
                if (sqlDate != null) {
                	detail.setExpiryDate(resultSet.getDate("expiry_date"));
                }

                details.add(detail);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.out.println("---> " + e.getMessage());
            }
        }

        return details;
    }


    @Override
    public boolean addItemDetails(ItemDetails details) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = datasource.getConnection();
            statement = connection.createStatement();

            String query = "INSERT INTO item_details (model, issued_by, expiry_date, item_id) VALUES ('"
                    + details.getModel() + "', '"
                    + details.getIssuedBy() + "', TO_DATE('" + details.getExpiryDate() + "', 'YYYY-MM-DD'), "
                    + details.getItemId() + ")";

            statement.executeUpdate(query);

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.out.println("---> " + e.getMessage());
            }
        }
        return false;
    }

    @Override
    public boolean deleteItemDetails(int itemId) {
        Connection connection = null;
        Statement statement = null;
        try {
            connection = datasource.getConnection();
            statement = connection.createStatement();

            String query = "DELETE FROM item_details WHERE item_id = " + itemId;
            statement.executeUpdate(query);

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                System.out.println("---> " + e.getMessage());
            }
        }
        return false;
    }
}
