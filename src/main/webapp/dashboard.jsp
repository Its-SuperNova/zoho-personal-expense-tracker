<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - Personal Expense Tracker</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <div class="header-content">
                <div class="header-text">
                    <h1>Dashboard</h1>
                    <p>Welcome to your personal expense tracking and stock management platform</p>
                </div>
                <div class="user-actions">
                    <div class="welcome-text">Welcome back! Here's your financial overview.</div>
                    <a href="index.jsp" class="logout-btn">
                        <span class="material-icons">logout</span>
                        Logout
                    </a>
                </div>
            </div>
        </div>

        <div class="dashboard-content">
            <div class="stats-section">
                <div class="section-header">
                    <h2>Quick Stats</h2>
                    <p>Your financial overview at a glance</p>
                </div>
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-icons">account_balance_wallet</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">$0</div>
                            <div class="stat-label">Total Expenses</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-icons">receipt_long</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Transactions</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-icons">trending_up</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">$0</div>
                            <div class="stat-label">Portfolio Value</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <span class="material-icons">show_chart</span>
                        </div>
                        <div class="stat-content">
                            <div class="stat-number">0%</div>
                            <div class="stat-label">Growth</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="features-section">
                <div class="section-header">
                    <h2>Features</h2>
                    <p>Manage your finances with powerful tools</p>
                </div>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">account_balance_wallet</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">Expense Management</h3>
                            <p class="feature-description">
                                Track your daily expenses, categorize them, and get insights into your spending patterns.
                            </p>
                            <a href="expenses.jsp" class="feature-btn primary">
                                <span class="material-icons">add</span>
                                Add Expense
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">trending_up</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">Stock Portfolio</h3>
                            <p class="feature-description">
                                Manage your stock investments, track performance, and monitor your portfolio value.
                            </p>
                            <a href="#" class="feature-btn">
                                <span class="material-icons">visibility</span>
                                View Portfolio
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">psychology</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">AI Predictions</h3>
                            <p class="feature-description">
                                Get AI-powered insights and predictions for your investment decisions and expense patterns.
                            </p>
                            <a href="#" class="feature-btn disabled">
                                <span class="material-icons">schedule</span>
                                Coming Soon
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">analytics</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">Reports & Analytics</h3>
                            <p class="feature-description">
                                Generate comprehensive reports and analyze your financial data with interactive charts.
                            </p>
                            <a href="#" class="feature-btn disabled">
                                <span class="material-icons">schedule</span>
                                Coming Soon
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">security</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">Security Settings</h3>
                            <p class="feature-description">
                                Enable two-factor authentication and manage your account security settings.
                            </p>
                            <a href="#" class="feature-btn disabled">
                                <span class="material-icons">schedule</span>
                                Coming Soon
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <span class="material-icons">settings</span>
                        </div>
                        <div class="feature-content">
                            <h3 class="feature-title">Account Settings</h3>
                            <p class="feature-description">
                                Update your profile information, change password, and customize your preferences.
                            </p>
                            <a href="#" class="feature-btn disabled">
                                <span class="material-icons">schedule</span>
                                Coming Soon
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="quick-actions">
                <div class="section-header">
                    <h3>Quick Actions</h3>
                    <p>Frequently used actions for faster workflow</p>
                </div>
                <div class="actions-grid">
                    <a href="expenses.jsp" class="action-btn primary">
                        <span class="material-icons">add</span>
                        Add New Expense
                    </a>
                    <a href="#" class="action-btn">
                        <span class="material-icons">trending_up</span>
                        Buy Stock
                    </a>
                    <a href="#" class="action-btn">
                        <span class="material-icons">assessment</span>
                        View Reports
                    </a>
                    <a href="#" class="action-btn">
                        <span class="material-icons">download</span>
                        Export Data
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>