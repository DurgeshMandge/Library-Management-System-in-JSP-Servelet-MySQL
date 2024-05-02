import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AvailableBooksServlet")
public class AvailableBooksServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "nita";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Book> availableBooks = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=driver");
            return;
        }
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String query = "SELECT * FROM books WHERE quantity > 0";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    Book book = new Book();
                    book.setTitle(resultSet.getString("title"));
                    book.setAuthor(resultSet.getString("author"));
                    book.setGenre(resultSet.getString("genre"));
                    book.setQuantity(resultSet.getInt("quantity"));
                    availableBooks.add(book);
                    System.out.println(availableBooks);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
            response.sendRedirect("admin_dashboard.jsp?error=database");
            return;
        }

        request.setAttribute("availableBooks", availableBooks);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
