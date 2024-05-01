package controller.paypal;

import static java.lang.Float.parseFloat;

public class OrderDetail {
    private String productName;
    private float subtotal;
    private float shipping;
    private float discountShip;
    private float total;

    public OrderDetail(String subtotal, String shipping, String discountShip, String total) {
        this.subtotal = parseFloat(subtotal);
        this.shipping = parseFloat(shipping);
        this.discountShip = parseFloat(discountShip);
        this.total = parseFloat(total);
    }


    public String getProductName() {
        return "Điện thoại";
    }

    public String getSubtotal() {
        return String.format("%.2f", subtotal);
    }

    public String getShipping() {
        return String.format("%.2f", shipping);
    }

    public String getDiscountShip() {
        return String.format("%.2f", discountShip);
    }

    public String getTotal() {
        return String.format("%.2f", total);
    }
}