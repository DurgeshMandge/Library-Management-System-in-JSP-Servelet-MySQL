import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "nita";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType"); // New user type parameter

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=driver");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND user_type = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, password);
                statement.setString(3, userType);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Login successful
                        String userName = resultSet.getString("name");
                        HttpSession session = request.getSession();
                        session.setAttribute("userName", userName);
                        
                        // Redirect to appropriate dashboard based on user type
                        if (userType.equals("admin")) {
                            response.sendRedirect("admin_dashboard.jsp");
                        } else if (userType.equals("student")) {
                            response.sendRedirect("student_dashboard.jsp");
                        } else {
                            // Handle other user types or errors
                        }
                    } else {
                        // Invalid credentials
                        response.sendRedirect("login.jsp?error=invalid");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=database");
        }
    }
}
