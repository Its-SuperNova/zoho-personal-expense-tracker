<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/register.css" />
  </head>
  <body>
    <a href="index.jsp" class="back-home">← Back to Home</a>

    <div class="register-container">
      <div class="register-header">
        <h1>Create Account</h1>
        <p>Join us and start tracking your expenses</p>
      </div>

      <% if (request.getParameter("error") != null) { %>
      <div class="error-message"><%= request.getParameter("error") %></div>
      <% } %> <% if (request.getParameter("success") != null) { %>
      <div class="success-message"><%= request.getParameter("success") %></div>
      <% } %>

      <form method="post" action="register" id="registerForm">
        <div class="form-group">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Choose a username"
            required
            minlength="3"
            maxlength="20"
          />
        </div>

        <div class="form-group">
          <label for="email">Email Address</label>
          <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your email"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Create a strong password"
            required
            minlength="6"
          />
          <div class="password-strength" id="passwordStrength"></div>
        </div>

        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <input
            type="password"
            id="confirmPassword"
            name="confirmPassword"
            placeholder="Confirm your password"
            required
          />
        </div>

        <div class="terms-checkbox">
          <input type="checkbox" id="terms" required />
          <label for="terms"
            >I agree to the
            <a href="#" onclick="alert('Terms and conditions would go here')"
              >Terms and Conditions</a
            ></label
          >
        </div>

        <button type="submit" class="register-btn">Create Account</button>
      </form>

      <div class="login-link">
        <p>Already have an account? <a href="login.jsp">Sign in here</a></p>
      </div>
    </div>

    <script>
      // Password strength checker
      document
        .getElementById("password")
        .addEventListener("input", function () {
          const password = this.value;
          const strengthDiv = document.getElementById("passwordStrength");

          if (password.length === 0) {
            strengthDiv.textContent = "";
            return;
          }

          let strength = 0;
          if (password.length >= 6) strength++;
          if (password.match(/[a-z]/)) strength++;
          if (password.match(/[A-Z]/)) strength++;
          if (password.match(/[0-9]/)) strength++;
          if (password.match(/[^a-zA-Z0-9]/)) strength++;

          if (strength < 2) {
            strengthDiv.textContent = "Weak password";
            strengthDiv.className = "password-strength weak";
          } else if (strength < 4) {
            strengthDiv.textContent = "Medium strength";
            strengthDiv.className = "password-strength medium";
          } else {
            strengthDiv.textContent = "Strong password";
            strengthDiv.className = "password-strength strong";
          }
        });

      // Password confirmation
      document
        .getElementById("confirmPassword")
        .addEventListener("input", function () {
          const password = document.getElementById("password").value;
          const confirmPassword = this.value;

          if (confirmPassword && password !== confirmPassword) {
            this.setCustomValidity("Passwords do not match");
          } else {
            this.setCustomValidity("");
          }
        });

      // Form validation
      document
        .getElementById("registerForm")
        .addEventListener("submit", function (e) {
          const password = document.getElementById("password").value;
          const confirmPassword =
            document.getElementById("confirmPassword").value;

          if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            return false;
          }
        });
    </script>
  </body>
</html>
