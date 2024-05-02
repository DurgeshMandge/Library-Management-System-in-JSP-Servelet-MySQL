import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "nita";
    private static final int DEFAULT_ADMIN_ID = 1; // Replace with the actual admin ID
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=driver");
            return;
        }
        
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO books (title, author, genre, quantity, added_by, added_date) VALUES (?, ?, ?, ?, ?, NOW())";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, author);
                statement.setString(3, genre);
                statement.setInt(4, quantity);
                statement.setInt(5, DEFAULT_ADMIN_ID); // Set default admin ID
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("admin_dashboard.jsp?success=true");
                } else {
                    response.sendRedirect("admin_dashboard.jsp?error=failed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=database");
        }
    }
}
