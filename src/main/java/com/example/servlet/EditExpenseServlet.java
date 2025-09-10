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

@WebServlet("/edit-expense")
public class EditExpenseServlet extends HttpServlet {
    private ExpenseDAO expenseDAO;
    private ExpenseValidator validator;
    
    @Override
    public void init() throws ServletException {
        expenseDAO = new ExpenseDAO();
        validator = new ExpenseValidator();
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
        
        String expenseIdStr = request.getParameter("id");
        if (expenseIdStr == null || expenseIdStr.trim().isEmpty()) {
            session.setAttribute("error", "Expense ID is required.");
            response.sendRedirect("expenses");
            return;
        }
        
        try {
            int expenseId = Integer.parseInt(expenseIdStr);
            Expense expense = expenseDAO.getExpenseById(expenseId);
            
            if (expense == null) {
                session.setAttribute("error", "Expense not found.");
                response.sendRedirect("expenses");
                return;
            }
            
            // Check if the expense belongs to the current user
            if (expense.getUserId() != userId) {
                session.setAttribute("error", "You don't have permission to edit this expense.");
                response.sendRedirect("expenses");
                return;
            }
            
            // Store expense data in session for editing
            session.setAttribute("editingExpense", expense);
            response.sendRedirect("expenses?edit=true");
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid expense ID.");
            response.sendRedirect("expenses");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while loading the expense.");
            response.sendRedirect("expenses");
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
            String expenseIdStr = request.getParameter("expenseId");
            String amountStr = request.getParameter("amount");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String dateStr = request.getParameter("date");
            
            // Validate input
            if (expenseIdStr == null || expenseIdStr.trim().isEmpty()) {
                session.setAttribute("error", "Expense ID is required.");
                response.sendRedirect("expenses");
                return;
            }
            
            String validationError = validateInput(amountStr, category, dateStr);
            if (validationError != null) {
                session.setAttribute("error", validationError);
                response.sendRedirect("edit-expense?id=" + expenseIdStr);
                return;
            }
            
            // Parse and create expense
            int expenseId = Integer.parseInt(expenseIdStr);
            BigDecimal amount = new BigDecimal(amountStr);
            LocalDate expenseDate = LocalDate.parse(dateStr);
            
            // Get existing expense to verify ownership
            Expense existingExpense = expenseDAO.getExpenseById(expenseId);
            if (existingExpense == null || existingExpense.getUserId() != userId) {
                session.setAttribute("error", "Expense not found or you don't have permission to edit it.");
                response.sendRedirect("expenses");
                return;
            }
            
            // Update expense object
            existingExpense.setAmount(amount);
            existingExpense.setCategory(category);
            existingExpense.setDescription(description != null ? description.trim() : "");
            existingExpense.setExpenseDate(expenseDate);
            
            // Validate expense object
            if (!validator.validateExpense(existingExpense)) {
                session.setAttribute("error", "Invalid expense data. Please check your input.");
                response.sendRedirect("edit-expense?id=" + expenseId);
                return;
            }
            
            // Update in database
            boolean success = expenseDAO.updateExpense(existingExpense);
            
            if (success) {
                session.setAttribute("success", "Expense updated successfully!");
            } else {
                session.setAttribute("error", "Failed to update expense. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid amount or expense ID format.");
        } catch (DateTimeParseException e) {
            session.setAttribute("error", "Invalid date format. Please select a valid date.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while updating the expense. Please try again.");
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
