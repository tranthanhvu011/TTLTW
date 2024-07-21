package dao;

import config.JDBIConnector;
import model.ProductInventory;

import java.util.List;

public class ProductInventoryDAO {

    public boolean addProductInventory(int idKho, int idProductVariant, int quantityProductVariant, double priceOneProductVariant, double priceAllProductVariant) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO productKho (idKho, idProductVariant, quantityProductVariant, priceOneProductVariant, priceAllProductVariant) VALUES (:idKho, :idProductVariant, :quantityProductVariant, :priceOneProductVariant, :priceAllProductVariant)")
                        .bind("idKho", idKho)
                        .bind("idProductVariant", idProductVariant)
                        .bind("quantityProductVariant", quantityProductVariant)
                        .bind("priceOneProductVariant", priceOneProductVariant)
                        .bind("priceAllProductVariant", priceAllProductVariant)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public boolean deleteProductInventory(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM productKho WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }

    public List<ProductInventory> getAllProductInventories() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM productKho")
                        .mapToBean(ProductInventory.class)
                        .list()
        );
    }

    public ProductInventory getProductInventoryById(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM productKho WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(ProductInventory.class)
                        .findFirst() // Sử dụng findFirst() để tránh lỗi khi không có kết quả
                        .orElse(null) // Trả về null nếu không có kết quả
        );
    }

    public boolean updateProductInventory(ProductInventory productInventory) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE productKho SET idKho = :idKho, idProductVariant = :idProductVariant, quantityProductVariant = :quantityProductVariant, priceOneProductVariant = :priceOneProductVariant, priceAllProductVariant = :priceAllProductVariant WHERE id = :id")
                        .bind("id", productInventory.getId())
                        .bind("idKho", productInventory.getIdKho())
                        .bind("idProductVariant", productInventory.getIdProductVariant())
                        .bind("quantityProductVariant", productInventory.getQuantityProductVariant())
                        .bind("priceOneProductVariant", productInventory.getPriceOneProductVariant())
                        .bind("priceAllProductVariant", productInventory.getPriceAllProductVariant())
                        .execute()
        );
        return rowsAffected > 0;
    }
    public List<ProductInventory> getProductInventoriesByVariantAndQuantity(int idProductVariant) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM productKho WHERE idProductVariant = :idProductVariant AND quantityProductVariant > 1")
                        .bind("idProductVariant", idProductVariant)
                        .mapToBean(ProductInventory.class)
                        .list()
        );
    }
//test
    public static void main(String[] args) {
        ProductInventoryDAO dao = new ProductInventoryDAO();
////        dao.addProductInventory(1,3,2,555555,5000000);
////        List<ProductInventory> inventories = dao.getAllProductInventories();
////        inventories.forEach(System.out::println);
//        ProductInventory product = dao.getProductInventoryById(1);
//        System.out.println("Product by ID: " + product);
//        if (product != null) {
//            product.setQuantityProductVariant(120);
//            boolean updated = dao.updateProductInventory(product);
//            System.out.println("Product updated: " + updated);
//        }
       System.out.println(dao.getProductInventoriesByVariantAndQuantity(3));
////        System.out.println("Product deleted: " + deleted);
    }
}
