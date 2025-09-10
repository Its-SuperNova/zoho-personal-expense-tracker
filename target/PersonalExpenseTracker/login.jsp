<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/login.css" />
  </head>
  <body>
    <a href="index.jsp" class="back-home">← Back to Home</a>

    <div class="login-container">
      <div class="login-header">
        <h1>Welcome Back</h1>
        <p>Sign in to your account</p>
      </div>

      <% if (request.getParameter("error") != null) { %>
      <div class="error-message"><%= request.getParameter("error") %></div>
      <% } %> <% if (request.getParameter("success") != null) { %>
      <div class="success-message"><%= request.getParameter("success") %></div>
      <% } %>

      <form method="post" action="login">
        <div class="form-group">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Enter your username"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            required
          />
        </div>

        <button type="submit" class="login-btn">Sign In</button>
      </form>

      <div class="register-link">
        <p>Don't have an account? <a href="register.jsp">Create one here</a></p>
      </div>
    </div>
  </body>
</html>
