package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.example.dao.StockTransactionDAO;
import com.example.model.StockTransaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/stocks")
public class StocksServlet extends HttpServlet {
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
            // Get all stock transactions for the user
            List<StockTransaction> transactions = stockTransactionDAO.getStockTransactionsByUserId(userId);
            
            // Calculate summary statistics
            BigDecimal portfolioValue = stockTransactionDAO.getTotalPortfolioValue(userId);
            BigDecimal totalInvested = stockTransactionDAO.getTotalInvested(userId);
            BigDecimal totalGainLoss = stockTransactionDAO.getTotalGainLoss(userId);
            int totalTransactions = stockTransactionDAO.getTotalTransactions(userId);
            
            // Set attributes for JSP
            request.setAttribute("transactions", transactions);
            request.setAttribute("portfolioValue", portfolioValue);
            request.setAttribute("totalInvested", totalInvested);
            request.setAttribute("totalGainLoss", totalGainLoss);
            request.setAttribute("totalTransactions", totalTransactions);
            
            // Check if we're in edit mode
            String editMode = request.getParameter("edit");
            if ("true".equals(editMode)) {
                StockTransaction editingTransaction = (StockTransaction) session.getAttribute("editingStockTransaction");
                if (editingTransaction != null) {
                    request.setAttribute("editingStockTransaction", editingTransaction);
                    request.setAttribute("isEditMode", true);
                    // Clear the session after setting the attribute
                    session.removeAttribute("editingStockTransaction");
                }
            }
            
            // Forward to stocks.jsp
            request.getRequestDispatcher("stocks.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error loading stocks page: " + e.getMessage());
            request.setAttribute("error", "Error loading stocks page. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}