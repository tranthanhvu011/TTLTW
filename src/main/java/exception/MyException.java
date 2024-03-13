package exception;

public class MyException extends Exception {
    public MyException(Exception e) {
        super(e.getMessage());
    }
}
