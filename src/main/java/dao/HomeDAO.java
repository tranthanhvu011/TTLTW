package dao;

import config.JDBIConnector;
import model.Account;
import model.Product;
import org.jdbi.v3.core.Jdbi;

import java.sql.PreparedStatement;
import java.util.List;

public class HomeDAO {
    ProductDAO productDAO = new ProductDAO();
    private static final Jdbi jdbi = JDBIConnector.me();
    public List<Product> getAllManufacture(int manufacturerId) {
        if (manufacturerId == -1) {
           List<Product> getALlProduct = JDBIConnector.me().withHandle(
                   handle -> {
                       return handle.createQuery("SELECT * FROM products").mapToBean(Product.class)
                               .list();
                   });
           return getALlProduct;

        }
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT p.*, n.NAME as nameManufac " +
                            "FROM products p " +
                            "INNER JOIN manufacturers n ON p.manufacturer_id = n.id " +
                            "WHERE n.id = :manufacturerId")
                    .bind("manufacturerId", manufacturerId)
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    public List<Product> getDuoi2Tr() {
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM products WHERE price <= 2000000")
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    public List<Product> get2Trden4Tr() {
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM products WHERE price > 2000000 AND price <= 4000000")
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    public List<Product> get4Trden7Tr() {
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM products WHERE price > 4000000 AND price <= 7000000")
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    public List<Product> get7Trden13Tr() {
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM products WHERE price > 7000000 AND price <= 13000000")
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    public List<Product> getTren13Tr() {
        List<Product> products = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM products WHERE price > 13000000")
                    .mapToBean(Product.class)
                    .list();
        });
        return products.isEmpty() ? null : products;
    }
    
    public static void main(String[] args) {
        HomeDAO homeDAO = new HomeDAO();
//        System.out.println(homeDAO.getAllManufacture(4));
       System.out.print(homeDAO.getAllManufacture(2));
    }

}
