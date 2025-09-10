package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import com.example.dao.ExpenseDAO;
import com.example.model.Expense;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/expenses")
public class ViewExpensesServlet extends HttpServlet {
    private ExpenseDAO expenseDAO;
    
    @Override
    public void init() throws ServletException {
        expenseDAO = new ExpenseDAO();
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
            // Get all expenses for the user
            List<Expense> expenses = expenseDAO.getExpensesByUserId(userId);
            
            // Calculate summary statistics
            BigDecimal totalExpenses = expenseDAO.getTotalExpensesByUserId(userId);
            BigDecimal monthlyExpenses = getMonthlyExpenses(userId);
            List<String> categories = expenseDAO.getCategoriesByUserId(userId);
            int totalRecords = expenses.size();
            
            // Set attributes for JSP
            request.setAttribute("expenses", expenses);
            request.setAttribute("totalExpenses", totalExpenses);
            request.setAttribute("monthlyExpenses", monthlyExpenses);
            request.setAttribute("categoryCount", categories.size());
            request.setAttribute("expenseCount", totalRecords);
            request.setAttribute("categories", categories);
            
            // Check if we're in edit mode
            String editMode = request.getParameter("edit");
            if ("true".equals(editMode)) {
                Expense editingExpense = (Expense) session.getAttribute("editingExpense");
                if (editingExpense != null) {
                    request.setAttribute("editingExpense", editingExpense);
                    request.setAttribute("isEditMode", true);
                    // Clear the session after setting the attribute
                    session.removeAttribute("editingExpense");
                }
            }
            
            // Forward to expenses.jsp
            request.getRequestDispatcher("expenses.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading expenses. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Helper method to get current month's expenses
    private BigDecimal getMonthlyExpenses(Integer userId) {
        LocalDate now = LocalDate.now();
        LocalDate startOfMonth = now.withDayOfMonth(1);
        LocalDate endOfMonth = now.withDayOfMonth(now.lengthOfMonth());
        
        List<Expense> monthlyExpenses = expenseDAO.getExpensesByDateRange(userId, startOfMonth, endOfMonth);
        
        return monthlyExpenses.stream()
                .map(Expense::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
