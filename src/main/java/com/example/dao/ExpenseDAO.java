package com.example.dao;

import com.example.model.Expense;
import com.example.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ExpenseDAO {
    
    // Create a new expense
    public boolean createExpense(Expense expense) {
        String sql = "INSERT INTO expenses (user_id, amount, category, description, expense_date) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, expense.getUserId());
            ps.setBigDecimal(2, expense.getAmount());
            ps.setString(3, expense.getCategory());
            ps.setString(4, expense.getDescription());
            ps.setDate(5, Date.valueOf(expense.getExpenseDate()));
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get expense by ID
    public Expense getExpenseById(int id) {
        String sql = "SELECT * FROM expenses WHERE id = ?";
        Expense expense = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                expense = mapResultSetToExpense(rs);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return expense;
    }
    
    // Get all expenses for a user
    public List<Expense> getExpensesByUserId(int userId) {
        String sql = "SELECT * FROM expenses WHERE user_id = ? ORDER BY expense_date DESC";
        List<Expense> expenses = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                expenses.add(mapResultSetToExpense(rs));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return expenses;
    }
    
    // Get expenses by category
    public List<Expense> getExpensesByCategory(int userId, String category) {
        String sql = "SELECT * FROM expenses WHERE user_id = ? AND category = ? ORDER BY expense_date DESC";
        List<Expense> expenses = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, category);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                expenses.add(mapResultSetToExpense(rs));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return expenses;
    }
    
    // Get expenses by date range
    public List<Expense> getExpensesByDateRange(int userId, LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT * FROM expenses WHERE user_id = ? AND expense_date BETWEEN ? AND ? ORDER BY expense_date DESC";
        List<Expense> expenses = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setDate(2, Date.valueOf(startDate));
            ps.setDate(3, Date.valueOf(endDate));
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                expenses.add(mapResultSetToExpense(rs));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return expenses;
    }
    
    // Update expense
    public boolean updateExpense(Expense expense) {
        String sql = "UPDATE expenses SET amount = ?, category = ?, description = ?, expense_date = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setBigDecimal(1, expense.getAmount());
            ps.setString(2, expense.getCategory());
            ps.setString(3, expense.getDescription());
            ps.setDate(4, Date.valueOf(expense.getExpenseDate()));
            ps.setInt(5, expense.getId());
            ps.setInt(6, expense.getUserId());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete expense
    public boolean deleteExpense(int id, int userId) {
        String sql = "DELETE FROM expenses WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.setInt(2, userId);
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get total expenses for a user
    public BigDecimal getTotalExpensesByUserId(int userId) {
        String sql = "SELECT SUM(amount) FROM expenses WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BigDecimal total = rs.getBigDecimal(1);
                return total != null ? total : BigDecimal.ZERO;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return BigDecimal.ZERO;
    }
    
    // Get total expenses by category
    public BigDecimal getTotalExpensesByCategory(int userId, String category) {
        String sql = "SELECT SUM(amount) FROM expenses WHERE user_id = ? AND category = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, category);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                BigDecimal total = rs.getBigDecimal(1);
                return total != null ? total : BigDecimal.ZERO;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return BigDecimal.ZERO;
    }
    
    // Get all unique categories for a user
    public List<String> getCategoriesByUserId(int userId) {
        String sql = "SELECT DISTINCT category FROM expenses WHERE user_id = ? ORDER BY category";
        List<String> categories = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    // Helper method to map ResultSet to Expense object
    private Expense mapResultSetToExpense(ResultSet rs) throws SQLException {
        Expense expense = new Expense();
        expense.setId(rs.getInt("id"));
        expense.setUserId(rs.getInt("user_id"));
        expense.setAmount(rs.getBigDecimal("amount"));
        expense.setCategory(rs.getString("category"));
        expense.setDescription(rs.getString("description"));
        expense.setExpenseDate(rs.getDate("expense_date").toLocalDate());
        expense.setCreatedAt(rs.getDate("created_at").toLocalDate());
        expense.setUpdatedAt(rs.getDate("updated_at").toLocalDate());
        return expense;
    }
}
