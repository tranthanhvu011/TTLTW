package model;

public class Rate {
    private int id;
    private int number_rate;
    private String comment;
    private Product product_id;
    private Account account_id;

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

    public Product getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Product product_id) {
        this.product_id = product_id;
    }

    public Account getAccount_id() {
        return account_id;
    }

    public void setAccount_id(Account account_id) {
        this.account_id = account_id;
    }
}
