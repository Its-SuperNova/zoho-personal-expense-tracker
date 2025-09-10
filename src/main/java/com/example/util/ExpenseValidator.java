package com.example.util;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.example.model.Expense;

public class ExpenseValidator {
    
    // Predefined expense categories
    public static final String[] DEFAULT_CATEGORIES = {
        "Groceries",
        "Rent",
        "Utilities",
        "Transportation",
        "Entertainment",
        "Healthcare",
        "Education",
        "Shopping",
        "Dining Out",
        "Insurance",
        "Travel",
        "Other"
    };
    
    // Validate expense data and return boolean
    public boolean validateExpense(Expense expense) {
        List<String> errors = validateExpenseErrors(expense);
        return errors.isEmpty();
    }
    
    // Validate expense data and return list of errors
    public static List<String> validateExpenseErrors(Expense expense) {
        List<String> errors = new ArrayList<>();
        
        // Validate amount
        if (expense.getAmount() == null) {
            errors.add("Amount is required");
        } else if (expense.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            errors.add("Amount must be greater than 0");
        } else if (expense.getAmount().compareTo(new BigDecimal("999999.99")) > 0) {
            errors.add("Amount cannot exceed $999,999.99");
        }
        
        // Validate category
        if (expense.getCategory() == null || expense.getCategory().trim().isEmpty()) {
            errors.add("Category is required");
        } else if (expense.getCategory().length() > 50) {
            errors.add("Category cannot exceed 50 characters");
        }
        
        // Validate description
        if (expense.getDescription() != null && expense.getDescription().length() > 255) {
            errors.add("Description cannot exceed 255 characters");
        }
        
        // Validate expense date
        if (expense.getExpenseDate() == null) {
            errors.add("Expense date is required");
        } else if (expense.getExpenseDate().isAfter(LocalDate.now())) {
            errors.add("Expense date cannot be in the future");
        } else if (expense.getExpenseDate().isBefore(LocalDate.now().minusYears(10))) {
            errors.add("Expense date cannot be more than 10 years ago");
        }
        
        // Validate user ID
        if (expense.getUserId() <= 0) {
            errors.add("Valid user ID is required");
        }
        
        return errors;
    }
    
    // Validate amount
    public static boolean isValidAmount(BigDecimal amount) {
        return amount != null && 
               amount.compareTo(BigDecimal.ZERO) > 0 && 
               amount.compareTo(new BigDecimal("999999.99")) <= 0;
    }
    
    // Validate category
    public static boolean isValidCategory(String category) {
        return category != null && 
               !category.trim().isEmpty() && 
               category.length() <= 50;
    }
    
    // Validate description
    public static boolean isValidDescription(String description) {
        return description == null || description.length() <= 255;
    }
    
    // Validate expense date
    public static boolean isValidExpenseDate(LocalDate date) {
        return date != null && 
               !date.isAfter(LocalDate.now()) && 
               !date.isBefore(LocalDate.now().minusYears(10));
    }
    
    // Check if category is in default categories
    public static boolean isDefaultCategory(String category) {
        if (category == null) return false;
        
        for (String defaultCategory : DEFAULT_CATEGORIES) {
            if (defaultCategory.equalsIgnoreCase(category.trim())) {
                return true;
            }
        }
        return false;
    }
    
    // Get formatted amount string
    public static String formatAmount(BigDecimal amount) {
        if (amount == null) return "$0.00";
        return String.format("$%.2f", amount);
    }
    
    // Sanitize input string
    public static String sanitizeString(String input) {
        if (input == null) return null;
        return input.trim().replaceAll("[<>\"'&]", "");
    }
    
    // Validate and sanitize expense
    public static Expense sanitizeExpense(Expense expense) {
        if (expense == null) return null;
        
        Expense sanitized = new Expense();
        sanitized.setId(expense.getId());
        sanitized.setUserId(expense.getUserId());
        sanitized.setAmount(expense.getAmount());
        sanitized.setCategory(sanitizeString(expense.getCategory()));
        sanitized.setDescription(sanitizeString(expense.getDescription()));
        sanitized.setExpenseDate(expense.getExpenseDate());
        sanitized.setCreatedAt(expense.getCreatedAt());
        sanitized.setUpdatedAt(expense.getUpdatedAt());
        
        return sanitized;
    }
}
