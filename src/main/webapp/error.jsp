<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Error - Personal Expense Tracker</title>
    <link rel="stylesheet" href="css/styles.css" />
  </head>
  <body>
    <div
      class="container"
      style="max-width: 500px; margin: 50px auto; text-align: center"
    >
      <div class="page-header">
        <h1>Oops! Something went wrong</h1>
        <p>We're sorry, but something unexpected happened.</p>
      </div>

      <div class="error-message">
        <span
          class="material-icons"
          style="
            font-size: 48px;
            color: #dc2626;
            margin-bottom: 16px;
            display: block;
          "
          >error</span
        >
        <p>Please try again or contact support if the problem persists.</p>
      </div>

      <div style="margin-top: 24px">
        <a href="index.jsp" class="btn btn-primary">Go Home</a>
        <a
          href="javascript:history.back()"
          class="btn btn-secondary"
          style="margin-left: 12px"
          >Go Back</a
        >
      </div>
    </div>
  </body>
</html>
