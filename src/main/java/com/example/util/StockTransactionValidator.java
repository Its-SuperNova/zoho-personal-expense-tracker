package com.example.util;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

public class StockTransactionValidator {
    
    public static List<String> validateStockTransaction(String transactionType, String stockSymbol, 
                                                      String stockName, String quantity, 
                                                      String pricePerShare, String transactionDate) {
        List<String> errors = new ArrayList<>();
        
        // Validate transaction type
        if (transactionType == null || transactionType.trim().isEmpty()) {
            errors.add("Transaction type is required");
        } else if (!transactionType.toUpperCase().equals("BUY") && !transactionType.toUpperCase().equals("SELL")) {
            errors.add("Transaction type must be either BUY or SELL");
        }
        
        // Validate stock symbol
        if (stockSymbol == null || stockSymbol.trim().isEmpty()) {
            errors.add("Stock symbol is required");
        } else if (stockSymbol.trim().length() < 1 || stockSymbol.trim().length() > 10) {
            errors.add("Stock symbol must be between 1 and 10 characters");
        }
        
        // Validate stock name
        if (stockName == null || stockName.trim().isEmpty()) {
            errors.add("Stock name is required");
        } else if (stockName.trim().length() < 2 || stockName.trim().length() > 100) {
            errors.add("Stock name must be between 2 and 100 characters");
        }
        
        // Validate quantity
        if (quantity == null || quantity.trim().isEmpty()) {
            errors.add("Quantity is required");
        } else {
            try {
                int quantityInt = Integer.parseInt(quantity.trim());
                if (quantityInt <= 0) {
                    errors.add("Quantity must be greater than 0");
                } else if (quantityInt > 1000000) {
                    errors.add("Quantity cannot exceed 1,000,000");
                }
            } catch (NumberFormatException e) {
                errors.add("Quantity must be a valid integer");
            }
        }
        
        // Validate price per share
        if (pricePerShare == null || pricePerShare.trim().isEmpty()) {
            errors.add("Price per share is required");
        } else {
            try {
                BigDecimal price = new BigDecimal(pricePerShare.trim());
                if (price.compareTo(BigDecimal.ZERO) <= 0) {
                    errors.add("Price per share must be greater than 0");
                } else if (price.compareTo(new BigDecimal("10000")) > 0) {
                    errors.add("Price per share cannot exceed $10,000");
                }
            } catch (NumberFormatException e) {
                errors.add("Price per share must be a valid number");
            }
        }
        
        // Validate transaction date
        if (transactionDate == null || transactionDate.trim().isEmpty()) {
            errors.add("Transaction date is required");
        } else {
            try {
                LocalDate date = LocalDate.parse(transactionDate.trim());
                LocalDate today = LocalDate.now();
                LocalDate oneYearAgo = today.minusYears(1);
                
                if (date.isAfter(today)) {
                    errors.add("Transaction date cannot be in the future");
                } else if (date.isBefore(oneYearAgo)) {
                    errors.add("Transaction date cannot be more than 1 year ago");
                }
            } catch (DateTimeParseException e) {
                errors.add("Transaction date must be a valid date (YYYY-MM-DD)");
            }
        }
        
        return errors;
    }
}
