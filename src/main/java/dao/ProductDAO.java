package dao;

import config.DBConnection;
import config.JDBIConnector;
import model.Product;
import modelDB.ProductDB;

import java.util.List;
import java.util.Optional;

public class ProductDAO {

    public List<ProductDB> findAllProduct() {

        List<ProductDB> products = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM Products order by id desc ";
            return handle.createQuery(query).mapToBean(ProductDB.class).list();
        });
        return products.isEmpty() ? null : products;
    }
    public static String getNameProductByIDProductVariant(int idProductVariant) {
        String query = "select name from products where id = ?";
        String nameProduct = JDBIConnector.me().withHandle(
                handle ->
                        String.valueOf(handle.createQuery(query)
                                .bind(0, idProductVariant)
                                .mapTo(String.class)
                                .findOne())
        );
        return nameProduct;
    }

    public ProductDB findProductById(int productId) {

        Optional<ProductDB> product = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM Products WHERE id = ?";
            return handle.createQuery(query)
                    .bind(0, productId)
                    .mapToBean(ProductDB.class)
                    .findOne();
        });
        return product.orElse(null);
    }

    public ProductDB findProductForManageProductPageById(int productId) {

        Optional<ProductDB> product = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT p.id,p.name,p.manufacturer_id,p.sell_quantity,p.remaning_quantity FROM Products p WHERE p.id = ?";
            return handle.createQuery(query).bind(0, productId).mapToBean(ProductDB.class).findOne();
        });
        return product.orElse(null);
    }


    public Integer addProduct(ProductDB productDB) {

        int row = JDBIConnector.me().withHandle(handle -> {
            String query = "INSERT INTO Products (name,manufacturer_id,sell_quantity,remaning_quantity,thumbnail_url,price,description,info_warranty_id,specification_id) VALUES (?,?,?,?,?,?,?,?,?)";
            return handle.createUpdate(query)
                    .bind(0, productDB.getName())
                    .bind(1, productDB.getManufacturer_id())
                    .bind(2, productDB.getSell_quantity())
                    .bind(3, productDB.getRemaning_quantity())
                    .bind(4, productDB.getThumbnail_url())
                    .bind(5, productDB.getPrice())
                    .bind(6, productDB.getDescription())
                    .bind(7, productDB.getInfo_warranty_id())
                    .bind(8, productDB.getSpecification_id())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        });
        return row;
    }
    public List<ProductDB> findProductByName(String name) {

        List<ProductDB> products = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM Products WHERE name like ? order by id desc limit 8";
            return handle.createQuery(query).bind(0, "%" +  name + "%").mapToBean(ProductDB.class).list();
        });
        return products.isEmpty() ? null : products;
    }

    public int update(ProductDB productDB) {
        String query = "UPDATE products SET name = ?,manufacturer_id = ? , sell_quantity = ? , remaning_quantity = ? , thumbnail_url = ? , price = ? , description = ? , info_warranty_id = ? WHERE id = ?";
        return JDBIConnector.me().withHandle(
                handle -> handle.createUpdate(query)
                        .bind(0, productDB.getName())
                        .bind(1, productDB.getManufacturer_id())
                        .bind(2, productDB.getSell_quantity())
                        .bind(3, productDB.getRemaning_quantity())
                        .bind(4, productDB.getThumbnail_url())
                        .bind(5, productDB.getPrice())
                        .bind(6, productDB.getDescription())
                        .bind(7, productDB.getInfo_warranty_id())
                        .bind(8, productDB.getId())
                        .execute()
        );
    }
//    public boolean updateProduct(int quantitySell, int remainingQuantity, double priceProduct, String desString, int idDiscount, int idProduct) {
//        String query = "UPDATE products SET sell_quantity = ? , remaning_quantity = ? , price = ? , description = ? WHERE id = ?";
//        return JDBIConnector.me().withHandle(
//                handle -> handle.createUpdate(query)
//                        .bind(0, quantitySell)
//                        .bind(1, remainingQuantity)
//                        .bind(2, priceProduct)
//                        .bind(3, desString)
//                        .bind(4, idProduct)
//                        .execute());
//
//    }
//    public boolean updateDiscount(int idProduct, int idDiscount) {
//        String query ="Update discountproduct set discount_id = ? where product_id = ?";
//        return JDBIConnector.me().withHandle(handle -> handle.createUpdate(query)
//                .bind(0, idDiscount)
//                .bind(1, idProduct)
//                .execute());
//    }
public boolean updateProductAndDiscount(int quantitySell, int remainingQuantity, double priceProduct, String description, int idDiscount, int idProduct) {
    return JDBIConnector.me().withHandle(handle -> {
        handle.begin();  // Bắt đầu giao dịch
        boolean productUpdated = handle.createUpdate("UPDATE products SET sell_quantity = ?, remaning_quantity = ?, price = ?, description = ? WHERE id = ?")
                .bind(0, quantitySell)
                .bind(1, remainingQuantity)
                .bind(2, priceProduct)
                .bind(3, description)
                .bind(4, idProduct)
                .execute() > 0;

        boolean discountUpdated = handle.createUpdate("UPDATE discountproduct SET discount_id = ? WHERE product_id = ?")
                .bind(0, idDiscount)
                .bind(1, idProduct)
                .execute() > 0;

        if (productUpdated && discountUpdated) {
            handle.commit();  // Cam kết giao dịch nếu cả hai cập nhật thành công
            return true;
        } else {
            handle.rollback();  // Lùi giao dịch nếu một trong các cập nhật thất bại
            return false;
        }
    });
}

    public boolean updateNewPrice(double priceNew, int idProduct) {
        String query = "UPDATE products SET priceNew = :priceNew WHERE id = :id";
        return JDBIConnector.me().withHandle(
                handle -> handle.createUpdate(query)
                        .bind("priceNew", priceNew)
                        .bind("id", idProduct)
                        .execute()
        ) > 0; // Kiểm tra xem có bất kỳ hàng nào được cập nhật hay không
    }

    public static List<Integer> findProductByIDWarranty(int id) {
        List<Integer> products = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT p.id FROM Products p WHERE p.info_warranty_id = ?";
            return handle.createQuery(query).bind(0, id).mapTo(Integer.class).list();
        });
        return products.isEmpty() ? null : products;
    }

    public void deleteProduct(Integer idP) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM products WHERE id = ?")
                        .bind(0, idP)
                        .execute()
        );
    }

    public List<Integer> findProductByIDManufacturer(int id) {
        return JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT p.id FROM Products p WHERE p.manufacturer_id = ?";
            return handle.createQuery(query).bind(0, id).mapTo(Integer.class).list();
        });
    }
    public static List<Integer> getAllIdProduct() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT id FROM products")
                        .mapTo(Integer.class)
                        .list());
    }

    public static void main(String[] args) {
     System.out.println(findProductByIDWarranty(150));

    }
}
