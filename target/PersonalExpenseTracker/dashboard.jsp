<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Personal Expense Tracker</title>
    <link
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        background: #f8f9fa;
        color: #1f2937;
        font-size: 14px;
      }

      .material-icons {
        font-family: "Material Icons";
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
        -webkit-font-feature-settings: "liga";
        -webkit-font-smoothing: antialiased;
      }

      .main-layout {
        display: flex;
        min-height: 100vh;
      }

      /* Redesigned sidebar to match reference with pure black background */
      .sidebar {
        width: 250px;
        background: #000000;
        padding: 0;
        position: relative;
      }

      .nav-brand {
        padding: 20px;
        border-bottom: 1px solid #333;
      }

      .nav-brand h2 {
        color: white;
        font-size: 16px;
        font-weight: 600;
        margin-bottom: 4px;
      }

      .nav-brand .tagline {
        color: #9ca3af;
        font-size: 12px;
        font-weight: 400;
      }

      .search-box {
        padding: 16px 20px;
        border-bottom: 1px solid #333;
      }

      .search-input {
        width: 100%;
        background: #1f2937;
        border: 1px solid #374151;
        border-radius: 6px;
        padding: 8px 12px;
        color: white;
        font-size: 13px;
      }

      .search-input::placeholder {
        color: #9ca3af;
      }

      .nav-section {
        padding: 16px 0;
      }

      .nav-section-title {
        color: #6b7280;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 0 20px 8px;
      }

      .nav-menu {
        list-style: none;
      }

      .nav-item {
        margin-bottom: 2px;
      }

      .nav-link {
        display: flex;
        align-items: center;
        padding: 10px 20px;
        color: #d1d5db;
        text-decoration: none;
        font-size: 14px;
        font-weight: 400;
        transition: all 0.2s;
      }

      .nav-link:hover {
        background: #1f2937;
        color: white;
      }

      .nav-link.active {
        background: #1f2937;
        color: white;
        border-right: 3px solid #f97316;
      }

      .nav-icon {
        width: 16px;
        height: 16px;
        margin-right: 12px;
        fill: currentColor;
      }

      .nav-count {
        margin-left: auto;
        background: #374151;
        color: #d1d5db;
        font-size: 11px;
        padding: 2px 6px;
        border-radius: 10px;
        min-width: 18px;
        text-align: center;
      }

      .logout-section {
        position: absolute;
        bottom: 20px;
        left: 20px;
        right: 20px;
      }

      .logout-card {
        background: #1f2937;
        border-radius: 8px;
        padding: 12px;
        border: 1px solid #374151;
      }

      .logout-btn {
        background: #ef4444;
        color: white;
        border: none;
        border-radius: 6px;
        padding: 10px 16px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: background-color 0.2s ease;
      }

      .logout-btn:hover {
        background: #dc2626;
      }

      /* Redesigned main content to match reference layout */
      .main-content {
        flex: 1;
        background: white;
      }

      .top-navbar {
        background: white;
        padding: 16px 24px;
        border-bottom: 1px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .navbar-title h1 {
        font-size: 20px;
        font-weight: 600;
        color: #111827;
        margin: 0;
      }

      .navbar-actions {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .user-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: #f3f4f6;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 600;
        color: #6b7280;
      }

      .content-area {
        padding: 24px;
      }

      .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
      }

      .content-title {
        font-size: 18px;
        font-weight: 600;
        color: #111827;
      }

      .header-actions {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .btn {
        display: inline-flex;
        align-items: center;
        padding: 8px 12px;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 500;
        text-decoration: none;
        cursor: pointer;
        border: 1px solid transparent;
        transition: all 0.2s;
      }

      .btn-primary {
        background: #111827;
        color: white;
        border-color: #111827;
      }

      .btn-secondary {
        background: white;
        color: #374151;
        border-color: #d1d5db;
      }

      .btn-icon {
        width: 14px;
        height: 14px;
        margin-right: 6px;
      }

      /* Compact stats cards matching reference design */
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

      .stat-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 8px;
      }

      .stat-label {
        font-size: 13px;
        color: #6b7280;
        font-weight: 500;
      }

      .stat-icon {
        width: 16px;
        height: 16px;
        color: #9ca3af;
      }

      .stat-value {
        font-size: 24px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 4px;
      }

      .stat-change {
        font-size: 12px;
        color: #6b7280;
      }

      .stat-trend {
        color: #10b981;
        font-weight: 500;
      }

      /* Table design matching reference interface */
      .data-table {
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        overflow: hidden;
      }

      .table-header {
        padding: 16px 20px;
        border-bottom: 1px solid #e5e7eb;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .table-controls {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .control-btn {
        display: flex;
        align-items: center;
        padding: 6px 10px;
        background: white;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 13px;
        color: #374151;
        cursor: pointer;
      }

      .control-icon {
        width: 14px;
        height: 14px;
        margin-right: 6px;
      }

      .toggle-switch {
        position: relative;
        width: 40px;
        height: 20px;
        background: #f97316;
        border-radius: 10px;
        cursor: pointer;
      }

      .toggle-switch::after {
        content: "";
        position: absolute;
        width: 16px;
        height: 16px;
        background: white;
        border-radius: 50%;
        top: 2px;
        right: 2px;
        transition: 0.2s;
      }

      table {
        width: 100%;
        border-collapse: collapse;
      }

      th {
        background: #f9fafb;
        padding: 12px 16px;
        text-align: left;
        font-size: 12px;
        font-weight: 600;
        color: #374151;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid #e5e7eb;
      }

      td {
        padding: 12px 16px;
        border-bottom: 1px solid #f3f4f6;
        font-size: 13px;
        color: #111827;
      }

      tr:hover {
        background: #f9fafb;
      }

      .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 500;
      }

      .status-in-stock {
        background: #dcfce7;
        color: #166534;
      }

      .status-out-stock {
        background: #fee2e2;
        color: #991b1b;
      }

      .status-restock {
        background: #fef3c7;
        color: #92400e;
      }

      .rating {
        display: flex;
        align-items: center;
        gap: 4px;
      }

      .star {
        width: 12px;
        height: 12px;
        fill: #fbbf24;
      }

      .pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 20px;
        border-top: 1px solid #e5e7eb;
      }

      .pagination-info {
        font-size: 13px;
        color: #6b7280;
      }

      .pagination-controls {
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .page-btn {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        background: white;
        color: #374151;
        font-size: 13px;
        cursor: pointer;
      }

      .page-btn.active {
        background: #f97316;
        color: white;
        border-color: #f97316;
      }

      @media (max-width: 1200px) {
        .stats-grid {
          grid-template-columns: repeat(2, 1fr);
        }
      }

      @media (max-width: 768px) {
        .sidebar {
          width: 200px;
        }

        .stats-grid {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <div class="main-layout">
      <!-- Redesigned sidebar to match reference exactly -->
      <nav class="sidebar">
        <div class="nav-brand">
          <h2>ExpenseTracker Inc.</h2>
          <div class="tagline">Free Plan</div>
        </div>

        <div class="search-box">
          <input type="text" class="search-input" placeholder="Search" />
        </div>

        <div class="nav-section">
          <div class="nav-section-title">Main Menu</div>
          <ul class="nav-menu">
            <li class="nav-item">
              <a href="dashboard.jsp" class="nav-link active">
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
                    d="M11.8 10.9c-2.27-.59-3-1.2-3-2.15 0-1.09 1.01-1.85 2.7-1.85 1.78 0 2.44.85 2.5 2.1h2.21c-.07-1.72-1.12-3.3-3.21-3.81V3h-3v2.16c-1.94.42-3.5 1.68-3.5 3.61 0 2.31 1.91 3.46 4.7 4.13 2.5.6 3 1.48 3 2.41 0 .69-.49 1.79-2.7 1.79-2.06 0-2.87-.92-2.98-2.1h-2.2c.12 2.19 1.76 3.42 3.68 3.83V21h3v-2.15c1.95-.37 3.5-1.5 3.5-3.55 0-2.84-2.43-3.81-4.7-4.4z"
                  />
                </svg>
                Expenses
              </a>
            </li>
            <li class="nav-item">
              <a href="stocks.jsp" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24">
                  <path
                    d="M16 6l2.29 2.29-4.88 4.88-4-4L2 16.59 3.41 18l6-6 4 4 6.3-6.29L22 12V6z"
                  />
                </svg>
                Stocks
              </a>
            </li>
            <li class="nav-item">
              <a href="portfolio.jsp" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24">
                  <path
                    d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                  />
                </svg>
                Portfolio
              </a>
            </li>
            <li class="nav-item">
              <a href="analytics.jsp" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24">
                  <path
                    d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"
                  />
                </svg>
                Analytics
              </a>
            </li>
            <li class="nav-item">
              <a href="predictions.jsp" class="nav-link">
                <svg class="nav-icon" viewBox="0 0 24 24">
                  <path d="M9 11H7v9h2v-9zm4-4h-2v13h2V7zm4-4h-2v17h2V3z" />
                </svg>
                Predictions
              </a>
            </li>
          </ul>
        </div>

        <div class="logout-section">
          <div class="logout-card">
            <button class="logout-btn" onclick="logout()">
              <span class="material-icons">logout</span>
              Logout
            </button>
          </div>
        </div>
      </nav>

      <!-- Redesigned main content area to match reference -->
      <main class="main-content">
        <header class="top-navbar">
          <div class="navbar-title">
            <h1>Expenses</h1>
          </div>
          <div class="navbar-actions">
            <div class="user-avatar">JD</div>
            <button class="btn btn-secondary">Customize Widget</button>
          </div>
        </header>

        <div class="content-area">
          <!-- Compact stats cards matching reference design -->
          <div class="stats-grid">
            <div class="stat-card">
              <div class="stat-header">
                <span class="stat-label">Total Expenses</span>
                <svg class="stat-icon" viewBox="0 0 24 24">
                  <path
                    d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                  />
                </svg>
              </div>
              <div class="stat-value">2,450</div>
              <div class="stat-change">
                vs last month
                <span class="stat-trend"
                  ><span
                    class="material-icons"
                    style="font-size: 14px; vertical-align: middle"
                    >trending_up</span
                  >
                  3 expenses</span
                >
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-header">
                <span class="stat-label">Expense Amount</span>
                <svg class="stat-icon" viewBox="0 0 24 24">
                  <path
                    d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                  />
                </svg>
              </div>
              <div class="stat-value">$18,490</div>
              <div class="stat-change">
                vs last month
                <span class="stat-trend"
                  ><span
                    class="material-icons"
                    style="font-size: 14px; vertical-align: middle"
                    >trending_up</span
                  >
                  8%</span
                >
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-header">
                <span class="stat-label">Categories Used</span>
                <svg class="stat-icon" viewBox="0 0 24 24">
                  <path
                    d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                  />
                </svg>
              </div>
              <div class="stat-value">2,355</div>
              <div class="stat-change">
                vs last month
                <span class="stat-trend"
                  ><span
                    class="material-icons"
                    style="font-size: 14px; vertical-align: middle"
                    >trending_up</span
                  >
                  7%</span
                >
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-header">
                <span class="stat-label">Avg. Monthly Spend</span>
                <svg class="stat-icon" viewBox="0 0 24 24">
                  <path
                    d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                  />
                </svg>
              </div>
              <div class="stat-value">890</div>
              <div class="stat-change">
                vs last month
                <span class="stat-trend"
                  ><span
                    class="material-icons"
                    style="font-size: 14px; vertical-align: middle"
                    >trending_up</span
                  >
                  5%</span
                >
              </div>
            </div>
          </div>

          <!-- Data table matching reference design exactly -->
          <div class="data-table">
            <div class="table-header">
              <div class="table-controls">
                <button class="control-btn">
                  <svg class="control-icon" viewBox="0 0 24 24">
                    <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z" />
                  </svg>
                  Table View
                </button>
                <button class="control-btn">
                  <svg class="control-icon" viewBox="0 0 24 24">
                    <path
                      d="M3 17v2h6v-2H3zM3 5v2h10V5H3zm10 16v-2h8v-2h-8v-2h8v-2h-8V9h8V7h-8V5h8V3h-8v2H3v2h10v2H3v2h10v2H3v2h10v4h2z"
                    />
                  </svg>
                  Filter
                </button>
                <button class="control-btn">
                  <svg class="control-icon" viewBox="0 0 24 24">
                    <path d="M3 18h6v-2H3v2zM3 6v2h18V6H3zm0 7h12v-2H3v2z" />
                  </svg>
                  Sort
                </button>
                <span style="font-size: 13px; color: #6b7280"
                  >Show Statistics</span
                >
                <div class="toggle-switch"></div>
              </div>
              <div class="header-actions">
                <button class="btn btn-secondary">
                  <svg class="btn-icon" viewBox="0 0 24 24">
                    <path
                      d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"
                    />
                  </svg>
                  Customize
                </button>
                <button class="btn btn-secondary">
                  <svg class="btn-icon" viewBox="0 0 24 24">
                    <path
                      d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 2 2h8c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-5.5 16L5 14.5l1.41-1.41L8.5 15.18l4.59-4.59L14.5 12 8.5 18z"
                    />
                  </svg>
                  Export
                </button>
                <button class="btn btn-primary">
                  <svg class="btn-icon" viewBox="0 0 24 24">
                    <path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" />
                  </svg>
                  Add New Expense
                </button>
              </div>
            </div>

            <table>
              <thead>
                <tr>
                  <th>Expense</th>
                  <th>Amount</th>
                  <th>Category</th>
                  <th>Date</th>
                  <th>Payment</th>
                  <th>Status</th>
                  <th>Rating</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Grocery Shopping #10 - Whole Foods</td>
                  <td>$135</td>
                  <td>471 items</td>
                  <td>$635.85</td>
                  <td>100</td>
                  <td>
                    <span class="status-badge status-in-stock">Paid</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      5.0
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
                <tr style="border-left: 3px solid #f97316">
                  <td>
                    <span
                      class="material-icons"
                      style="
                        font-size: 16px;
                        vertical-align: middle;
                        margin-right: 4px;
                      "
                      >local_gas_station</span
                    >
                    Gas Station Fill-up #10 - Shell
                  </td>
                  <td>$135</td>
                  <td>402 gallons</td>
                  <td>$544.05</td>
                  <td>0</td>
                  <td>
                    <span class="status-badge status-out-stock">Pending</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      5.0
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
                <tr>
                  <td>Restaurant Dinner #19 - Olive Garden</td>
                  <td>$135</td>
                  <td>455 meals</td>
                  <td>$645.25</td>
                  <td>20</td>
                  <td>
                    <span class="status-badge status-restock">Processing</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      4.9
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
                <tr style="border-left: 3px solid #f97316">
                  <td>
                    <span
                      class="material-icons"
                      style="
                        font-size: 16px;
                        vertical-align: middle;
                        margin-right: 4px;
                      "
                      >home</span
                    >
                    SmartHome Hub
                  </td>
                  <td>$150</td>
                  <td>7 devices</td>
                  <td>$1,050.00</td>
                  <td>12</td>
                  <td>
                    <span class="status-badge status-in-stock">Paid</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      4.8
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
                <tr>
                  <td>UltraSound Wireless Earbuds</td>
                  <td>$200</td>
                  <td>5 pairs</td>
                  <td>$1,000.00</td>
                  <td>0</td>
                  <td>
                    <span class="status-badge status-out-stock">Cancelled</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      4.8
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
                <tr>
                  <td>ProVision 4K Monitor</td>
                  <td>$400.25</td>
                  <td>1 unit</td>
                  <td>$400.25</td>
                  <td>3</td>
                  <td>
                    <span class="status-badge status-restock">Processing</span>
                  </td>
                  <td>
                    <div class="rating">
                      <svg class="star" viewBox="0 0 24 24">
                        <path
                          d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
                        />
                      </svg>
                      5.0
                    </div>
                  </td>
                  <td>
                    <span
                      class="material-icons"
                      style="font-size: 16px; color: #6b7280"
                      >add</span
                    >
                  </td>
                </tr>
              </tbody>
            </table>

            <div class="pagination">
              <div class="pagination-info">Showing per page</div>
              <div class="pagination-controls">
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <span>...</span>
                <button class="page-btn">25</button>
                <button class="page-btn">></button>
              </div>
              <div style="font-size: 13px; color: #6b7280">
                Go to page
                <input
                  type="text"
                  style="
                    width: 40px;
                    padding: 4px;
                    border: 1px solid #d1d5db;
                    border-radius: 4px;
                    margin: 0 8px;
                  "
                />
                Go >
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <script>
      function logout() {
        if (confirm("Are you sure you want to logout?")) {
          // Create a form to submit logout request
          const form = document.createElement("form");
          form.method = "POST";
          form.action = "logout";

          document.body.appendChild(form);
          form.submit();
        }
      }
    </script>
  </body>
</html>
