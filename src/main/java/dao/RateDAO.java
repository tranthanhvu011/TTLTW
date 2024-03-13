package dao;

import config.JDBIConnector;

public class RateDAO {

    public void deleteRateByProductId(Integer idP) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM rates WHERE product_id = ?")
                        .bind(0, idP)
                        .execute()
        );
    }
}
