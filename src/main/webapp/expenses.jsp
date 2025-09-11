<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.util.List" %> <%@ page
import="com.example.model.Expense" %> <%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expenses - Personal Expense Tracker</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- Added comprehensive embedded CSS styles -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-black: #000000;
            --secondary-blue: #2563eb;
            --light-gray: #f8f9fa;
            --medium-gray: #e5e7eb;
            --dark-gray: #6b7280;
            --text-primary: #111827;
            --text-secondary: #6b7280;
            --white: #ffffff;
            --success-green: #10b981;
            --error-red: #ef4444;
            --warning-orange: #f59e0b;
            --border-color: #e5e7eb;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: #1f2937;
            background-color: #f8f9fa;
        }

        .material-icons {
            font-family: 'Material Icons';
            font-weight: normal;
            font-style: normal;
            font-size: 24px;
            line-height: 1;
            letter-spacing: normal;
            text-transform: none;
            display: inline-block;
            white-space: nowrap;
            word-wrap: normal;
            direction: ltr;
            -webkit-font-feature-settings: 'liga';
            font-feature-settings: 'liga';
            -webkit-font-smoothing: antialiased;
        }

        .main-layout {
            display: flex;
            min-height: 100vh;
        }

        /* Updated sidebar to pure black background with compact design */
        .sidebar {
            width: 240px;
            background-color: #000000;
            padding: 1rem 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }

        .nav-brand {
            padding: 0 1rem;
            margin-bottom: 1.5rem;
        }

        .nav-brand h2 {
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
        }

        .search-box {
            padding: 0 1rem;
            margin-bottom: 1rem;
        }

        .search-input {
            width: 100%;
            padding: 0.5rem 0.75rem;
            background-color: #1f2937;
            border: 1px solid #374151;
            border-radius: 6px;
            color: #ffffff;
            font-size: 0.875rem;
        }

        .search-input::placeholder {
            color: #9ca3af;
        }

        .nav-menu {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.125rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.625rem 1rem;
            color: #9ca3af;
            text-decoration: none;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }

        .nav-link:hover {
            background-color: #1f2937;
            color: #ffffff;
        }

        .nav-link.active {
            background-color: #1f2937;
            color: #ffffff;
        }

        .nav-icon {
            width: 16px;
            height: 16px;
            margin-right: 0.75rem;
            fill: currentColor;
        }

        /* Updated main content to account for fixed sidebar */
        .main-content {
            flex: 1;
            margin-left: 240px;
            display: flex;
            flex-direction: column;
        }

        .top-navbar {
            background-color: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin: 0;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .content-area {
            padding: 1.5rem;
            flex: 1;
        }

        /* Smaller, more compact stats cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-card {
            background: #ffffff;
            padding: 1rem;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #6b7280;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1f2937;
        }

        .stat-change {
            font-size: 0.75rem;
            color: #10b981;
        }


        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #6b7280;
            font-size: 0.75rem;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.875rem;
            background-color: #ffffff;
            color: #1f2937;
        }

        .form-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        /* Compact table design matching reference */
        .table-section {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            overflow: hidden;
        }

        .table-header {
            padding: 1rem;
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 0.875rem;
            font-weight: 600;
            color: #1f2937;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th,
        .table td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #f3f4f6;
            font-size: 0.875rem;
        }

        .table th {
            background-color: #f9fafb;
            font-weight: 500;
            color: #6b7280;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .table td {
            color: #1f2937;
        }

        .category-badge {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            background-color: #f3f4f6;
            color: #6b7280;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .amount-negative {
            color: #ef4444;
            font-weight: 600;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            border: 1px solid transparent;
            transition: all 0.2s ease;
            font-size: 0.875rem;
            background: none;
        }

        .btn-primary {
            background-color: #000000;
            color: #ffffff;
            border-color: #000000;
        }

        .btn-primary:hover {
            background-color: #1f2937;
            border-color: #1f2937;
        }

        .btn-secondary {
            background-color: #f3f4f6;
            color: #6b7280;
            border-color: #d1d5db;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
            color: #374151;
        }

        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }

        .btn-danger {
            color: #ef4444;
            border-color: #ef4444;
        }

        .btn-danger:hover {
            background-color: #ef4444;
            color: #ffffff;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            width: 90%;
            max-width: 500px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1f2937;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #6b7280;
        }

        .close-btn:hover {
            color: #1f2937;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }
            
            .main-content {
                margin-left: 200px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
  </head>
  <body>
    <div class="main-layout">
        <!-- Updated sidebar with black background and compact navigation -->
        <nav class="sidebar">
            <div class="nav-brand">
                <h2>Expense Tracker</h2>
            </div>
            
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search">
            </div>
            
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="dashboard" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"/>
                        </svg>
                        Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a href="expenses" class="nav-link active">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                        </svg>
                        Expenses
                    </a>
                </li>
                <li class="nav-item">
                    <a href="stocks" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6z"/>
                        </svg>
                        Stocks
                    </a>
                </li>
                <li class="nav-item">
                    <a href="portfolio" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                        </svg>
                        Portfolio
                    </a>
                </li>
                <li class="nav-item">
                    <a href="predictions" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M9 11H7v9h2v-9zm4-4h-2v13h2V7zm4-4h-2v17h2V3z"/>
                        </svg>
                        Predictions
                    </a>
                </li>
                <li class="nav-item">
                    <a href="analytics" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
                        </svg>
                        Analytics
                    </a>
                </li>
                <li class="nav-item">
                    <a href="profile" class="nav-link">
                        <svg class="nav-icon" viewBox="0 0 24 24">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                        Profile
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Success/Error Messages -->
            <%
                String success = (String) session.getAttribute("success");
                String error = (String) session.getAttribute("error");
                if (success != null) {
                    session.removeAttribute("success");
            %>
            <div style="background-color: #d1fae5; color: #065f46; padding: 1rem; margin: 1rem 1.5rem; border-radius: 6px; border: 1px solid #a7f3d0;">
                <%= success %>
            </div>
            <%
                }
                if (error != null) {
                    session.removeAttribute("error");
            %>
            <div style="background-color: #fee2e2; color: #991b1b; padding: 1rem; margin: 1rem 1.5rem; border-radius: 6px; border: 1px solid #fca5a5;">
                <%= error %>
            </div>
            <%
                }
            %>
            
            <!-- Simplified top navbar with compact design -->
            <header class="top-navbar">
                <div>
                    <h1 class="page-title">Expenses</h1>
                </div>
                <div class="navbar-actions">
                    <button id="addExpenseBtn" class="btn btn-primary">
                        <svg style="width: 16px; height: 16px; margin-right: 0.5rem;" viewBox="0 0 24 24" fill="white">
                            <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/>
                        </svg>
                        Add New Expense
                    </button>
                </div>
            </header>

            <!-- Expenses Content -->
            <div class="content-area">
                <!-- Compact stats cards matching reference design -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-label">Total Expenses</div>
                        </div>
                        <div class="stat-value">$<%= request.getAttribute("totalExpenses") != null ? request.getAttribute("totalExpenses") : "0.00" %></div>
                        <div class="stat-change">vs last month <span class="material-icons" style="font-size: 14px; vertical-align: middle;">trending_up</span> 8%</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-label">This Month</div>
                        </div>
                        <div class="stat-value">$<%= request.getAttribute("monthlyExpenses") != null ? request.getAttribute("monthlyExpenses") : "0.00" %></div>
                        <div class="stat-change">vs last month <span class="material-icons" style="font-size: 14px; vertical-align: middle;">trending_up</span> 12%</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-label">Categories</div>
                        </div>
                        <div class="stat-value"><%= request.getAttribute("categoryCount") != null ? request.getAttribute("categoryCount") : "0" %></div>
                        <div class="stat-change">unique categories</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-label">Total Records</div>
                        </div>
                        <div class="stat-value"><%= request.getAttribute("expenseCount") != null ? request.getAttribute("expenseCount") : "0" %></div>
                        <div class="stat-change">expense entries</div>
                    </div>
                </div>


                <!-- Clean table design matching reference -->
                <div class="table-section">
                    <div class="table-header">
                        <div class="table-title">Expense History</div>
                        <div style="font-size: 0.75rem; color: #6b7280;">Showing 1-10 of 127 expenses</div>
                    </div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Category</th>
                                <th>Amount</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="expensesTableBody">
                            <%
                                List<Expense> expenses = (List<Expense>) request.getAttribute("expenses");
                                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
                                
                                if (expenses != null && !expenses.isEmpty()) {
                                    for (Expense expense : expenses) {
                            %>
                            <tr>
                                <td><%= expense.getExpenseDate().format(dateFormatter) %></td>
                                <td><%= expense.getDescription() != null ? expense.getDescription() : "" %></td>
                                <td>
                                    <span class="category-tag <%= expense.getCategory().toLowerCase().replaceAll("\\s+", "") %>">
                                        <%= expense.getCategory() %>
                                    </span>
                                </td>
                                <td class="amount-negative">$<%= expense.getAmount() %></td>
                                <td>
                                    <button class="btn btn-secondary btn-sm" onclick="editExpense('<%= expense.getId() %>')" style="margin-right: 0.5rem;">Edit</button>
                                    <button class="btn btn-danger btn-sm" onclick="deleteExpense('<%= expense.getId() %>')">Delete</button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 40px; color: #64748b;">
                                    No expenses found. <a href="#" onclick="openAddExpenseModal()" style="color: #3b82f6;">Add your first expense</a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Add/Edit Expense Modal -->
    <div id="expenseModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Add New Expense</h3>
                <button id="closeModal" class="close-btn">&times;</button>
            </div>
            
            <form id="expenseForm" method="POST" action="add-expense">
                <input type="hidden" id="expenseId" name="expenseId" value="">
                
                <div class="form-group">
                    <label for="expenseDate" class="form-label">Date</label>
                    <input type="date" id="expenseDate" name="date" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="expenseDescription" class="form-label">Description</label>
                    <input type="text" id="expenseDescription" name="description" class="form-input" placeholder="Enter expense description" required>
                </div>
                
                <div class="form-group">
                    <label for="expenseCategory" class="form-label">Category</label>
                    <select id="expenseCategory" name="category" class="form-input" required>
                        <option value="">Select Category</option>
                        <option value="Food & Dining">Food & Dining</option>
                        <option value="Transportation">Transportation</option>
                        <option value="Entertainment">Entertainment</option>
                        <option value="Shopping">Shopping</option>
                        <option value="Bills & Utilities">Bills & Utilities</option>
                        <option value="Healthcare">Healthcare</option>
                        <option value="Education">Education</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="expenseAmount" class="form-label">Amount ($)</label>
                    <input type="number" id="expenseAmount" name="amount" class="form-input" placeholder="0.00" step="0.01" min="0" required>
                </div>
                
                <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                    <button type="submit" class="btn btn-primary" style="flex: 1;">Save Expense</button>
                    <button type="button" id="cancelModal" class="btn btn-secondary btn-sm" style="flex: 1;">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Mode Initialization Script -->
    <%
        Boolean isEditMode = (Boolean) request.getAttribute("isEditMode");
        Expense editingExpense = (Expense) request.getAttribute("editingExpense");
        if (isEditMode != null && isEditMode && editingExpense != null) {
    %>
    <script>
        // Initialize edit mode
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('expenseModal');
            const modalTitle = document.getElementById('modalTitle');
            
            // Set edit mode data
            window.editingExpenseId = '<%= editingExpense.getId() %>';
            modalTitle.textContent = 'Edit Expense';
            document.getElementById('expenseId').value = '<%= editingExpense.getId() %>';
            document.getElementById('expenseDate').value = '<%= editingExpense.getExpenseDate() %>';
            document.getElementById('expenseDescription').value = '<%= editingExpense.getDescription() != null ? editingExpense.getDescription() : "" %>';
            document.getElementById('expenseCategory').value = '<%= editingExpense.getCategory() %>';
            document.getElementById('expenseAmount').value = '<%= editingExpense.getAmount() %>';
            modal.style.display = 'block';
        });
    </script>
    <%
        }
    %>

    <script>
        // Modal functionality
        const modal = document.getElementById('expenseModal');
        const addExpenseBtn = document.getElementById('addExpenseBtn');
        const closeModal = document.getElementById('closeModal');
        const cancelModal = document.getElementById('cancelModal');
        const expenseForm = document.getElementById('expenseForm');
        const modalTitle = document.getElementById('modalTitle');

        let editingExpenseId = window.editingExpenseId || null;

        addExpenseBtn.addEventListener('click', () => {
            editingExpenseId = null;
            modalTitle.textContent = 'Add New Expense';
            expenseForm.reset();
            document.getElementById('expenseId').value = ''; // Clear expense ID for new expense
            document.getElementById('expenseDate').value = new Date().toISOString().split('T')[0];
            modal.style.display = 'block';
        });

        closeModal.addEventListener('click', () => {
            if (editingExpenseId) {
                // If in edit mode, redirect to expenses to clear edit state
                window.location.href = 'expenses';
            } else {
                modal.style.display = 'none';
            }
        });

        cancelModal.addEventListener('click', () => {
            if (editingExpenseId) {
                // If in edit mode, redirect to expenses to clear edit state
                window.location.href = 'expenses';
            } else {
                modal.style.display = 'none';
            }
        });

        // Close modal when clicking outside
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                if (editingExpenseId) {
                    // If in edit mode, redirect to expenses to clear edit state
                    window.location.href = 'expenses';
                } else {
                    modal.style.display = 'none';
                }
            }
        });

        // Form submission
        expenseForm.addEventListener('submit', (e) => {
            // Don't prevent default - let the form submit normally
            const expenseIdValue = document.getElementById('expenseId').value;
            console.log('Form submission - expenseIdValue:', expenseIdValue);
            if (expenseIdValue && expenseIdValue.trim() !== '') {
                expenseForm.action = 'edit-expense';
                console.log('Setting form action to: edit-expense');
            } else {
                expenseForm.action = 'add-expense';
                console.log('Setting form action to: add-expense');
            }
            console.log('Final form action:', expenseForm.action);
            console.log('Form data:', new FormData(expenseForm));
        });

        // Edit expense function
        function editExpense(id) {
            window.location.href = 'edit-expense?id=' + id;
        }

        // Delete expense function
        function deleteExpense(id) {
            if (confirm('Are you sure you want to delete this expense?')) {
                // Create a form to submit the delete request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'delete-expense';
                
                const expenseIdInput = document.createElement('input');
                expenseIdInput.type = 'hidden';
                expenseIdInput.name = 'expenseId';
                expenseIdInput.value = id;
                
                form.appendChild(expenseIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

    </script>
  </body>
</html>

