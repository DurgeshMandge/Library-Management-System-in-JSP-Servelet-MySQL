<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        h2 {
            margin-bottom: 20px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .logout-btn {
            background-color: #ff4444;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .borrowed-books {
            text-align: left;
            margin-top: 20px;
        }
        .borrowed-books table {
            width: 100%;
            border-collapse: collapse;
        }
        .borrowed-books th, .borrowed-books td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .borrowed-books th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Welcome to the Dashboard!</h2>
    <div class="container">
        <!-- Borrowed Books Section -->
        <div class="borrowed-books">
            <h3>Borrowed Books</h3>
            <table>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                </tr>
                <!-- Retrieve and display borrowed books data here -->
                <%-- Sample data (replace with actual data retrieval logic) --%>
                <tr>
                    <td>1</td>
                    <td>The Great Gatsby</td>
                    <td>2024-04-28</td>
                    <td>2024-05-05</td>
                </tr>
            </table>
        </div>
        <!-- Other Dashboard Sections -->
        <!-- Implement other sections here -->
        <form action="logoutServlet" method="post">
            <button class="btn logout-btn" type="submit">Logout</button>
        </form>
        
        <div>
            <h3>Search and Borrow Books</h3>
            <!-- Implement search functionality here -->
            <input type="text" placeholder="Search books">
            <button class="btn">Search</button>
            <!-- Display search results here -->
            <p>Search results will appear here.</p>
        </div>
        <div>
            <h3>Return Books</h3>
            <!-- Implement return books functionality here -->
            <input type="text" placeholder="Enter book ID">
            <button class="btn">Return</button>
        </div>
        <div>
            <h3>Fines and Overdue Books</h3>
            <!-- Display fines and overdue books here -->
            <p>No fines or overdue books.</p>
        </div>
        <div>
            <h3>Account Settings</h3>
            <!-- Implement account settings options here -->
            <button class="btn">Change Password</button>
            <button class="btn">Change Email</button>
        </div>
        <div>
            <h3>Notifications and Alerts</h3>
            <!-- Display notifications or alerts here -->
            <p>No notifications or alerts.</p>
        </div>
        <form action="logoutServlet" method="post">
            <button class="btn logout-btn" type="submit">Logout</button>
        </form>
    </div>
</body>
</html>
