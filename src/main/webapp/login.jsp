<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Library Management System</title>
    <style>
        body {
        	margin-top:150px;
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://img.freepik.com/free-photo/back-school-witch-school-supplies_23-2148151036.jpg?size=626&ext=jpg&ga=GA1.1.1224184972.1714521600&semt=ais'); /* Replace 'your-background-image.jpg' with the path to your image */
            background-size: cover; /* Cover the entire background */
            background-position: center; /* Center the background image */
            background-repeat: no-repeat; /* Prevent background image from repeating */
            background-color: #f4f4f4; /* Fallback color */
        }
        .container {
            margin-top: 100px;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group select {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            margin: 10px;
            cursor: pointer;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login to Library Management System</h2>
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
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
