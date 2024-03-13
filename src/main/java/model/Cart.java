package model;

import dao.ProductVariantDAO;
import modelDB.ProductVariantDB;
import service.ProductService;
import service.ProductVariantService;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    Map<Integer, CartProduct> data = new HashMap<>();

    public boolean add(int id) {
        return add(id, 1);
    }

    public boolean add(int id, int quantity) {
        ProductVariant p = ProductVariantDAO.getInstance().findProductVariant(id);
        if (p == null) return false;
        CartProduct cartProduct = null;
        if (data.containsKey(id)) {
            cartProduct = data.get(id);
            cartProduct.increateQuantity(quantity);
        } else {
            cartProduct = new CartProduct(p, quantity);

        }
        data.put(id, cartProduct);
        return true;
    }

    public int getTotal() {
        return data.size();
    }

    public Map<Integer, CartProduct> getData() {
        return data;
    }

    public static void main(String[] args) {
        Cart cart = new Cart();
        ProductVariantService service = new ProductVariantService();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        System.out.println(service.findProduct(1));
    }
    public void updateQuantity(int productId, int newQuantity) {
        if (data.containsKey(productId)) {
            CartProduct cartProduct = data.get(productId);
            cartProduct.setQuantity(newQuantity);
        }
    }
}
