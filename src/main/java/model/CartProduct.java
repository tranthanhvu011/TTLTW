package model;

import java.util.Map;

public class CartProduct {
    ProductVariant productVariant;
    int quantity;

    public CartProduct(ProductVariant productVariant, int quantity) {
        this.productVariant = productVariant;
        this.quantity = quantity;
    }

    public ProductVariant getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariant productVariant) {
        this.productVariant = productVariant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public void increateQuantity(int quantity){
        this.quantity+=quantity;
    }

    public CartProduct() {
    }

    public void degreeQuantity(int quantity){
        this.quantity-=quantity;
        if (this.quantity<=0) this.quantity+=quantity;
    }

}
