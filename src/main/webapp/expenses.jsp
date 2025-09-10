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
            <div class="stat-value" id="totalExpenses">$0.00</div>
            <div class="stat-label">Total Expenses</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">
            <span class="material-icons">trending_up</span>
          </div>
          <div class="stat-content">
            <div class="stat-value" id="monthlyExpenses">$0.00</div>
            <div class="stat-label">This Month</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">
            <span class="material-icons">category</span>
          </div>
          <div class="stat-content">
            <div class="stat-value" id="categoryCount">0</div>
            <div class="stat-label">Categories</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">
            <span class="material-icons">receipt</span>
          </div>
          <div class="stat-content">
            <div class="stat-value" id="expenseCount">0</div>
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
              <tr>
                <td>Jan 15, 2024</td>
                <td>
                  <span class="category-tag food">Food</span>
                </td>
                <td>Lunch at restaurant</td>
                <td class="amount">$25.50</td>
                <td class="actions">
                  <button
                    class="action-btn"
                    onclick="editExpense(1)"
                    title="Edit"
                  >
                    <span class="material-icons">edit</span>
                  </button>
                  <button
                    class="action-btn delete"
                    onclick="deleteExpense(1)"
                    title="Delete"
                  >
                    <span class="material-icons">delete</span>
                  </button>
                </td>
              </tr>
              <tr>
                <td>Jan 14, 2024</td>
                <td>
                  <span class="category-tag transport">Transportation</span>
                </td>
                <td>Uber ride to office</td>
                <td class="amount">$12.00</td>
                <td class="actions">
                  <button
                    class="action-btn"
                    onclick="editExpense(2)"
                    title="Edit"
                  >
                    <span class="material-icons">edit</span>
                  </button>
                  <button
                    class="action-btn delete"
                    onclick="deleteExpense(2)"
                    title="Delete"
                  >
                    <span class="material-icons">delete</span>
                  </button>
                </td>
              </tr>
              <tr>
                <td>Jan 13, 2024</td>
                <td>
                  <span class="category-tag entertainment">Entertainment</span>
                </td>
                <td>Movie tickets</td>
                <td class="amount">$18.00</td>
                <td class="actions">
                  <button
                    class="action-btn"
                    onclick="editExpense(3)"
                    title="Edit"
                  >
                    <span class="material-icons">edit</span>
                  </button>
                  <button
                    class="action-btn delete"
                    onclick="deleteExpense(3)"
                    title="Delete"
                  >
                    <span class="material-icons">delete</span>
                  </button>
                </td>
              </tr>
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
          <h3 id="modalTitle">Add New Expense</h3>
          <button class="modal-close" onclick="closeExpenseModal()">
            <span class="material-icons">close</span>
          </button>
        </div>
        <form id="expenseForm" class="expense-form">
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
                required
              />
            </div>
            <div class="form-field">
              <label for="expenseDate">Date</label>
              <input type="date" id="expenseDate" name="date" required />
            </div>
          </div>
          <div class="form-field">
            <label for="expenseCategory">Category</label>
            <select id="expenseCategory" name="category" required>
              <option value="">Select Category</option>
              <option value="Food">Food</option>
              <option value="Transportation">Transportation</option>
              <option value="Entertainment">Entertainment</option>
              <option value="Shopping">Shopping</option>
              <option value="Bills">Bills</option>
              <option value="Healthcare">Healthcare</option>
              <option value="Education">Education</option>
              <option value="Other">Other</option>
            </select>
          </div>
          <div class="form-field">
            <label for="expenseDescription">Description</label>
            <textarea
              id="expenseDescription"
              name="description"
              rows="3"
              placeholder="Enter expense description..."
            ></textarea>
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
              Add Expense
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
      // Set today's date as default
      document.getElementById("expenseDate").valueAsDate = new Date();

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
      }

      function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
      }

      // Form submission
      document
        .getElementById("expenseForm")
        .addEventListener("submit", function (e) {
          e.preventDefault();
          // Handle form submission here
          alert("Expense added successfully!");
          closeExpenseModal();
        });

      // Edit expense
      function editExpense(id) {
        document.getElementById("modalTitle").textContent = "Edit Expense";
        document.getElementById("submitBtn").textContent = "Update Expense";
        // Populate form with existing data
        document.getElementById("expenseModal").style.display = "block";
      }

      // Delete expense
      function deleteExpense(id) {
        document.getElementById("deleteModal").style.display = "block";
      }

      function confirmDelete() {
        // Handle delete here
        alert("Expense deleted successfully!");
        closeDeleteModal();
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
