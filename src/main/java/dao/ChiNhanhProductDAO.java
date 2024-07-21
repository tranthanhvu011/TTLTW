package dao;

import config.JDBIConnector;
import model.ChiNhanhProduct;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class ChiNhanhProductDAO {

    public List<ChiNhanhProduct> getAll() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT idChiNhanh, idProductVariant, quantityProductVariant, priceOneProductVariant, priceAllProductVariant FROM productchinhanh")
                        .mapToBean(ChiNhanhProduct.class)
                        .list()
        );
    }

    public boolean add(ChiNhanhProduct chiNhanhProduct) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO productchinhanh (idChiNhanh, idProductVariant, quantityProductVariant, priceOneProductVariant, priceAllProductVariant) VALUES (:idChiNhanh, :idProductVariant, :quantityProductVariant, :priceOneProductVariant, :priceAllProductVariant)")
                        .bind("idChiNhanh", chiNhanhProduct.getIdChiNhanh())
                        .bind("idProductVariant", chiNhanhProduct.getIdProductVariant())
                        .bind("quantityProductVariant", chiNhanhProduct.getQuantityProductVariant())
                        .bind("priceOneProductVariant", chiNhanhProduct.getPriceOneProductVariant())
                        .bind("priceAllProductVariant", chiNhanhProduct.getGetPriceAllProductVariant())
                        .execute()
        );
        return rowsAffected > 0;
    }
    public boolean updateQuantity(int idChiNhanh, int idProductVariant, int additionalQuantity) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE productchinhanh SET quantityProductVariant = quantityProductVariant + :additionalQuantity WHERE idChiNhanh = :idChiNhanh AND idProductVariant = :idProductVariant")
                        .bind("idChiNhanh", idChiNhanh)
                        .bind("idProductVariant", idProductVariant)
                        .bind("additionalQuantity", additionalQuantity)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public boolean exists(int idChiNhanh, int idProductVariant) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM productchinhanh WHERE idChiNhanh = :idChiNhanh AND idProductVariant = :idProductVariant")
                        .bind("idChiNhanh", idChiNhanh)
                        .bind("idProductVariant", idProductVariant)
                        .mapTo(int.class)
                        .one()
        ) > 0;
    }
    public boolean deleteById(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM productChiNhanh WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public void addOrUpdateQuantity(int idChiNhanh, int idProductVariant, int quantity, double priceOneProductVariant) {
        if (exists(idChiNhanh, idProductVariant)) {
            updateQuantity(idChiNhanh, idProductVariant, quantity);
        } else {
            double priceAllProductVariant = priceOneProductVariant * quantity;
            ChiNhanhProduct chiNhanhProduct = new ChiNhanhProduct(idChiNhanh, idProductVariant, quantity, priceOneProductVariant, priceAllProductVariant);
            add(chiNhanhProduct);
        }
    }
    public List<ChiNhanhProduct> getChiNhanhByProductId(int idProductVariant) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT idChiNhanh, idProductVariant, quantityProductVariant, priceOneProductVariant, priceAllProductVariant FROM productchinhanh WHERE idProductVariant = :idProductVariant")
                        .bind("idProductVariant", idProductVariant)
                                   .mapToBean(ChiNhanhProduct.class)
                                .list()
                        );
    }
    public static void main(String[] args) {
        ChiNhanhProductDAO chiNhanhProductDAO = new ChiNhanhProductDAO();
      System.out.println(chiNhanhProductDAO.getChiNhanhByProductId(7));
    }
}