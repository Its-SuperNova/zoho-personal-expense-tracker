<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Test Registration - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
  </head>
  <body>
    <div class="container" style="max-width: 600px; margin: 50px auto">
      <div class="page-header">
        <h1>Registration Test</h1>
        <p>Test the registration functionality</p>
      </div>

      <div class="card">
        <h3>Test Registration Form</h3>
        <form method="post" action="register" id="testForm">
          <div class="form-group">
            <label for="username">Username</label>
            <input
              type="text"
              id="username"
              name="username"
              placeholder="Enter username"
              required
            />
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Enter email"
              required
            />
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Enter password"
              required
            />
          </div>

          <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input
              type="password"
              id="confirmPassword"
              name="confirmPassword"
              placeholder="Confirm password"
              required
            />
          </div>

          <button type="submit" class="btn btn-primary">
            Test Registration
          </button>
        </form>
      </div>

      <div style="margin-top: 20px">
        <a href="register.jsp" class="btn btn-secondary"
          >Go to Real Registration</a
        >
        <a href="index.jsp" class="btn btn-secondary">Go Home</a>
      </div>
    </div>

    <script>
      document
        .getElementById("testForm")
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
