package dao;

import config.JDBIConnector;
import model.Rate;

import java.util.List;

public class RateDAO {

    public void deleteRateByProductId(Integer idP) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("DELETE FROM rate WHERE product_id = ?")
                        .bind(0, idP)
                        .execute()
        );
    }

    public void addRate(Rate rate) {
        JDBIConnector.me().withHandle(
                handle -> handle
                        .createUpdate("INSERT INTO rate (product_id, account_id, number_rate, comment) VALUES (?, ?, ?, ?)")
                        .bind(0, rate.getProduct_id())
                        .bind(1, rate.getAccount_id())
                        .bind(2, rate.getNumber_rate())
                        .bind(3, rate.getComment())
                        .execute()
        );
    }

    public List<Rate> getAllRate() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM rate")
                        .mapToBean(Rate.class)
                        .list()
        );
    }
    public List<Rate> getRatesByProductId(int productId) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM rate WHERE product_id = :productId ORDER BY number_rate DESC")
                        .bind("productId", productId)
                        .mapToBean(Rate.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        RateDAO rateDAO = new RateDAO();
        System.out.println(rateDAO.getRatesByProductId(173));
    }
}
