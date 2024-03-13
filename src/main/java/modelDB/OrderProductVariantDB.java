package modelDB;

import java.util.Date;

public class OrderProductVariantDB {
    private int id;
    private int product_variant_id;
    private int order_id;
    private int quantity;
    private int transport_id;
    private Date buy_at;
    private double total_price;
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_variant_id() {
        return product_variant_id;
    }

    public void setProduct_variant_id(int product_variant_id) {
        this.product_variant_id = product_variant_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getTransport_id() {
        return transport_id;
    }

    public void setTransport_id(int transport_id) {
        this.transport_id = transport_id;
    }

    public Date getBuy_at() {
        return buy_at;
    }

    public void setBuy_at(Date buy_at) {
        this.buy_at = buy_at;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
