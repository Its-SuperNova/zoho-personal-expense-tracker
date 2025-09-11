package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.example.dao.StockTransactionDAO;
import com.example.model.StockTransaction;
import com.example.util.StockTransactionValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/edit-stock-transaction")
public class EditStockTransactionServlet extends HttpServlet {
    private StockTransactionDAO stockTransactionDAO;
    
    @Override
    public void init() throws ServletException {
        stockTransactionDAO = new StockTransactionDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            int transactionId = Integer.parseInt(request.getParameter("id"));
            StockTransaction transaction = stockTransactionDAO.getStockTransactionById(transactionId);
            
            if (transaction == null) {
                session.setAttribute("error", "Stock transaction not found.");
                response.sendRedirect("stocks");
                return;
            }
            
            // Check if the transaction belongs to the current user
            if (transaction.getUserId() != userId) {
                session.setAttribute("error", "You don't have permission to edit this transaction.");
                response.sendRedirect("stocks");
                return;
            }
            
            // Store transaction data in session for editing
            session.setAttribute("editingStockTransaction", transaction);
            response.sendRedirect("stocks?edit=true");
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid transaction ID.");
            response.sendRedirect("stocks");
        } catch (Exception e) {
            System.err.println("Error loading stock transaction: " + e.getMessage());
            session.setAttribute("error", "An error occurred while loading the transaction.");
            response.sendRedirect("stocks");
        }
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
            // Get form parameters
            String transactionIdStr = request.getParameter("transactionId");
            String transactionType = request.getParameter("transactionType");
            String stockSymbol = request.getParameter("stockSymbol");
            String stockName = request.getParameter("stockName");
            String quantityStr = request.getParameter("quantity");
            String pricePerShareStr = request.getParameter("pricePerShare");
            String transactionDateStr = request.getParameter("transactionDate");
            
            // Validate input
            List<String> errors = StockTransactionValidator.validateStockTransaction(
                transactionType, stockSymbol, stockName, quantityStr, pricePerShareStr, transactionDateStr
            );
            
            if (!errors.isEmpty()) {
                session.setAttribute("error", String.join(", ", errors));
                response.sendRedirect("stocks");
                return;
            }
            
            // Parse and create StockTransaction object
            int transactionId = Integer.parseInt(transactionIdStr);
            int quantity = Integer.parseInt(quantityStr);
            BigDecimal pricePerShare = new BigDecimal(pricePerShareStr);
            BigDecimal totalAmount = pricePerShare.multiply(new BigDecimal(quantity));
            LocalDate transactionDate = LocalDate.parse(transactionDateStr);
            
            StockTransaction transaction = new StockTransaction();
            transaction.setId(transactionId);
            transaction.setUserId(userId);
            transaction.setTransactionType(transactionType.toUpperCase());
            transaction.setStockSymbol(stockSymbol.toUpperCase());
            transaction.setStockName(stockName);
            transaction.setQuantity(quantity);
            transaction.setPricePerShare(pricePerShare);
            transaction.setTotalAmount(totalAmount);
            transaction.setTransactionDate(transactionDate);
            
            // Update in database
            boolean success = stockTransactionDAO.updateStockTransaction(transaction);
            
            if (success) {
                session.setAttribute("success", "Stock transaction updated successfully!");
            } else {
                session.setAttribute("error", "Failed to update stock transaction. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("Error updating stock transaction: " + e.getMessage());
            session.setAttribute("error", "An error occurred while updating the stock transaction.");
        }
        
        response.sendRedirect("stocks");
    }
}