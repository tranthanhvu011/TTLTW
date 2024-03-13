package dao;

import config.JDBIConnector;
import model.Order;

import java.util.List;

public class OrderDAO {

    public Order getOrderById(int orderId) {
        String query = "SELECT * FROM orders WHERE id = ?";

        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, orderId)
                        .mapToBean(Order.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public List<Integer> getIDOrdersByUserID(int idUser) {
        String query = "SELECT distinct id FROM orders WHERE account_id = ?";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, idUser)
                        .mapTo(Integer.class)
                        .list()
        );
    }

    public void deleteOrderByUserId(int idUser) {
        String query = "DELETE FROM orders WHERE account_id = ?";
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, idUser)
                        .execute()
        );
    }
}
