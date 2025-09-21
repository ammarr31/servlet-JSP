package com.item.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.item.model.Item;
import com.item.service.ItemService;

public class ItemServiceImpl implements ItemService {
	
	private DataSource datasource;
	
	public ItemServiceImpl(DataSource datasource) {
		this.datasource = datasource;
	}
	


	@Override
	public Boolean addItem(Item item) {
		Connection connection = null;
		Statement statement = null;
		
		try {
			connection = datasource.getConnection();
			statement = connection.createStatement();
			
			String query = "INSERT INTO item (name, price, total_number) VALUES ('"+ item.getName()  +"', "+ item.getPrice() +  "," + item.getTotalNumber() + ")";
			statement.executeQuery(query);
			
			return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            try {
          	  if (connection != null) {
          		  connection.close();
          	  }
          	  if (statement != null) {
          		  statement.close();
          	  }
			} catch (SQLException e) {
				System.out.println("---> " + e.getMessage());
			}
            
      }
		return false;
	}

	@Override
	public Boolean updateItem(Item item) {
		Connection connection = null;
		Statement statement = null;
		
		try {
			connection = datasource.getConnection();
			statement = connection.createStatement();
			
			String query = "UPDATE item SET name = '"+ item.getName()  +"', price = "+ item.getPrice() +  ", total_number = " + item.getTotalNumber() +" WHERE id = "+ item.getId();
			statement.executeQuery(query);
			
			return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            try {
          	  if (connection != null) {
          		  connection.close();
          	  }
          	  if (statement != null) {
          		  statement.close();
          	  }
			} catch (SQLException e) {
				System.out.println("---> " + e.getMessage());
			}
            
      }
		return false;
	}

	@Override
	public Boolean deleteItem(long id) {
		Connection connection = null;
		Statement statement = null;
		
		try {
			connection = datasource.getConnection();
			statement = connection.createStatement();
			
			String query = "DELETE FROM item WHERE id = " + id;
			statement.executeQuery(query);
			
			
			
			return true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            try {
          	  if (connection != null) {
          		  connection.close();
          	  }
          	  if (statement != null) {
          		  statement.close();
          	  }
			} catch (SQLException e) {
				System.out.println("---> " + e.getMessage());
			}
            
      }
		
      return false;
	}

	@Override
	public List<Item> getAllItems() {
		Connection connection = null;
		Statement statement = null;
		
		try {
			connection = datasource.getConnection();
			statement = connection.createStatement();
			
			String sql = "SELECT * FROM item ORDER BY id";
			ResultSet resultSet = statement.executeQuery(sql);
			
			List<Item> items = new ArrayList<>();
			
			while(resultSet.next()) {
				Item itemData = new Item();
				
				itemData.setId(resultSet.getLong("id"));
				itemData.setName(resultSet.getString("name"));
				itemData.setPrice(resultSet.getDouble("price"));
				itemData.setTotalNumber(resultSet.getInt("total_number"));
				
				items.add(itemData);
			}

			return items;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
            try {
          	  if (connection != null) {
          		  connection.close();
          	  }
          	  if (statement != null) {
          		  statement.close();
          	  }
			} catch (SQLException e) {
				System.out.println("---> " + e.getMessage());
			}
            
      }
		
      return new ArrayList<>();
	}


	@Override
	public Item getItem(long id) {
		Connection connection = null;
        Statement statement = null;
        try {
            connection = datasource.getConnection();
            statement = connection.createStatement();

            String sql = "SELECT * FROM item WHERE id = " + id;
            ResultSet resultSet = statement.executeQuery(sql); 

            Item item = new Item();
            if (resultSet.next()) {
                item.setId(resultSet.getLong("id"));
                item.setName(resultSet.getString("name"));
                item.setPrice(resultSet.getDouble("price"));
                item.setTotalNumber(resultSet.getInt("total_number"));
            }
            
			System.out.println("Fetched item: " + item);

            return item;

        } catch (SQLException e) {
        	System.out.println("---> " + e.getMessage());
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (SQLException e) {
            	System.out.println("---> " + e.getMessage());
            }
        }
        return null;
	}


}
