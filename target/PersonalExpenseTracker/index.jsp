<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Personal Expense Tracker - Welcome</title>
    <link rel="stylesheet" href="css/styles.css" />
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
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          sans-serif;
        line-height: 1.6;
        color: var(--text-primary);
        background-color: var(--light-gray);
      }

      .auth-layout {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 1rem;
      }

      .auth-container {
        background: var(--white);
        border-radius: 8px;
        padding: 2rem;
        width: 100%;
        max-width: 400px;
        border: 1px solid var(--border-color);
      }

      .auth-header {
        text-align: center;
        margin-bottom: 2rem;
      }

      .auth-header h1 {
        color: var(--primary-black);
        font-size: 1.875rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
      }

      .auth-header p {
        color: var(--text-secondary);
        font-size: 0.875rem;
      }

      .form-container h2 {
        color: var(--primary-black);
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
      }

      .text-center {
        text-align: center;
      }

      .text-secondary {
        color: var(--text-secondary);
      }

      .mb-3 {
        margin-bottom: 1.5rem;
      }

      .mt-3 {
        margin-top: 1.5rem;
      }

      .mt-2 {
        margin-top: 1rem;
      }

      .form-group {
        margin-bottom: 1rem;
      }

      .btn {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
        text-align: center;
        cursor: pointer;
        border: 1px solid transparent;
        transition: all 0.2s ease;
        font-size: 0.875rem;
      }

      .btn-primary {
        background-color: var(--primary-black);
        color: var(--white);
        border-color: var(--primary-black);
      }

      .btn-primary:hover {
        background-color: #1f2937;
        border-color: #1f2937;
      }

      .btn-outline {
        background-color: transparent;
        color: var(--secondary-blue);
        border-color: var(--secondary-blue);
      }

      .btn-outline:hover {
        background-color: var(--secondary-blue);
        color: var(--white);
      }

      a {
        color: inherit;
        text-decoration: none;
      }

      p {
        margin: 0;
      }
    </style>
  </head>
  <body>
    <div class="auth-layout">
      <div class="auth-container">
        <div class="auth-header">
          <h1>Personal Expense Tracker</h1>
          <p>Take control of your finances and investments</p>
        </div>

        <div class="form-container">
          <div class="text-center mb-3">
            <h2>Welcome Back</h2>
            <p class="text-secondary">Choose an option to continue</p>
          </div>

          <div class="form-group">
            <a
              href="login.jsp"
              class="btn btn-primary"
              style="width: 100%; margin-bottom: 1rem"
            >
              Sign In to Your Account
            </a>
          </div>

          <div class="form-group">
            <a href="register.jsp" class="btn btn-outline" style="width: 100%">
              Create New Account
            </a>
          </div>

          <div class="text-center mt-3">
            <p style="font-size: 0.875rem; color: var(--text-secondary)">
              Secure • Private • Easy to Use
            </p>
          </div>
        </div>

        <div class="text-center mt-3">
          <p style="font-size: 0.75rem; color: var(--text-secondary)">
            © 2024 Personal Expense Tracker. All rights reserved.
          </p>
        </div>
      </div>
    </div>
  </body>
</html>
