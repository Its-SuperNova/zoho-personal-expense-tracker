<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Account - Personal Expense Tracker</title>
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

      .form-group {
        margin-bottom: 1rem;
      }

      .form-label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: var(--text-primary);
        font-size: 0.875rem;
      }

      .form-input {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 6px;
        font-size: 0.875rem;
        background-color: var(--white);
        color: var(--text-primary);
      }

      .form-input:focus {
        outline: none;
        border-color: var(--secondary-blue);
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
        background: none;
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

      .text-center {
        text-align: center;
      }

      .mt-3 {
        margin-top: 1.5rem;
      }

      .mt-2 {
        margin-top: 1rem;
      }

      a {
        color: inherit;
        text-decoration: none;
      }

      input[type="checkbox"] {
        width: auto;
      }
    </style>
  </head>
  <body>
    <div class="auth-layout">
      <div class="auth-container">
        <div class="auth-header">
          <h1>Personal Expense Tracker</h1>
          <p>Create your account to get started</p>
        </div>

            <div class="form-container">
                <%
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                    if (error != null) {
                %>
                <div style="background: #fee2e2; color: #991b1b; padding: 12px; border-radius: 6px; margin-bottom: 1rem; border: 1px solid #fca5a5;">
                    <%= error %>
                </div>
                <%
                    }
                    if (success != null) {
                %>
                <div style="background: #d1fae5; color: #065f46; padding: 12px; border-radius: 6px; margin-bottom: 1rem; border: 1px solid #a7f3d0;">
                    <%= success %>
                </div>
                <%
                    }
                %>
                <form id="registerForm" action="register" method="post">
            <div class="form-group">
              <label for="fullName" class="form-label">Full Name</label>
              <input
                type="text"
                id="fullName"
                name="fullName"
                class="form-input"
                placeholder="Enter your full name"
                required
              />
            </div>

            <div class="form-group">
              <label for="email" class="form-label">Email Address</label>
              <input
                type="email"
                id="email"
                name="email"
                class="form-input"
                placeholder="Enter your email"
                required
              />
            </div>

            <div class="form-group">
              <label for="password" class="form-label">Password</label>
              <input
                type="password"
                id="password"
                name="password"
                class="form-input"
                placeholder="Create a strong password"
                required
              />
            </div>

            <div class="form-group">
              <label for="confirmPassword" class="form-label"
                >Confirm Password</label
              >
              <input
                type="password"
                id="confirmPassword"
                name="confirmPassword"
                class="form-input"
                placeholder="Confirm your password"
                required
              />
            </div>

            <div class="form-group">
              <label
                style="
                  display: flex;
                  align-items: flex-start;
                  font-size: 0.875rem;
                "
              >
                <input
                  type="checkbox"
                  id="terms"
                  name="terms"
                  style="margin-right: 0.5rem; margin-top: 0.25rem"
                  required
                />
                <span>I agree to the Terms of Service and Privacy Policy</span>
              </label>
            </div>

            <div class="form-group">
              <button type="submit" class="btn btn-primary" style="width: 100%">
                Create Account
              </button>
            </div>
          </form>

          <div
            class="text-center mt-3"
            style="
              padding-top: 1.5rem;
              border-top: 1px solid var(--border-color);
            "
          >
            <p
              style="
                font-size: 0.875rem;
                color: var(--text-secondary);
                margin-bottom: 0.5rem;
              "
            >
              Already have an account?
            </p>
            <a href="login.jsp" class="btn btn-outline" style="width: 100%">
              Sign In Instead
            </a>
          </div>
        </div>

        <div class="text-center mt-2">
          <a
            href="index.jsp"
            style="
              color: var(--text-secondary);
              text-decoration: none;
              font-size: 0.875rem;
            "
          >
            ← Back to Home
          </a>
        </div>
      </div>
    </div>

    <script>
      document
        .getElementById("registerForm")
        .addEventListener("submit", function (e) {
          const password = document.getElementById("password").value;
          const confirmPassword =
            document.getElementById("confirmPassword").value;
          const terms = document.getElementById("terms").checked;

          if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            return;
          }

          if (!terms) {
            e.preventDefault();
            alert("Please accept the Terms of Service and Privacy Policy");
            return;
          }

          // Form will submit to RegisterServlet if validation passes
        });
    </script>
  </body>
</html>
