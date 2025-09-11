package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("All fields are required", "UTF-8"));
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("Passwords do not match", "UTF-8"));
            return;
        }

        // Check if username or email already exists
        try (Connection conn = DBConnection.getConnection()) {
            // Check if email exists
            PreparedStatement checkUser = conn.prepareStatement("SELECT id FROM users WHERE email = ?");
            checkUser.setString(1, email);
            ResultSet rs = checkUser.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("Email already exists", "UTF-8"));
                return;
            }

            // Insert new user
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users (full_name, email, password_hash) VALUES (?, ?, ?)");
            ps.setString(1, fullName.trim());
            ps.setString(2, email.trim());
            ps.setString(3, password); // In production, hash this password
            ps.executeUpdate();
            
            response.sendRedirect("login.jsp?success=" + java.net.URLEncoder.encode("Account created successfully! Please login.", "UTF-8"));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("Registration failed. Please try again.", "UTF-8"));
        }
    }
}