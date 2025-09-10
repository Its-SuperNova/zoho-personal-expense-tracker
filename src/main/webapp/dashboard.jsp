<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/dashboard.css" />
  </head>
  <body>
    <div class="dashboard-container">
      <div class="dashboard-header">
        <h1>Dashboard</h1>
        <p>
          Welcome to your personal expense tracking and stock management
          platform
        </p>

        <div class="user-info">
          <div class="welcome-text">
            Welcome back! Here's your financial overview.
          </div>
          <a href="index.jsp" class="logout-btn">Logout</a>
        </div>
      </div>

      <div class="dashboard-content">
        <div class="stats-section">
          <h2>Quick Stats</h2>
          <div class="stats-grid">
            <div class="stat-card">
              <div class="stat-number">$0</div>
              <div class="stat-label">Total Expenses</div>
            </div>
            <div class="stat-card">
              <div class="stat-number">0</div>
              <div class="stat-label">Transactions</div>
            </div>
            <div class="stat-card">
              <div class="stat-number">$0</div>
              <div class="stat-label">Portfolio Value</div>
            </div>
            <div class="stat-card">
              <div class="stat-number">0%</div>
              <div class="stat-label">Growth</div>
            </div>
          </div>
        </div>

        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large"
                >account_balance_wallet</span
              >
            </div>
            <h3 class="feature-title">Expense Management</h3>
            <p class="feature-description">
              Track your daily expenses, categorize them, and get insights into
              your spending patterns.
            </p>
            <a href="expenses.jsp" class="action-btn">Add Expense</a>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large">trending_up</span>
            </div>
            <h3 class="feature-title">Stock Portfolio</h3>
            <p class="feature-description">
              Manage your stock investments, track performance, and monitor your
              portfolio value.
            </p>
            <a href="#" class="action-btn">View Portfolio</a>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large">psychology</span>
            </div>
            <h3 class="feature-title">AI Predictions</h3>
            <p class="feature-description">
              Get AI-powered insights and predictions for your investment
              decisions and expense patterns.
            </p>
            <a href="#" class="action-btn">Coming Soon</a>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large">analytics</span>
            </div>
            <h3 class="feature-title">Reports & Analytics</h3>
            <p class="feature-description">
              Generate comprehensive reports and analyze your financial data
              with interactive charts.
            </p>
            <a href="#" class="action-btn">Coming Soon</a>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large">security</span>
            </div>
            <h3 class="feature-title">Security Settings</h3>
            <p class="feature-description">
              Enable two-factor authentication and manage your account security
              settings.
            </p>
            <a href="#" class="action-btn">Coming Soon</a>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <span class="material-icons icon-large">settings</span>
            </div>
            <h3 class="feature-title">Account Settings</h3>
            <p class="feature-description">
              Update your profile information, change password, and customize
              your preferences.
            </p>
            <a href="#" class="action-btn">Coming Soon</a>
          </div>
        </div>

        <div class="quick-actions">
          <h3>Quick Actions</h3>
          <div class="actions-grid">
            <a href="#" class="action-btn">
              <span class="material-icons icon">add</span>
              Add New Expense
            </a>
            <a href="#" class="action-btn">
              <span class="material-icons icon">trending_up</span>
              Buy Stock
            </a>
            <a href="#" class="action-btn">
              <span class="material-icons icon">assessment</span>
              View Reports
            </a>
            <a href="#" class="action-btn">
              <span class="material-icons icon">download</span>
              Export Data
            </a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
