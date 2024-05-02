<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background-image: url('https://img.freepik.com/free-photo/pieces-blue-stationery_23-2148169528.jpg');
            background-size: cover;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .tab-button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .log-button {
            padding: 10px 20px;
            background-color: #F00;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .tab-button:hover {
            background-color: #45a049;
        }
        .tab-content {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 1000px;
        }
        .tab-content h3 {
            margin-bottom: 10px;
        }
        .tab-content input[type="text"], 
        .tab-content input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .tab-content button {
            width: calc(100% - 20px);
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .tab-content button:hover {
            background-color: #45a049;
        }
        .cPass {
            margin-top: 20px; 
        }
        .hidden {
            display: none;
        }
        .available-books-table {
		    width: 100%;
		    border-collapse: collapse;
		}
		
		.available-books-table th,
		.available-books-table td {
			margin:20px;
		    padding: 10px;
		    text-align: left;
		    border-bottom: 1px solid #ddd;
		}
		
		.available-books-table th {
		    background-color: #f2f2f2;
		}
		.borrowed-books-table{
		    width: 100%;
		    border-collapse: collapse;
		}
		.borrowed-books-table th,
		.borrowed-books-table td {
			margin:20px;
		    padding: 10px;
		    text-align: left;
		    border-bottom: 1px solid #ddd;
		}
		
		.borrowed-books-table th {
		    background-color: #f2f2f2;
		}
		.fine-table {
            width: 100%;
            border-collapse: collapse;
        }

        .fine-table th,
        .fine-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .fine-table th {
            background-color: #f2f2f2;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <!-- Tabs -->
        <div class="tabs">
		    <button class="tab-button" onclick="showTab('available-tab')">Available Books</button>
			<button class="tab-button" onclick="showTab('borrow-tab')">Borrow Book</button>
		    <button class="tab-button" onclick="showTab('borrowed-tab')">Borrowed Books</button>
            <button class="tab-button" onclick="showTab('fine-tab')">Fines</button>
		    <form action="LogoutServlet" method="post">
                <button class="log-button">Logout</button>
            </form>
		</div>

        <!-- Borrow Books Tab -->
        <div id="borrow-tab" class="tab-content">
            <h3>Borrow Books</h3>
            <form action="" method="post">
                <input type="text" id="bookId" name="bookId" placeholder="Book ID" required><br>
                <button type="submit" name="borrow">Borrow</button>
            </form>
            <% 
                if(request.getParameter("borrow") != null) {
                    String url = "jdbc:mysql://localhost:3306/demojsp";
                    String dbUsername = "root";
                    String dbPassword = "nita";
                    String bookId = request.getParameter("bookId");
                    String selectBookQuery = "SELECT * FROM demojsp.books WHERE id = ? AND quantity > 0";
                    String decreaseQuantityQuery = "UPDATE books SET quantity = quantity - 1 WHERE id = ?";
                    String insertIntoBorrowedBooksQuery = "INSERT INTO demojsp.borrowed_book (book_name, issue_date, borrower_name) VALUES (?, CURRENT_DATE(), ?)";
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
                             PreparedStatement selectBookPs = con.prepareStatement(selectBookQuery);
                             PreparedStatement decreaseQuantityPs = con.prepareStatement(decreaseQuantityQuery);
                             PreparedStatement insertIntoBorrowedBooksPs = con.prepareStatement(insertIntoBorrowedBooksQuery)) {
                            selectBookPs.setString(1, bookId);
                            ResultSet rs = selectBookPs.executeQuery();
                            if (rs.next()) {
                                String bookName = rs.getString("title");
                                decreaseQuantityPs.setString(1, bookId);
                                decreaseQuantityPs.executeUpdate();
                                insertIntoBorrowedBooksPs.setString(1, bookName);
                                insertIntoBorrowedBooksPs.setString(2, (String) session.getAttribute("userName"));
                        		System.out.println(insertIntoBorrowedBooksPs);
                                insertIntoBorrowedBooksPs.executeUpdate();
                                response.sendRedirect("student_dashboard.jsp?success=borrowed");
                            } else {
                                response.sendRedirect("dashboard.jsp?error=book_not_found");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                        response.sendRedirect("admin_dashboard.jsp?error=database_error");
                    }
                }
            %>

        </div>
        <!-- Available Books Tab -->
		<div id="available-tab" class="tab-content hidden">
		    <h3>Available Books</h3>
		    <table class="available-books-table">
		        <tr>
		            <th>Title</th>
		            <th>Author</th>
		            <th>Genre</th>
		            <th>Quantity</th>
		        </tr>
				        <% 
				            try {
				                String url = "jdbc:mysql://localhost:3306/demojsp";
				                String dbUsername = "root";
				                String dbPassword = "nita";
				                String query = "SELECT title, author, genre, quantity FROM books";
				                Class.forName("com.mysql.cj.jdbc.Driver");
				                try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
				                     PreparedStatement ps = con.prepareStatement(query);
				                     ResultSet rs = ps.executeQuery()) {
				                    while (rs.next()) {
				                        String title = rs.getString("title");
				                        String author = rs.getString("author");
				                        String genre = rs.getString("genre");
				                        int quantity = rs.getInt("quantity");
				        %>
					        <tr>
					            <td><%= title %></td>
					            <td><%= author %></td>
					            <td><%= genre %></td>
					            <td><%= quantity %></td>
					        </tr>
				        <% 
		                    }
		                }
		            } catch (ClassNotFoundException | SQLException e) {
		                e.printStackTrace();
		                // Handle exception
		            }
		        %>
		    </table>
		</div>
	<!-- Borrowed Books Tab -->
	<div id="borrowed-tab" class="tab-content hidden">
	    <h3>Borrowed Books</h3>
	    <table class="borrowed-books-table">
	        <tr>
	            <th>Title</th>
	            <th>Issue Date</th>
	        </tr>
	        <% 
	            try {
	                String url = "jdbc:mysql://localhost:3306/demojsp";
	                String dbUsername = "root";
	                String dbPassword = "nita";
	                String borrowerName = (String) session.getAttribute("userName");
	                String query = "SELECT book_name, issue_date FROM borrowed_book WHERE borrower_name = ?";
	                Class.forName("com.mysql.cj.jdbc.Driver");
	                try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
	                     PreparedStatement ps = con.prepareStatement(query)) {
	                    ps.setString(1, borrowerName);
	                    ResultSet rs = ps.executeQuery();
	                    while (rs.next()) {
	                        String bookName = rs.getString("book_name");
	                        String issueDate = rs.getString("issue_date");
	        %>
	        <tr>
	            <td><%= bookName %></td>
	            <td><%= issueDate %></td>
	        </tr>
	        <% 
	           }
		            } catch (SQLException e) {
		                e.printStackTrace();
		                // Handle exception
		            }
	            }catch (Exception e) {
	                e.printStackTrace();
	                // Handle exception
	            }
	        
	        %>
	    </table>
	</div>

	<!-- Fines Tab -->
        <div id="fine-tab" class="tab-content hidden">
            <h3>Fines</h3>
            <table class="fine-table">
                <tr>
                    <th>Title</th>
                    <th>Borrow Date</th>
                    <th>Fine</th>
                </tr>
                <%
				    try {
				        String url = "jdbc:mysql://localhost:3306/demojsp";
				        String dbUsername = "root";
				        String dbPassword = "nita";
				        String borrowerName = (String) session.getAttribute("userName");
				        String query = "SELECT book_name, issue_date FROM demojsp.borrowed_book WHERE borrower_name = ?";
				        Class.forName("com.mysql.cj.jdbc.Driver");
				        try (Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
				             PreparedStatement ps = con.prepareStatement(query)) {
				            ps.setString(1, borrowerName);
				            ResultSet rs = ps.executeQuery();
				            while (rs.next()) {
				                String bookName = rs.getString("book_name");
				                String issueDateStr = rs.getString("issue_date");
				                // Convert issue date string to LocalDate
				                LocalDate issueDate = LocalDate.parse(issueDateStr);
				                // Calculate the number of days the book has been borrowed
				                long daysBorrowed = LocalDate.now().toEpochDay() - issueDate.toEpochDay();
				                // Calculate the fine (assuming 1$ per day)
				                double fine = daysBorrowed > 14 ? daysBorrowed * 2.0 : 00; // Adjust the rate as needed
				                // Display book details and fine
				%>
				                <tr>
				                    <td><%= bookName %></td>
				                    <td><%= issueDateStr %></td>
				                    <td>$<%= String.format("%.2f", fine) %></td>
				                </tr>
				<%
				            }
				        }
				    } catch (Exception e) {
				        e.printStackTrace();
				        // Handle exception
				    }
%>
            </table>
        </div>

    </div>
    <script>
        function showTab(tabName) {
            var tabs = document.getElementsByClassName('tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.add('hidden');
            }
            document.getElementById(tabName).classList.remove('hidden');
        }
    </script>
</body>
</html>

