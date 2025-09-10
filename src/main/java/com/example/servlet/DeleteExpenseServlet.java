package com.example.servlet;

import java.io.IOException;

import com.example.dao.ExpenseDAO;
import com.example.model.Expense;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete-expense")
public class DeleteExpenseServlet extends HttpServlet {
    private ExpenseDAO expenseDAO;
    
    @Override
    public void init() throws ServletException {
        expenseDAO = new ExpenseDAO();
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
        
        String expenseIdStr = request.getParameter("expenseId");
        if (expenseIdStr == null || expenseIdStr.trim().isEmpty()) {
            session.setAttribute("error", "Expense ID is required.");
            response.sendRedirect("expenses");
            return;
        }
        
        try {
            int expenseId = Integer.parseInt(expenseIdStr);
            
            // First, verify that the expense exists and belongs to the current user
            Expense expense = expenseDAO.getExpenseById(expenseId);
            if (expense == null) {
                session.setAttribute("error", "Expense not found.");
                response.sendRedirect("expenses");
                return;
            }
            
            if (expense.getUserId() != userId) {
                session.setAttribute("error", "You don't have permission to delete this expense.");
                response.sendRedirect("expenses");
                return;
            }
            
            // Delete the expense
            boolean success = expenseDAO.deleteExpense(expenseId, userId);
            
            if (success) {
                session.setAttribute("success", "Expense deleted successfully!");
            } else {
                session.setAttribute("error", "Failed to delete expense. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid expense ID format.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while deleting the expense. Please try again.");
        }
        
        response.sendRedirect("expenses");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to expenses page
        response.sendRedirect("expenses");
    }
}
