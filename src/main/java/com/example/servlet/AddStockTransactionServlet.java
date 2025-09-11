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

@WebServlet("/add-stock-transaction")
public class AddStockTransactionServlet extends HttpServlet {
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
            // Get form parameters
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
            int quantity = Integer.parseInt(quantityStr);
            BigDecimal pricePerShare = new BigDecimal(pricePerShareStr);
            BigDecimal totalAmount = pricePerShare.multiply(new BigDecimal(quantity));
            LocalDate transactionDate = LocalDate.parse(transactionDateStr);
            
            StockTransaction transaction = new StockTransaction();
            transaction.setUserId(userId);
            transaction.setTransactionType(transactionType.toUpperCase());
            transaction.setStockSymbol(stockSymbol.toUpperCase());
            transaction.setStockName(stockName);
            transaction.setQuantity(quantity);
            transaction.setPricePerShare(pricePerShare);
            transaction.setTotalAmount(totalAmount);
            transaction.setTransactionDate(transactionDate);
            
            // Save to database
            boolean success = stockTransactionDAO.createStockTransaction(transaction);
            
            if (success) {
                session.setAttribute("success", "Stock transaction added successfully!");
            } else {
                session.setAttribute("error", "Failed to add stock transaction. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("Error adding stock transaction: " + e.getMessage());
            session.setAttribute("error", "An error occurred while adding the stock transaction.");
        }
        
        response.sendRedirect("stocks");
    }
}
