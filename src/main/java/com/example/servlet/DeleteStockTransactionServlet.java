package com.example.servlet;

import java.io.IOException;

import com.example.dao.StockTransactionDAO;
import com.example.model.StockTransaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete-stock-transaction")
public class DeleteStockTransactionServlet extends HttpServlet {
    private StockTransactionDAO stockTransactionDAO;
    
    @Override
    public void init() throws ServletException {
        stockTransactionDAO = new StockTransactionDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int transactionId = Integer.parseInt(request.getParameter("transactionId"));
            
            // Check if the transaction exists and belongs to the current user
            StockTransaction transaction = stockTransactionDAO.getStockTransactionById(transactionId);
            if (transaction == null) {
                session.setAttribute("error", "Stock transaction not found.");
                response.sendRedirect("stocks");
                return;
            }
            
            if (transaction.getUserId() != userId) {
                session.setAttribute("error", "You don't have permission to delete this transaction.");
                response.sendRedirect("stocks");
                return;
            }
            
            // Delete the transaction
            boolean success = stockTransactionDAO.deleteStockTransaction(transactionId, userId);
            
            if (success) {
                session.setAttribute("success", "Stock transaction deleted successfully!");
            } else {
                session.setAttribute("error", "Failed to delete stock transaction. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid transaction ID.");
        } catch (Exception e) {
            // Log the error for debugging
            System.err.println("Error deleting stock transaction: " + e.getMessage());
            session.setAttribute("error", "An error occurred while deleting the stock transaction.");
        }
        
        response.sendRedirect("stocks");
    }
}
