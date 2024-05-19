package dao;

import com.sun.tools.javac.Main;
import config.JDBIConnector;
import model.*;
import model.Product;
import model.ProductVariant;
import modelDB.ProductDB;
import modelDB.ProductVariantDB;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.util.ArrayList;
import javax.inject.Inject;
import java.util.List;
import java.util.Optional;

public class ProductVariantDAO {
    static ProductVariantDAO instance;

    public static ProductVariantDAO getInstance() {
        if (instance == null) {
            instance = new ProductVariantDAO();
        }
        return instance;
    }


    @Inject
    private ProductDAO productDAO;


    @Inject
    private ProductImageDAO productImageDAO;


    @Inject
    private ColorDAO colorDAO;

    @Inject
    private CapacityDAO capacityDAO;

    public List<ProductVariantDB> getAllProductVariant(int limit, int offset) {
        String query = "SELECT * FROM ProductVariants limit ? offset ?";
        List<ProductVariantDB> productDBs = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, limit)
                    .bind(1, offset)
                    .mapToBean(ProductVariantDB.class).list();
        });
        return productDBs.isEmpty() ? null : productDBs;
    }

    public boolean deleteProductVariant(int idP) {
        String query = "DELETE FROM ProductVariants WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate(query).bind(0, idP).execute();
        });
        return result > 0;
    }

    public List<ProductVariantDB> findProductVariantByKeyword(String keyword) {
        String query = "SELECT DISTINCT pv.* from productvariants pv INNER JOIN ( products p INNER JOIN manufacturers m on p.manufacturer_id = m.id)" +
                "ON pv.product_id = p.id WHERE m.`NAME` LIKE :keyword OR p.`name`LIKE :keyword";
        List<ProductVariantDB> productVariants = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query).bind("keyword", "'%" + keyword + "%'").mapToBean(ProductVariantDB.class).list();
        });
        return productVariants.isEmpty() ? null : productVariants;
    }

    public ProductVariantDB findProductVariantById(int id) {
//        String query = "SELECT * FROM ProductVariants WHERE id = :id";
//        Optional<ProductVariantDB> productVariantDB = JDBIConnector.me().withHandle(handle -> {
//            return handle.createQuery(query)
//                    .bind("id", id)
//                    .mapToBean(ProductVariantDB.class)
//                    .findOne();
//        });
//
//        return productVariantDB.orElse(null);
        Optional<ProductVariantDB> productVariantDB = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM ProductVariants WHERE id = :id";
            return handle.createQuery(query)
                    .bind("id", id)
                    .mapToBean(ProductVariantDB.class)
                    .findOne();
        });
        return productVariantDB.orElse(null);
    }

    //    public ProductVariant findProductVariant(int id){
