<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-image: url('https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/09/reading-book-1296x728-header.jpg?w=1155&h=1528');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        table {
            width: 80%;
            margin: 50px auto;
            padding:10px;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .logout-btn {
            padding: 8px 16px;
            margin: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            background-color: #logout-btn;
            color: red;
            border: 1px solid #d32f2f;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .logout-btn:hover {
            background-color: #d32f2f;
            color: #fff;
        }
        .content {
            background-color: rgba(255, 255, 255, 0.4);
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            margin-top: 50px;
        }
        .flexdiv {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .add-book-form {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            max-width: 500px;
            margin: 0 auto;
        }
        input[type="text"], input[type="number"] {
            width: calc(100% - 16px);
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }
        button[type="submit"] {
            width: calc(100% - 16px);
            padding: 8px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        button[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div id="bookingsTab" class="content">
        <div class="flexdiv">
        	<h4>Admin</h4>
            <h2>All Books</h2>
            <form action="LogoutServlet" method="post">
                <button class="logout-btn" type="submit">Logout</button>
            </form>
        </div>
        <table>
            <tr>
                <th>Title</th>
                <th>Quantity</th>
            </tr>
            <%
                String url = "jdbc:mysql://localhost:3306/demojsp";
                String dbUsername = "root";
                String dbPassword = "nita";
                String query = "SELECT title, quantity FROM books LIMIT 10";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                    // Handle driver not found error
                }
                try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
                     PreparedStatement ps = con.prepareStatement(query);
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String title = rs.getString("title");
                        int quantity = rs.getInt("quantity");
            %>
            <tr>
                <td><%= title %></td>
                <td><%= quantity %></td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle SQL exception
                }
            %>
        </table>
        
        
        <div class="add-book-form">
            <h3>Add New Book</h3>
            <form action="AddBookServlet" method="post">
                <input type="text" name="title" placeholder="Title" required><br>
                <input type="number" name="quantity" placeholder="Quantity" required><br>
                <input type="text" name="author" placeholder="Author" required><br>
                <input type="text" name="genre" placeholder="Genre" required><br>
                <button type="submit">Add Book</button>
            </form>
        </div>
<h2>Student Books</h2>
    <table>
        <tr>
            <th>Student Name</th>
            <th>Books Borrowed</th>
        </tr>
        <% 
            String url5 = "jdbc:mysql://localhost:3306/demojsp";
            String dbUsername5 = "root";
            String dbPassword5 = "nita";
            String query5 = "SELECT u.name AS student_name, b.book_name FROM users u INNER JOIN borrowed_book b ON u.name = b.borrower_name";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection(url5, dbUsername5, dbPassword5);
                     PreparedStatement ps = con.prepareStatement(query5);
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String studentName = rs.getString("student_name");
                        String bookName = rs.getString("book_name");
        %>
        <tr>
            <td><%= studentName %></td>
            <td><%= bookName %></td>
        </tr>
        <% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle SQL exception
            }} catch (Exception e) {
                e.printStackTrace();
                // Handle SQL exception
            }
        %>
    </table>
    </div>
</body>
</html>
