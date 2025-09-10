package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import com.example.dao.ExpenseDAO;
import com.example.model.Expense;
import com.example.util.ExpenseValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-expense")
public class AddExpenseServlet extends HttpServlet {
    private ExpenseDAO expenseDAO;
    private ExpenseValidator validator;
    
    @Override
    public void init() throws ServletException {
        expenseDAO = new ExpenseDAO();
        validator = new ExpenseValidator();
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
            String amountStr = request.getParameter("amount");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("date");
            
            // Validate input
            String validationError = validateInput(amountStr, category, dateStr);
            if (validationError != null) {
                session.setAttribute("error", validationError);
                response.sendRedirect("expenses");
                return;
            }
            
            // Parse and create expense
            BigDecimal amount = new BigDecimal(amountStr);
            LocalDate expenseDate = LocalDate.parse(dateStr);
            
            Expense expense = new Expense();
            expense.setUserId(userId);
            expense.setAmount(amount);
            expense.setCategory(category);
            expense.setDescription(description != null ? description.trim() : "");
            expense.setExpenseDate(expenseDate);
            
            // Validate expense object
            if (!validator.validateExpense(expense)) {
                session.setAttribute("error", "Invalid expense data. Please check your input.");
                response.sendRedirect("expenses");
                return;
            }
            
            // Save to database
            boolean success = expenseDAO.createExpense(expense);
            
            if (success) {
                session.setAttribute("success", "Expense added successfully!");
            } else {
                session.setAttribute("error", "Failed to add expense. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid amount format. Please enter a valid number.");
        } catch (DateTimeParseException e) {
            session.setAttribute("error", "Invalid date format. Please select a valid date.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while adding the expense. Please try again.");
        }
        
        response.sendRedirect("expenses");
    }
    
    private String validateInput(String amount, String category, String date) {
        if (amount == null || amount.trim().isEmpty()) {
            return "Amount is required.";
        }
        
        if (category == null || category.trim().isEmpty()) {
            return "Category is required.";
        }
        
        if (date == null || date.trim().isEmpty()) {
            return "Date is required.";
        }
        
        try {
            BigDecimal amountValue = new BigDecimal(amount);
            if (amountValue.compareTo(BigDecimal.ZERO) <= 0) {
                return "Amount must be greater than zero.";
            }
        } catch (NumberFormatException e) {
            return "Invalid amount format.";
        }
        
        try {
            LocalDate.parse(date);
        } catch (DateTimeParseException e) {
            return "Invalid date format.";
        }
        
        return null; // No validation errors
    }
}