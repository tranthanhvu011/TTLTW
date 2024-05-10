package controller.logModels;

import java.sql.Timestamp;

public abstract class BaseModel {
    protected int id;
    protected Timestamp createdAt;
    protected Timestamp updatedAt;
}
