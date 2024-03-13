package model;

import modelDB.ProductVariantDB;
import org.jdbi.v3.core.mapper.Nested;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.util.Date;

public class OrderProductVariant {
    int id;
    ProductVariant productVariant;
    Order order;
    int quantity;
    InforTransport inforTransport;
    Date buy_at;
    double total_price;
    int status;

    public OrderProductVariant(int id, ProductVariant productVariant, Order order, int quantity, InforTransport inforTransport, Date buy_at, double total_price, int status) {
        this.id = id;
        this.productVariant = productVariant;
        this.order = order;
        this.quantity = quantity;
        this.inforTransport = inforTransport;
        this.buy_at = buy_at;
        this.total_price = total_price;
        this.status = status;
    }

    public OrderProductVariant() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProductVariant getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariant productVariant) {
        this.productVariant = productVariant;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public InforTransport getInforTransport() {
        return inforTransport;
    }

    public void setInforTransport(InforTransport inforTransport) {
        this.inforTransport = inforTransport;
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

    @Override
    public String toString() {
        return "OrderProductVariant{" +
                "id=" + id +
                ", productVariant=" + productVariant +
                ", order=" + order +
                ", quantity=" + quantity +
                ", inforTransport=" + inforTransport +
                ", buy_at=" + buy_at +
                ", total_price=" + total_price +
                ", status=" + status +
                '}' + '\n';
    }
}
