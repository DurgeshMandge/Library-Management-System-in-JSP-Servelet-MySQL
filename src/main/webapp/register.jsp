<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Library Management System</title>
    <style>
        body {
            margin-top: 100px;
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://assets.mugglenet.com/wp-content/uploads/2017/08/Harry-Ron-and-Hermione-reading-in-Sorcerers-Stone.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            margin: 0 auto;
        }
        h2 {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        input[type="text"],
        input[type="password"],
        select {
            width: calc(100% - 40px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
            font-size: 16px;
            box-sizing: border-box;
            margin-bottom: 10px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #4CAF50;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            margin: 10px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 20px;
            outline: none;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register for Library Management System</h2>
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
                <select name="registerUserType" id="registerUserType" required>
                    <option value="admin">Admin</option>
                    <option value="student">Student</option>
                </select>
            </div>
            <button class="btn" type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
