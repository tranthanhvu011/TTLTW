package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class Order {
    @ColumnName("order_id")
    int id;
    @ColumnName("account_id")
    int account_id;

    public Order(int id, int account_id) {
        this.id = id;
        this.account_id = account_id;
    }

    public Order() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", account_id=" + account_id +
                '}';
    }
}
