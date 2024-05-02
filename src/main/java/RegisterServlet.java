import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "nita";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String classValue = request.getParameter("class");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("registerUserType"); // New user type parameter

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=driver");
            return;
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO users (name, class, email, password, user_type) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, classValue);
                statement.setString(3, email);
                statement.setString(4, password);
                statement.setString(5, userType);
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    // Registration successful
                    response.sendRedirect("login.jsp?success=true");
                } else {
                    // Registration failed
                    response.sendRedirect("register.jsp?error=failed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=database");
        }
    }
}
