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

@WebServlet("/BookDashboardServlet")
public class BookDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demojsp", "root", "nita");
            String query = "SELECT title FROM books WHERE quantity > 0";
            preparedStatement = connection.prepareStatement(query);
            resultSet = preparedStatement.executeQuery();

            StringBuilder bookNames = new StringBuilder();
            while (resultSet.next()) {
                String title = resultSet.getString("title");
                bookNames.append(title).append("\n");
            }
            System.out.println("hello");
            request.setAttribute("availableBooks", bookNames.toString().split("\n"));
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle exceptions
            }
        }
    }
}
