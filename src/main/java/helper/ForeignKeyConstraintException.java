package helper;

import java.sql.SQLException;

public class ForeignKeyConstraintException extends SQLException {
    public ForeignKeyConstraintException(String message, Throwable cause) {
        super(message, cause);
    }
}
