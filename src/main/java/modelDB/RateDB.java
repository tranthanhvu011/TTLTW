package modelDB;

import model.Account;
import model.Product;

public class RateDB {
    private int id;
    private int number_rate;
    private String comment;
    private int product_id;
    private int account_id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumber_rate() {
        return number_rate;
    }

    public void setNumber_rate(int number_rate) {
        this.number_rate = number_rate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }
}
