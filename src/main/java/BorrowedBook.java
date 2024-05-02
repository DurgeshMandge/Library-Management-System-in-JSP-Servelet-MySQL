import java.util.Date;

public class BorrowedBook {
    private int id;
    private int bookId;
    private String borrowerName;
    private int borrowerId;
    private Date borrowDate;
    private Date returnDate;

    // Default constructor
    public BorrowedBook() {
        // Default constructor
    }

    // Constructor with all fields
    public BorrowedBook(int id, int bookId, String borrowerName, int borrowerId, Date borrowDate, Date returnDate) {
        this.id = id;
        this.bookId = bookId;
        this.borrowerName = borrowerName;
        this.borrowerId = borrowerId;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
    }

    // Getters and setters for all fields
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBorrowerName() {
        return borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    public int getBorrowerId() {
        return borrowerId;
    }

    public void setBorrowerId(int borrowerId) {
        this.borrowerId = borrowerId;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
}
