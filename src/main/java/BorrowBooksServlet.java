import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BorrowBooksServlet")
public class BorrowBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String borrowerName = "John Doe"; // Assuming borrower name is fixed for now
        int borrowerId = 123; // Assuming borrower ID is fixed for now
        Date borrowDate = new Date(); // Current date as borrow date

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/demojsp";
        String username = "root";
        String password = "nita";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection(url, username, password);

            // SQL query to insert borrowed book details
            String sql = "INSERT INTO borrowed_books (id, borrower_name, book_id, borrower_id, borrow_date) VALUES (1,?, ?, ?, ?)";

            // Create a PreparedStatement with the SQL query
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, borrowerName);
            pstmt.setString(2, bookId);
            pstmt.setInt(3, borrowerId);
            pstmt.setDate(4, new java.sql.Date(borrowDate.getTime()));

            // Execute the query to insert borrowed book details
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Borrowing successful
                response.sendRedirect("student_dashboard.jsp?success=borrowed");
            } else {
                // Borrowing failed
                response.sendRedirect("student_dashboard.jsp?error=borrow_failed");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions
        	System.out.println(e);
            e.printStackTrace();
            response.sendRedirect("student_dashboard.jsp?error=database_error");
        } finally {
            // Close the database resources
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
