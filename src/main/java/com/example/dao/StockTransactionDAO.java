package com.example.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.DBConnection;
import com.example.model.StockTransaction;

public class StockTransactionDAO {
    
    // Create a new stock transaction
    public boolean createStockTransaction(StockTransaction transaction) {
        String sql = "INSERT INTO stock_transactions (user_id, stock_symbol, stock_name, transaction_type, quantity, price_per_share, total_amount, transaction_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, transaction.getUserId());
            stmt.setString(2, transaction.getStockSymbol());
            stmt.setString(3, transaction.getStockName());
            stmt.setString(4, transaction.getTransactionType());
            stmt.setInt(5, transaction.getQuantity());
            stmt.setBigDecimal(6, transaction.getPricePerShare());
            stmt.setBigDecimal(7, transaction.getTotalAmount());
            stmt.setDate(8, java.sql.Date.valueOf(transaction.getTransactionDate()));
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            System.err.println("Error creating stock transaction: " + e.getMessage());
            return false;
        }
    }
    
    // Get all stock transactions for a user
    public List<StockTransaction> getStockTransactionsByUserId(int userId) {
        List<StockTransaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM stock_transactions WHERE user_id = ? ORDER BY transaction_date DESC, created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                StockTransaction transaction = mapResultSetToStockTransaction(rs);
                if (transaction != null) {
                    transactions.add(transaction);
                }
            }
            
        } catch (Exception e) {
            System.err.println("Error fetching stock transactions: " + e.getMessage());
        }
        
        return transactions;
    }
    
    // Get a specific stock transaction by ID
    public StockTransaction getStockTransactionById(int id) {
        String sql = "SELECT * FROM stock_transactions WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToStockTransaction(rs);
            }
            
        } catch (Exception e) {
            System.err.println("Error fetching stock transaction by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    // Update a stock transaction
    public boolean updateStockTransaction(StockTransaction transaction) {
        String sql = "UPDATE stock_transactions SET transaction_type = ?, stock_symbol = ?, stock_name = ?, quantity = ?, price_per_share = ?, total_amount = ?, transaction_date = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, transaction.getTransactionType());
            stmt.setString(2, transaction.getStockSymbol());
            stmt.setString(3, transaction.getStockName());
            stmt.setInt(4, transaction.getQuantity());
            stmt.setBigDecimal(5, transaction.getPricePerShare());
            stmt.setBigDecimal(6, transaction.getTotalAmount());
            stmt.setDate(7, java.sql.Date.valueOf(transaction.getTransactionDate()));
            stmt.setInt(8, transaction.getId());
            stmt.setInt(9, transaction.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            System.err.println("Error updating stock transaction: " + e.getMessage());
            return false;
        }
    }
    
    // Delete a stock transaction
    public boolean deleteStockTransaction(int id, int userId) {
        String sql = "DELETE FROM stock_transactions WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.setInt(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            System.err.println("Error deleting stock transaction: " + e.getMessage());
            return false;
        }
    }
    
    // Get total portfolio value for a user
    public BigDecimal getTotalPortfolioValue(int userId) {
        String sql = "SELECT SUM(CASE WHEN transaction_type = 'BUY' THEN total_amount ELSE -total_amount END) as portfolio_value FROM stock_transactions WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                BigDecimal value = rs.getBigDecimal("portfolio_value");
                return value != null ? value : BigDecimal.ZERO;
            }
            
        } catch (Exception e) {
            System.err.println("Error calculating portfolio value: " + e.getMessage());
        }
        
        return BigDecimal.ZERO;
    }
    
    // Get total invested amount for a user
    public BigDecimal getTotalInvested(int userId) {
        String sql = "SELECT SUM(total_amount) as total_invested FROM stock_transactions WHERE user_id = ? AND transaction_type = 'BUY'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                BigDecimal value = rs.getBigDecimal("total_invested");
                return value != null ? value : BigDecimal.ZERO;
            }
            
        } catch (Exception e) {
            System.err.println("Error calculating total invested: " + e.getMessage());
        }
        
        return BigDecimal.ZERO;
    }
    
    // Get total gain/loss for a user
    public BigDecimal getTotalGainLoss(int userId) {
        BigDecimal portfolioValue = getTotalPortfolioValue(userId);
        BigDecimal totalInvested = getTotalInvested(userId);
        return portfolioValue.subtract(totalInvested);
    }
    
    // Get total number of transactions for a user
    public int getTotalTransactions(int userId) {
        String sql = "SELECT COUNT(*) as total_transactions FROM stock_transactions WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total_transactions");
            }
            
        } catch (Exception e) {
            System.err.println("Error counting transactions: " + e.getMessage());
        }
        
        return 0;
    }
    
    // Helper method to map ResultSet to StockTransaction object
    private StockTransaction mapResultSetToStockTransaction(ResultSet rs) {
        try {
            StockTransaction transaction = new StockTransaction();
            transaction.setId(rs.getInt("id"));
            transaction.setUserId(rs.getInt("user_id"));
            transaction.setTransactionType(rs.getString("transaction_type"));
            transaction.setStockSymbol(rs.getString("stock_symbol"));
            transaction.setStockName(rs.getString("stock_name"));
            transaction.setQuantity(rs.getInt("quantity"));
            transaction.setPricePerShare(rs.getBigDecimal("price_per_share"));
            transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
            transaction.setTransactionDate(rs.getDate("transaction_date").toLocalDate());
            transaction.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
            transaction.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            return transaction;
        } catch (Exception e) {
            System.err.println("Error mapping ResultSet to StockTransaction: " + e.getMessage());
            return null;
        }
    }
}