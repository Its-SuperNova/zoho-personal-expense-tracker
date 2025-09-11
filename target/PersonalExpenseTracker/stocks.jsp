<%@ page import="java.util.List" %>
<%@ page import="com.example.model.StockTransaction" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stock Transactions - Personal Expense Tracker</title>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        background-color: #f8f9fa;
        color: #333;
        line-height: 1.5;
      }

      .main-layout {
        display: flex;
        min-height: 100vh;
      }

      /* Updated sidebar to match expenses page exactly */
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

      /* Updated main content area with proper spacing and compact design */
      .main-content {
        flex: 1;
        margin-left: 240px;
        background-color: #fff;
      }

      .top-navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 24px;
        background-color: white;
        border-bottom: 1px solid #e5e7eb;
      }

      .top-navbar h1 {
        font-size: 20px;
        font-weight: 600;
        color: #111;
        margin: 0;
      }

      .content-area {
        padding: 20px 24px;
      }

      /* Compact stats cards matching dashboard design */
      .stats-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        margin-bottom: 24px;
      }

      .stat-card {
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        padding: 16px;
      }

      .stat-value {
        font-size: 20px;
        font-weight: 600;
        color: #111;
        margin-bottom: 4px;
      }

      .stat-label {
        font-size: 12px;
        color: #6b7280;
        font-weight: 500;
      }

      .stat-change {
        font-size: 11px;
        font-weight: 500;
        margin-top: 4px;
      }

      .stat-change.positive {
        color: #059669;
      }

      .stat-change.negative {
        color: #dc2626;
      }

      /* Updated table design to match reference image */
      .table-container {
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        overflow: hidden;
        margin-top: 24px;
      }

      .table-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 20px;
        border-bottom: 1px solid #e5e7eb;
        background-color: #f9fafb;
      }

      .table-title {
        font-size: 14px;
        font-weight: 600;
        color: #111;
        margin: 0;
      }

      .table-actions {
        display: flex;
        gap: 8px;
      }

      .table {
        width: 100%;
        border-collapse: collapse;
      }

      .table th {
        background-color: #f9fafb;
        padding: 12px 16px;
        text-align: left;
        font-size: 12px;
        font-weight: 600;
        color: #374151;
        border-bottom: 1px solid #e5e7eb;
      }

      .table td {
        padding: 12px 16px;
        font-size: 13px;
        color: #111;
        border-bottom: 1px solid #f3f4f6;
      }

      .table tbody tr:hover {
        background-color: #f9fafb;
      }

      /* Compact button styles matching dashboard */
      .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 6px 12px;
        font-size: 13px;
        font-weight: 500;
        border-radius: 6px;
        border: 1px solid transparent;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.2s;
      }

      .btn-primary {
        background-color: #000;
        color: white;
        border-color: #000;
      }

      .btn-primary svg {
        fill: white;
      }

      .btn-primary:hover {
        background-color: #1a1a1a;
      }

      .btn-outline {
        background-color: transparent;
        color: #374151;
        border-color: #d1d5db;
      }

      .btn-outline:hover {
        background-color: #f3f4f6;
      }

      .btn-sm {
        padding: 4px 8px;
        font-size: 12px;
      }

      .status-badge {
        padding: 2px 8px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
      }

      .status-buy {
        background-color: #dcfce7;
        color: #166534;
      }

      .status-sell {
        background-color: #fef2f2;
        color: #991b1b;
      }

      /* Quick Actions Grid */
      .quick-actions {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 12px;
        margin-bottom: 24px;
      }

      .quick-action-btn {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 16px;
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        text-decoration: none;
        color: #374151;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.2s;
      }

      .quick-action-btn:hover {
        background-color: #f9fafb;
        border-color: #d1d5db;
      }

      .quick-action-icon {
        width: 20px;
        height: 20px;
        margin-bottom: 8px;
        fill: currentColor;
      }

      /* Modal Styles */
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
      }

      .modal-content {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        border-radius: 8px;
        padding: 24px;
        width: 90%;
        max-width: 500px;
      }

      .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
      }

      .modal-title {
        font-size: 16px;
        font-weight: 600;
        color: #111;
        margin: 0;
      }

      .modal-close {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
        color: #6b7280;
      }

      .form-group {
        margin-bottom: 16px;
      }

      .form-label {
        display: block;
        font-size: 13px;
        font-weight: 500;
        color: #374151;
        margin-bottom: 6px;
      }

      .form-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 13px;
        color: #111;
      }

      .form-input:focus {
        outline: none;
        border-color: #000;
        box-shadow: 0 0 0 1px #000;
      }

      .total-display {
        padding: 12px;
        background: #f9fafb;
        border-radius: 6px;
        font-weight: 600;
        font-size: 16px;
        color: #111;
      }

      .form-actions {
        display: flex;
        gap: 12px;
        margin-top: 20px;
      }

      .form-actions .btn {
        flex: 1;
        padding: 10px;
      }
    </style>
  </head>
  <body>
    <div class="main-layout">
      <!-- Updated sidebar to match expenses page exactly -->
      <nav class="sidebar">
        <div class="nav-brand">
          <h2>Expense Tracker</h2>
        </div>

        <div class="search-box">
          <input type="text" class="search-input" placeholder="Search" />
        </div>

        <ul class="nav-menu">
          <li class="nav-item">
            <a href="dashboard" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"
                />
              </svg>
              Dashboard
            </a>
          </li>
          <li class="nav-item">
            <a href="expenses" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                />
              </svg>
              Expenses
            </a>
          </li>
          <li class="nav-item">
            <a href="stocks" class="nav-link active">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6z"
                />
              </svg>
              Stocks
            </a>
          </li>
          <li class="nav-item">
            <a href="portfolio.html" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                />
              </svg>
              Portfolio
            </a>
          </li>
          <li class="nav-item">
            <a href="predictions.html" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path d="M9 11H7v9h2v-9zm4-4h-2v13h2V7zm4-4h-2v17h2V3z" />
              </svg>
              Predictions
            </a>
          </li>
          <li class="nav-item">
            <a href="analytics.html" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"
                />
              </svg>
              Analytics
            </a>
          </li>
          <li class="nav-item">
            <a href="profile.html" class="nav-link">
              <svg class="nav-icon" viewBox="0 0 24 24">
                <path
                  d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"
                />
              </svg>
              Profile
            </a>
          </li>
        </ul>
      </nav>

      <!-- Updated main content with compact header and improved layout -->
      <main class="main-content">
        <header class="top-navbar">
          <div>
            <h1 class="page-title">Stocks</h1>
          </div>
          <div class="navbar-actions">
            <!-- Updated Log Transaction button with white plus icon -->
            <button id="addTransactionBtn" class="btn btn-primary">
              <svg
                style="
                  width: 16px;
                  height: 16px;
                  margin-right: 0.5rem;
                  fill: white;
                "
                viewBox="0 0 24 24"
              >
                <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" />
              </svg>
              Log Transaction
            </button>
          </div>
        </header>

        <div class="content-area">
          <!-- Success/Error Messages -->
          <%
            String success = (String) session.getAttribute("success");
            String error = (String) session.getAttribute("error");
            if (success != null) {
              session.removeAttribute("success");
          %>
          <div style="background-color: #d1fae5; color: #065f46; padding: 12px; border-radius: 6px; margin-bottom: 1rem; border: 1px solid #a7f3d0;">
            <%= success %>
          </div>
          <%
            }
            if (error != null) {
              session.removeAttribute("error");
          %>
          <div style="background-color: #fee2e2; color: #991b1b; padding: 12px; border-radius: 6px; margin-bottom: 1rem; border: 1px solid #fca5a5;">
            <%= error %>
          </div>
          <%
            }
          %>

          <!-- Compact stats cards matching dashboard design -->
           <div class="stats-grid">
             <div class="stat-card">
               <div class="stat-value">$<%= request.getAttribute("portfolioValue") != null ? request.getAttribute("portfolioValue") : "0.00" %></div>
               <div class="stat-label">Portfolio Value</div>
               <div class="stat-change positive">+21.5%</div>
             </div>
             <div class="stat-card">
               <div class="stat-value">$<%= request.getAttribute("totalInvested") != null ? request.getAttribute("totalInvested") : "0.00" %></div>
               <div class="stat-label">Total Invested</div>
               <div class="stat-change positive">vs last month</div>
             </div>
             <div class="stat-card">
               <div class="stat-value">+$<%= request.getAttribute("totalGainLoss") != null ? request.getAttribute("totalGainLoss") : "0.00" %></div>
               <div class="stat-label">Total Gain/Loss</div>
               <div class="stat-change positive">+21.5%</div>
             </div>
             <div class="stat-card">
               <div class="stat-value"><%= request.getAttribute("totalTransactions") != null ? request.getAttribute("totalTransactions") : "0" %></div>
               <div class="stat-label">Total Transactions</div>
               <div class="stat-change positive">+8%</div>
             </div>
           </div>

          <!-- Compact quick actions grid -->
          <div class="quick-actions">
            <button
              class="quick-action-btn"
              onclick="openTransactionModal('buy')"
            >
              <svg class="quick-action-icon" viewBox="0 0 24 24">
                <path d="M7 14l5-5 5 5z" />
              </svg>
              Buy Stock
            </button>
            <button
              class="quick-action-btn"
              onclick="openTransactionModal('sell')"
            >
              <svg class="quick-action-icon" viewBox="0 0 24 24">
                <path d="M7 10l5 5 5-5z" />
              </svg>
              Sell Stock
            </button>
            <a href="portfolio.html" class="quick-action-btn">
              <svg class="quick-action-icon" viewBox="0 0 24 24">
                <path
                  d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                />
              </svg>
              View Portfolio
            </a>
            <a href="analytics.html" class="quick-action-btn">
              <svg class="quick-action-icon" viewBox="0 0 24 24">
                <path
                  d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"
                />
              </svg>
              View Analytics
            </a>
          </div>

          <!-- Updated table design to match reference image with compact styling -->
          <div class="table-container">
            <div class="table-header">
              <h3 class="table-title">Recent Transactions</h3>
            </div>
            <table class="table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Type</th>
                  <th>Symbol</th>
                  <th>Company</th>
                  <th>Shares</th>
                  <th>Price</th>
                  <th>Total</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <%
                  List<StockTransaction> transactions = (List<StockTransaction>) request.getAttribute("transactions");
                  if (transactions != null && !transactions.isEmpty()) {
                    for (StockTransaction transaction : transactions) {
                %>
                <tr>
                  <td><%= transaction.getTransactionDate() %></td>
                  <td>
                    <span class="status-badge <%= transaction.getTransactionType().equals("BUY") ? "status-buy" : "status-sell" %>">
                      <%= transaction.getTransactionType() %>
                    </span>
                  </td>
                  <td style="font-weight: 600"><%= transaction.getStockSymbol() %></td>
                  <td><%= transaction.getStockName() %></td>
                  <td><%= transaction.getQuantity() %></td>
                  <td>$<%= transaction.getPricePerShare() %></td>
                  <td style="font-weight: 600">$<%= transaction.getTotalAmount() %></td>
                  <td>
                    <button
                      class="btn btn-outline btn-sm"
                      onclick="editTransaction('<%= transaction.getId() %>')"
                    >
                      Edit
                    </button>
                    <button
                      class="btn btn-outline btn-sm"
                      style="
                        color: #dc2626;
                        border-color: #dc2626;
                        margin-left: 4px;
                      "
                      onclick="deleteTransaction('<%= transaction.getId() %>')"
                    >
                      Delete
                    </button>
                  </td>
                </tr>
                <%
                    }
                  } else {
                %>
                <tr>
                  <td colspan="8" style="text-align: center; padding: 40px; color: #64748b;">
                    No stock transactions found. <a href="#" onclick="openTransactionModal()" style="color: #3b82f6;">Add your first transaction</a>
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

    <!-- Updated modal with improved styling -->
    <div id="transactionModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 id="transactionModalTitle" class="modal-title">
            Log Stock Transaction
          </h3>
          <button id="closeTransactionModal" class="modal-close">
            &times;
          </button>
        </div>

        <form id="transactionForm" action="add-stock-transaction" method="POST">
          <input type="hidden" id="transactionId" name="transactionId" value="">
          
          <div class="form-group">
            <label for="transactionType" class="form-label"
              >Transaction Type</label
            >
            <select id="transactionType" name="transactionType" class="form-input" required>
              <option value="">Select Type</option>
              <option value="BUY">Buy</option>
              <option value="SELL">Sell</option>
            </select>
          </div>

          <div class="form-group">
            <label for="transactionDate" class="form-label">Date</label>
            <input
              type="date"
              id="transactionDate"
              name="transactionDate"
              class="form-input"
              required
            />
          </div>

          <div class="form-group">
            <label for="stockSymbol" class="form-label">Stock Symbol</label>
            <input
              type="text"
              id="stockSymbol"
              name="stockSymbol"
              class="form-input"
              placeholder="e.g., AAPL, GOOGL, TSLA"
              style="text-transform: uppercase"
              required
            />
          </div>

          <div class="form-group">
            <label for="stockName" class="form-label">Stock Name</label>
            <input
              type="text"
              id="stockName"
              name="stockName"
              class="form-input"
              placeholder="e.g., Apple Inc."
              required
            />
          </div>

          <div class="form-group">
            <label for="quantity" class="form-label">Quantity</label>
            <input
              type="number"
              id="quantity"
              name="quantity"
              class="form-input"
              placeholder="0"
              min="1"
              required
            />
          </div>

          <div class="form-group">
            <label for="pricePerShare" class="form-label"
              >Price per Share ($)</label
            >
            <input
              type="number"
              id="pricePerShare"
              name="pricePerShare"
              class="form-input"
              placeholder="0.00"
              step="0.01"
              min="0"
              required
            />
          </div>

          <div class="form-group">
            <label class="form-label">Total Amount</label>
            <div id="totalAmount" class="total-display">$0.00</div>
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-primary">
              Save Transaction
            </button>
            <button
              type="button"
              id="cancelTransactionModal"
              class="btn btn-outline"
            >
              Cancel
            </button>
          </div>
        </form>
      </div>
    </div>

    <script>
      // Modal functionality
      const modal = document.getElementById("transactionModal");
      const addTransactionBtn = document.getElementById("addTransactionBtn");
      const closeModal = document.getElementById("closeTransactionModal");
      const cancelModal = document.getElementById("cancelTransactionModal");
      const transactionForm = document.getElementById("transactionForm");
      const modalTitle = document.getElementById("transactionModalTitle");

      let editingTransactionId = null;

      addTransactionBtn.addEventListener("click", () => {
        openTransactionModal();
      });

      function openTransactionModal(type = "") {
        editingTransactionId = null;
        modalTitle.textContent = "Log Stock Transaction";
        transactionForm.reset();
        document.getElementById("transactionId").value = "";
        document.getElementById("transactionDate").value = new Date()
          .toISOString()
          .split("T")[0];
        if (type) {
          document.getElementById("transactionType").value = type;
        }
        updateTotalAmount();
        modal.style.display = "block";
      }

      closeModal.addEventListener("click", () => {
        const transactionId = document.getElementById("transactionId").value;
        if (transactionId) {
          // In edit mode, redirect to stocks to clear edit state
          window.location.href = "stocks";
        } else {
          modal.style.display = "none";
        }
      });

      cancelModal.addEventListener("click", () => {
        const transactionId = document.getElementById("transactionId").value;
        if (transactionId) {
          // In edit mode, redirect to stocks to clear edit state
          window.location.href = "stocks";
        } else {
          modal.style.display = "none";
        }
      });

      modal.addEventListener("click", (e) => {
        if (e.target === modal) {
          const transactionId = document.getElementById("transactionId").value;
          if (transactionId) {
            // In edit mode, redirect to stocks to clear edit state
            window.location.href = "stocks";
          } else {
            modal.style.display = "none";
          }
        }
      });

      function updateTotalAmount() {
        const quantity = parseFloat(document.getElementById("quantity").value) || 0;
        const pricePerShare =
          parseFloat(document.getElementById("pricePerShare").value) || 0;
        const total = quantity * pricePerShare;
        const totalAmountElement = document.getElementById("totalAmount");
        if (totalAmountElement) {
          totalAmountElement.textContent = `$${total.toFixed(2)}`;
        }
      }

      document
        .getElementById("quantity")
        .addEventListener("input", updateTotalAmount);
      document
        .getElementById("pricePerShare")
        .addEventListener("input", updateTotalAmount);

      document.getElementById("stockSymbol").addEventListener("input", (e) => {
        e.target.value = e.target.value.toUpperCase();
      });

      transactionForm.addEventListener("submit", (e) => {
        const transactionId = document.getElementById("transactionId").value;
        
        if (transactionId) {
          // Edit mode - change form action
          transactionForm.action = "edit-stock-transaction";
        } else {
          // Add mode - keep default action
          transactionForm.action = "add-stock-transaction";
        }
        
        // Let the form submit normally
      });

      function editTransaction(id) {
        // Redirect to edit servlet
        window.location.href = "edit-stock-transaction?id=" + id;
      }

      function deleteTransaction(id) {
        if (confirm("Are you sure you want to delete this transaction?")) {
          // Create a form to submit delete request
          const form = document.createElement('form');
          form.method = 'POST';
          form.action = 'delete-stock-transaction';
          
          const input = document.createElement('input');
          input.type = 'hidden';
          input.name = 'transactionId';
          input.value = id;
          
          form.appendChild(input);
          document.body.appendChild(form);
          form.submit();
        }
      }
    </script>

    <!-- Edit Mode Initialization Script -->
    <%
        Boolean isEditMode = (Boolean) request.getAttribute("isEditMode");
        StockTransaction editingTransaction = (StockTransaction) request.getAttribute("editingStockTransaction");
        if (isEditMode != null && isEditMode && editingTransaction != null) {
    %>
    <script>
        // Initialize edit mode
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('transactionModal');
            const modalTitle = document.getElementById('transactionModalTitle');
            
            // Set edit mode data
            modalTitle.textContent = 'Edit Transaction';
            document.getElementById('transactionId').value = '<%= editingTransaction.getId() %>';
            document.getElementById('transactionType').value = '<%= editingTransaction.getTransactionType() %>';
            document.getElementById('transactionDate').value = '<%= editingTransaction.getTransactionDate() %>';
            document.getElementById('stockSymbol').value = '<%= editingTransaction.getStockSymbol() %>';
            document.getElementById('stockName').value = '<%= editingTransaction.getStockName() %>';
            document.getElementById('quantity').value = '<%= editingTransaction.getQuantity() %>';
            document.getElementById('pricePerShare').value = '<%= editingTransaction.getPricePerShare() %>';
            
            // Update total amount and show modal
            setTimeout(function() {
                updateTotalAmount();
                modal.style.display = 'block';
            }, 100);
        });
    </script>
    <%
        }
    %>
  </body>
</html>
