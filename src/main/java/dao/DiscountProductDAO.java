package dao;

import config.JDBIConnector;

public class DiscountProductDAO {

    public int insert(int productId, int discountId) {
        return JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("INSERT INTO discountproduct(product_id, discount_id) VALUES (?,?)")
                        .bind(0, productId)
                        .bind(1, discountId)
                        .execute()
        );
    }

    public void deleteDiscountProductByDiscountId(int id) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM discountproduct WHERE discount_id = ?")
                        .bind(0, id)
                        .execute()
        );
    }

    public void deleteDiscountProductByProductId(Integer idP) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM discountproduct WHERE product_id = ?")
                        .bind(0, idP)
                        .execute()
        );
    }
}
