import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BorrowedBooksServlet")
public class BorrowedBooksServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "nita";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<BorrowedBook> borrowedBooks = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=driver");
            return;
        }
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String query = "SELECT * FROM borrowed_books";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    BorrowedBook borrowedBook = new BorrowedBook();
                    borrowedBook.setId(resultSet.getInt("id"));
                    borrowedBook.setBorrowerName(resultSet.getString("borrower_name"));
                    borrowedBook.setBookId(resultSet.getInt("book_id"));
                    borrowedBook.setBorrowerId(resultSet.getInt("borrower_id"));
                    borrowedBook.setBorrowDate(resultSet.getDate("borrow_date"));
                    borrowedBook.setReturnDate(resultSet.getDate("return_date"));
                    borrowedBooks.add(borrowedBook);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
            response.sendRedirect("admin_dashboard.jsp?error=database");
            return;
        }

        request.setAttribute("borrowedBooks", borrowedBooks);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
