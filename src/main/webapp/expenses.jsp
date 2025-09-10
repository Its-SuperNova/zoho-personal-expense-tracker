<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Expense" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Expense Management - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/expenses.css" />
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />
    <!-- Added Google Fonts for better typography -->
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
      <div class="expenses-container">
        <!-- Success/Error Messages -->
        <%
          String success = (String) session.getAttribute("success");
          String error = (String) session.getAttribute("error");
          if (success != null) {
        %>
        <div class="alert alert-success" style="background: #d1fae5; color: #065f46; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px; border: 1px solid #a7f3d0;">
          <%= success %>
        </div>
        <%
            session.removeAttribute("success");
          }
          if (error != null) {
        %>
        <div class="alert alert-error" style="background: #fee2e2; color: #991b1b; padding: 12px 16px; border-radius: 8px; margin-bottom: 16px; border: 1px solid #fca5a5;">
          <%= error %>
        </div>
        <%
            session.removeAttribute("error");
          }
        %>
        
        <div class="page-header">
        <!-- Redesigned header with better spacing and typography -->
        <a href="dashboard.jsp" class="back-btn">
          <span class="material-icons">arrow_back</span>
        </a>
        <div class="page-title">
          <h1>Expense Management</h1>
          <p>Track and manage your personal expenses efficiently</p>
        </div>
      </div>

      <!-- Simplified header section with cleaner layout -->
      <div class="main-header">
        <div class="header-actions">
          <button class="btn-primary" onclick="openAddExpenseModal()">
            <span class="material-icons">add</span>
            Add Expense
          </button>
        </div>
      </div>

      <!-- Redesigned summary cards with modern styling -->
      <div class="stats-grid">
         <div class="stat-card primary">
           <div class="stat-icon">
             <span class="material-icons">account_balance_wallet</span>
           </div>
           <div class="stat-content">
             <div class="stat-value" id="totalExpenses">$<%= request.getAttribute("totalExpenses") != null ? request.getAttribute("totalExpenses") : "0.00" %></div>
             <div class="stat-label">Total Expenses</div>
           </div>
         </div>
         <div class="stat-card">
           <div class="stat-icon">
             <span class="material-icons">trending_up</span>
           </div>
           <div class="stat-content">
             <div class="stat-value" id="monthlyExpenses">$<%= request.getAttribute("monthlyExpenses") != null ? request.getAttribute("monthlyExpenses") : "0.00" %></div>
             <div class="stat-label">This Month</div>
           </div>
         </div>
         <div class="stat-card">
           <div class="stat-icon">
             <span class="material-icons">category</span>
           </div>
           <div class="stat-content">
             <div class="stat-value" id="categoryCount"><%= request.getAttribute("categoryCount") != null ? request.getAttribute("categoryCount") : "0" %></div>
             <div class="stat-label">Categories</div>
           </div>
         </div>
         <div class="stat-card">
           <div class="stat-icon">
             <span class="material-icons">receipt</span>
           </div>
           <div class="stat-content">
             <div class="stat-value" id="expenseCount"><%= request.getAttribute("expenseCount") != null ? request.getAttribute("expenseCount") : "0" %></div>
             <div class="stat-label">Total Records</div>
           </div>
         </div>
      </div>

      <!-- Cleaner table design with improved spacing -->
      <div class="table-card">
        <div class="table-header">
          <h3>Recent Expenses</h3>
          <div class="table-actions">
            <button class="btn-ghost" onclick="exportExpenses()">
              <span class="material-icons">download</span>
              Export
            </button>
            <button class="btn-ghost" onclick="refreshExpenses()">
              <span class="material-icons">refresh</span>
            </button>
          </div>
        </div>

        <div class="table-container">
          <table class="data-table" id="expensesTable">
            <thead>
              <tr>
                <th>Date</th>
                <th>Category</th>
                <th>Description</th>
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
                 <td>
                   <span class="category-tag <%= expense.getCategory().toLowerCase().replaceAll("\\s+", "") %>"><%= expense.getCategory() %></span>
                 </td>
                 <td><%= expense.getDescription() != null ? expense.getDescription() : "" %></td>
                 <td class="amount">$<%= expense.getAmount() %></td>
                 <td class="actions">
                   <button
                     class="action-btn"
                     onclick="editExpense(<%= expense.getId() %>)"
                     title="Edit"
                   >
                     <span class="material-icons">edit</span>
                   </button>
                   <button
                     class="action-btn delete"
                     onclick="deleteExpense(<%= expense.getId() %>)"
                     title="Delete"
                   >
                     <span class="material-icons">delete</span>
                   </button>
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

        <!-- Simplified pagination design -->
        <div class="pagination">
          <div class="pagination-info">
            Showing <span id="showingStart">1</span>-<span id="showingEnd"
              >10</span
            >
            of <span id="totalRecords">25</span>
          </div>
          <div class="pagination-controls">
            <button class="page-btn" onclick="previousPage()" disabled>
              <span class="material-icons">chevron_left</span>
            </button>
            <div class="page-numbers">
              <button class="page-btn active">1</button>
              <button class="page-btn">2</button>
              <button class="page-btn">3</button>
            </div>
            <button class="page-btn" onclick="nextPage()">
              <span class="material-icons">chevron_right</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Redesigned modal with cleaner styling -->
    <div id="expenseModal" class="modal">
      <div class="modal-backdrop"></div>
      <div class="modal-content">
        <div class="modal-header">
          <h3 id="modalTitle"><%= request.getAttribute("isEditMode") != null ? "Edit Expense" : "Add New Expense" %></h3>
          <button class="modal-close" onclick="closeExpenseModal()">
            <span class="material-icons">close</span>
          </button>
        </div>
         <form id="expenseForm" class="expense-form" action="<%= request.getAttribute("isEditMode") != null ? "edit-expense" : "add-expense" %>" method="post">
           <% if (request.getAttribute("isEditMode") != null) { %>
           <input type="hidden" name="expenseId" value="<%= ((Expense)request.getAttribute("editingExpense")).getId() %>" />
           <% } %>
          <div class="form-grid">
            <div class="form-field">
              <label for="expenseAmount">Amount</label>
              <input
                type="number"
                id="expenseAmount"
                name="amount"
                step="0.01"
                min="0"
                placeholder="0.00"
                value="<%= request.getAttribute("isEditMode") != null ? ((Expense)request.getAttribute("editingExpense")).getAmount() : "" %>"
                required
              />
            </div>
            <div class="form-field">
              <label for="expenseDate">Date</label>
              <input type="date" id="expenseDate" name="date" value="<%= request.getAttribute("isEditMode") != null ? ((Expense)request.getAttribute("editingExpense")).getExpenseDate() : "" %>" required />
            </div>
          </div>
          <div class="form-field">
            <label for="expenseCategory">Category</label>
            <select id="expenseCategory" name="category" required>
              <option value="">Select Category</option>
              <option value="Food" <%= request.getAttribute("isEditMode") != null && "Food".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Food</option>
              <option value="Transportation" <%= request.getAttribute("isEditMode") != null && "Transportation".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Transportation</option>
              <option value="Entertainment" <%= request.getAttribute("isEditMode") != null && "Entertainment".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Entertainment</option>
              <option value="Shopping" <%= request.getAttribute("isEditMode") != null && "Shopping".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Shopping</option>
              <option value="Bills" <%= request.getAttribute("isEditMode") != null && "Bills".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Bills</option>
              <option value="Healthcare" <%= request.getAttribute("isEditMode") != null && "Healthcare".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Healthcare</option>
              <option value="Education" <%= request.getAttribute("isEditMode") != null && "Education".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Education</option>
              <option value="Other" <%= request.getAttribute("isEditMode") != null && "Other".equals(((Expense)request.getAttribute("editingExpense")).getCategory()) ? "selected" : "" %>>Other</option>
            </select>
          </div>
          <div class="form-field">
            <label for="expenseDescription">Description</label>
            <textarea
              id="expenseDescription"
              name="description"
              rows="3"
              placeholder="Enter expense description..."
            ><%= request.getAttribute("isEditMode") != null ? ((Expense)request.getAttribute("editingExpense")).getDescription() : "" %></textarea>
          </div>
          <div class="form-actions">
            <button
              type="button"
              class="btn-secondary"
              onclick="closeExpenseModal()"
            >
              Cancel
            </button>
            <button type="submit" class="btn-primary" id="submitBtn">
              <%= request.getAttribute("isEditMode") != null ? "Update Expense" : "Add Expense" %>
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- Simplified delete modal -->
    <div id="deleteModal" class="modal">
      <div class="modal-backdrop"></div>
      <div class="modal-content delete-modal">
        <div class="modal-header">
          <h3>Delete Expense</h3>
          <button class="modal-close" onclick="closeDeleteModal()">
            <span class="material-icons">close</span>
          </button>
        </div>
        <div class="modal-body">
          <p>
            Are you sure you want to delete this expense? This action cannot be
            undone.
          </p>
          <div class="expense-preview" id="deletePreview">
            <!-- Expense details will be populated here -->
          </div>
        </div>
        <div class="form-actions">
          <button
            type="button"
            class="btn-secondary"
            onclick="closeDeleteModal()"
          >
            Cancel
          </button>
          <button type="button" class="btn-danger" onclick="confirmDelete()">
            Delete Expense
          </button>
        </div>
      </div>
    </div>

    <!-- JavaScript for functionality -->
      <script>
        // Set today's date as default if not in edit mode
        <% if (request.getAttribute("isEditMode") == null) { %>
        document.getElementById("expenseDate").valueAsDate = new Date();
        <% } %>
        
        // Auto-open modal if in edit mode
        <% if (request.getAttribute("isEditMode") != null) { %>
        document.getElementById("expenseModal").style.display = "block";
        <% } %>

      // Modal functions
      function openAddExpenseModal() {
        document.getElementById("modalTitle").textContent = "Add New Expense";
        document.getElementById("submitBtn").textContent = "Add Expense";
        document.getElementById("expenseForm").reset();
        document.getElementById("expenseDate").valueAsDate = new Date();
        document.getElementById("expenseModal").style.display = "block";
      }

      function closeExpenseModal() {
        document.getElementById("expenseModal").style.display = "none";
        // Clear edit mode by redirecting to expenses page
        <% if (request.getAttribute("isEditMode") != null) { %>
        window.location.href = "expenses";
        <% } %>
      }

      function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
      }

       // Form submission is handled by the form action

       // Edit expense
       function editExpense(id) {
         window.location.href = "edit-expense?id=" + id;
       }

       // Delete expense
       function deleteExpense(id) {
         if (confirm("Are you sure you want to delete this expense? This action cannot be undone.")) {
           // Create a form to submit the delete request
           const form = document.createElement('form');
           form.method = 'POST';
           form.action = 'delete-expense';
           
           const input = document.createElement('input');
           input.type = 'hidden';
           input.name = 'expenseId';
           input.value = id;
           
           form.appendChild(input);
           document.body.appendChild(form);
           form.submit();
         }
       }

      // Export function
      function exportExpenses() {
        alert("Export functionality will be implemented");
      }

      // Refresh function
      function refreshExpenses() {
        alert("Refreshing expenses...");
      }

      // Pagination functions
      function previousPage() {
        alert("Previous page");
      }

      function nextPage() {
        alert("Next page");
      }

      // Close modals when clicking outside
      window.onclick = function (event) {
        const expenseModal = document.getElementById("expenseModal");
        const deleteModal = document.getElementById("deleteModal");

        if (
          event.target === expenseModal ||
          event.target.classList.contains("modal-backdrop")
        ) {
          closeExpenseModal();
        }
        if (
          event.target === deleteModal ||
          event.target.classList.contains("modal-backdrop")
        ) {
          closeDeleteModal();
        }
      };
    </script>
  </body>
</html>
