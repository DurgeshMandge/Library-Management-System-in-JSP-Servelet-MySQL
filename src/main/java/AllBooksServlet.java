//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//@WebServlet("/AllBooksServlet")
//public class AllBooksServlet extends HttpServlet {
//    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/demojsp";
//    private static final String JDBC_USER = "root";
//    private static final String JDBC_PASSWORD = "nita";
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("application/json");
//        PrintWriter out = response.getWriter();
//        
//        List<Book> allBooks = new ArrayList<>();
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//            // Return empty response or error response
//            return;
//        }
//        
//        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
//            String query = "SELECT * FROM books";
//            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
//                ResultSet resultSet = preparedStatement.executeQuery();
//                while (resultSet.next()) {
//                    Book book = new Book();
//                    book.setTitle(resultSet.getString("title"));
//                    book.setAuthor(resultSet.getString("author"));
//                    book.setGenre(resultSet.getString("genre"));
//                    book.setQuantity(resultSet.getInt("quantity"));
//                    allBooks.add(book);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            // Return empty response or error response
//            return;
//        }
//
//        // Convert book list to JSON and send it as response
//        Gson gson = new Gson();
//        String jsonBooks = gson.toJson(allBooks);
//        out.println(jsonBooks);
//        out.flush();
//    }
//}
