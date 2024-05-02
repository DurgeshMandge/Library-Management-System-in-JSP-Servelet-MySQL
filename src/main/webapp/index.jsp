<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://t3.ftcdn.net/jpg/06/25/25/60/360_F_625256025_ohJcE1pPJwzbRY0oUl1LvJSfWiKb1CMR.jpg'); /* Path to your background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding-top: 50px;
            margin: 0;
        }
        h2 {
            margin-bottom: 20px;
            color: yellow; /* Text color */
        }
        .container {
            display: flex;
            justify-content: center;
        }
        .form-container {
            width: 350px; /* Set width of the form container */
            background-color: rgba(255, 255, 255, 0.7); /* Semi-transparent background */
            padding: 40px;
            padding-x: 20px;
            border-radius: 10px; /* Rounded corners */
            margin: 0 40px; /* Add space between forms */
            text-align: left; /* Align form elements to the left */
        }
        .form-group {
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="password"],
        select {
            width: 100%; /* Set width of the input fields */
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%; /* Set width of the button */
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-image: linear-gradient(to bottom, #4CAF50, #45a049); /* Button background */
            color: white;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s; /* Transition effect for hover */
        }
        .btn:hover {
            background-color: #388e3c; /* Change background color on hover to dark green */
            transform: scale(1.05); /* Scale up button on hover */
        }
        .btn:active {
            transform: scale(0.95); /* Scale down button on click */
        }
    </style>
</head>
<body>
    <h2 class="heading">Welcome to Library Management System</h2>
    <div class="container">
        <div class="form-container">
            <h3>Login</h3>
            <form action="loginServlet" method="post">
                <div class="form-group">
                    <input type="text" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <label for="userType">User Type:</label>
                    <select name="userType" id="userType" required>
                        <option value="admin">Admin</option>
                        <option value="student">Student</option>
                    </select>
                </div>
                <button class="btn" type="submit">Login</button>
            </form>
        </div>
        <div class="form-container">
            <h3>Register</h3>
            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <input type="text" name="name" placeholder="Name" required>
                </div>
                <div class="form-group">
                    <input type="text" name="class" placeholder="Class" required>
                </div>
                <div class="form-group">
                    <input type="text" name="email" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <div class="form-group">
                    <label for="registerUserType">User Type:</label>
                    <select name="registerUserType" id="registerUserType" required>
                        <option value="admin">Admin</option>
                        <option value="student">Student</option>
                    </select>
                </div>
                <button class="btn" type="submit">Register</button>
            </form>
        </div>
    </div>
</body>
</html>