//        String query = "SELECT * FROM ProductVariants WHERE id = :id";
//        Optional<ProductVariant> productVariant = JDBIConnector.me().withHandle(handle ->
//                handle.createQuery(query).bind("id", id).mapToBean(ProductVariant.class).findOne()
//        );
//        return productVariant.orElse(null);
//    }
    public ProductVariant findProductVariant(int id) {
        String query = "SELECT pv.id, " +
                "pv.product_id, " +
                "p.name AS product_name, " +
                "pv.color_id, " +
                "c.color_name, " +
                "pv.capacity_id, " +
                "cap.capacity_name, " +
                "pv.price, " +
                "pv.state, " +
                "i.image_url " +
                "FROM productvariants pv " +
                "JOIN products p ON pv.product_id = p.id " +
                "JOIN colors c ON pv.color_id = c.id " +
                "JOIN capacities cap ON pv.capacity_id = cap.id " +
                "JOIN productimages i ON pv.id = i.product_variant_id " +
                "WHERE pv.id = :id";
        List<ProductVariant> list = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query).bind("id", id).map((ResultSet rs, StatementContext ctx) -> {
                ProductVariant pv = new ProductVariant();
                Product product = new Product();
                Color color = new Color();
                color.setName(rs.getString("color_name"));
                ProductImage productImage = new ProductImage();
                List<ProductImage> images = new ArrayList<>();
                pv.setId(rs.getInt("id"));
                pv.setPrice(rs.getDouble("price"));
                product.setName(rs.getString("product_name"));
                product.setId(rs.getInt("product_id"));
                productImage.setImage_url(rs.getString("image_url"));
                pv.setColor(color);
                Capacity capacity = new Capacity();
                capacity.setName(rs.getString("capacity_name"));
                pv.setCapacity(capacity);
                images.add(productImage);
                pv.setProductImages(images);
                pv.setProduct(product);
                return pv;
            }).list();
        });

        return list.isEmpty() ? null : list.get(0);
    }

    public ProductVariant convertData(ProductVariantDB productVariantDB) {
        ProductVariant productVariant = new ProductVariant();
        productVariant.setId(productVariantDB.getId());
        Product product = new Product();
        product.setName(productDAO.findProductById(productVariantDB.getProduct_id()).getName());
        product.setId(productDAO.findProductById(productVariantDB.getProduct_id()).getId());
        productVariant.setProduct(product);
        productVariant.setColor(colorDAO.findColorById(productVariantDB.getColor_id()));
        productVariant.setCapacity(capacityDAO.findCapacityById(productVariantDB.getCapacity_id()));
        productVariant.setPrice(productVariantDB.getPrice());
        productVariant.setState(productVariantDB.getState());
        productVariant.setProductImages(productImageDAO.getAllProductImageByProductVariantId(productVariantDB.getId()));
        return productVariant;
    }


    public Integer addProductVariant(ProductVariantDB productVariantDB) {
        String query = "INSERT INTO ProductVariants(product_id,color_id,capacity_id,price,state) VALUES (?,?,?,?,?)";
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, productVariantDB.getProduct_id())
                        .bind(1, productVariantDB.getColor_id())
                        .bind(2, productVariantDB.getCapacity_id())
                        .bind(3, productVariantDB.getPrice())
                        .bind(4, productVariantDB.getState())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<ProductVariantDB> getAllProductVariantByIdProduct(int idProduct) {
        String query = "SELECT * FROM ProductVariants WHERE product_id = :id";
        List<ProductVariantDB> productVariantDB = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind("id", idProduct).mapToBean(ProductVariantDB.class).list()
        );
        return productVariantDB.isEmpty() ? null : productVariantDB;
    }

    public List<ProductVariant> getProductVariantByColorIDProductID(int idProduct, int colorID) {
        String query = "SELECT * FROM ProductVariants WHERE product_id = ? and color_id = ?";
        List<ProductVariant> productVariant = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind(0, idProduct).bind(1, colorID).mapToBean(ProductVariant.class).list()

        );
        return productVariant.isEmpty() ? null : productVariant;
    }

    public ProductVariant getProductVariantByCapacityIDProductID(int idProduct, int capacityID, int colorID) {
        String query = "SELECT * FROM ProductVariants WHERE product_id = ? and capacity_id = ? and color_ID = ?";
        Optional<ProductVariant> productVariant = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind(0, idProduct).bind(1, capacityID).bind(2, colorID).mapToBean(ProductVariant.class).findFirst()

        );
        return productVariant.orElse(null);
    }

    public int update(ProductVariantDB productVariantDB) {

        String query = "UPDATE productvariants SET productvariants.product_id = ? , productvariants.color_id = ? ," +
                "productvariants.capacity_id = ?, productvariants.price = ? , productvariants.state = ? " +
                "WHERE productvariants.id = ? ; ";
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, productVariantDB.getProduct_id())
                        .bind(1, productVariantDB.getColor_id())
                        .bind(2, productVariantDB.getCapacity_id())
                        .bind(3, productVariantDB.getPrice())
                        .bind(4, productVariantDB.getState())
                        .bind(5, productVariantDB.getId())
                        .execute()
        );


    }

    public List<Integer> findProductVariantByCapacityId(int id) {
        String query = "SELECT id FROM productvariants WHERE capacity_id = ?";
        List<Integer> productVariantIDs = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind(0, id).mapTo(Integer.class).list()
        );
        return productVariantIDs.isEmpty() ? null : productVariantIDs;
    }

    public List<Integer> findProductVariantByColorId(int id) {
        String query = "SELECT id FROM productvariants WHERE color_id = ?";
        List<Integer> productVariantIDs = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind(0, id).mapTo(Integer.class).list()
        );
        return productVariantIDs.isEmpty() ? null : productVariantIDs;
    }

    public void deleteProductVariantByProductId(Integer idP) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM productvariants WHERE product_id = ?")
                        .bind(0, idP)
                        .execute()
        );
    }

    public int countNumberPage() {
        String query = "SELECT COUNT(*) FROM productvariants";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).mapTo(Integer.class).one()
        );
    }
}
