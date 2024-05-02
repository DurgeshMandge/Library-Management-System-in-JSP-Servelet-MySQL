import java.util.Date;

public class FineCalculator {

    public static double calculateFine(Date issueDate) {
        double fine = 0;
        // Assuming fine is $1 per day overdue
        long overdueDays = Math.max(0, (System.currentTimeMillis() - issueDate.getTime()) / (1000 * 60 * 60 * 24));
        fine = overdueDays * 1; // $1 per day overdue
        return fine;
    }
}
