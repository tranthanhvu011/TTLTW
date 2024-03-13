package dao;

import config.JDBIConnector;
import model.InforTransport;

import java.util.List;

public class TransportDAO {
    public static boolean updateTransportInfoByOrderId(int orderId, String newName, String newPhone, String newAddress) {
        String sql = "UPDATE InfoTransports SET name_reciver = ?, phone_reciver = ?, address_reciver = ? WHERE id = (SELECT transport_id FROM OrderProductVariant WHERE     product_variant_id  = ?)";
        int isUpdated = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, newName)
                        .bind(1, newPhone)
                        .bind(2, newAddress)
                        .bind(3, orderId)
                        .execute()
        );

        return isUpdated >0;
    }
    public static boolean updateTransportInfoByAccount_ID(int account_ID, String newName, String newPhone, String newAddress) {
        String sql = "UPDATE InfoTransports SET name_reciver = ?, phone_reciver = ?, address_reciver = ? WHERE account_id = ?";
        int isUpdated = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, newName)
                        .bind(1, newPhone)
                        .bind(2, newAddress)
                        .bind(3, account_ID)
                        .execute()
        );

        return isUpdated > 0;
    }

    public InforTransport findInfoTransportByAccountId(int accountId) {
        String query = "SELECT * FROM infotransports WHERE account_id = ?";

        try {

            return JDBIConnector.me().withHandle(handle ->
                    handle.createQuery(query)
                            .bind(0, accountId)
                            .mapToBean(InforTransport.class)
                            .findFirst()
                            .orElse(null));
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ nếu có
            return null; // Trả về null nếu có lỗi xảy ra
        }
    }

    public static boolean createInfoTransport(InforTransport infoTransport, int account_id) {
        String query = "INSERT INTO infotransports (name, time_delivery, cost, phone_reciver, " +
                "address_reciver, name_reciver, account_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            int rowCount = JDBIConnector.me().withHandle(handle ->
                    handle.createUpdate(query)
                            .bind(0, infoTransport.getName())
                            .bind(1, infoTransport.getTime_delivery())
                            .bind(2, infoTransport.getCost())
                            .bind(3, infoTransport.getPhone_reciver())
                            .bind(4, infoTransport.getAddress_reciver())
                            .bind(5, infoTransport.getName_reciver())
                            .bind(6, account_id)
                            .execute());

            return rowCount > 0; // Trả về true nếu có ít nhất một dòng được chèn
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ nếu có
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public InforTransport findInfoTransportById(int transportId) {
        String query = "SELECT * FROM infotransports WHERE id = ?";

        try {

            return JDBIConnector.me().withHandle(handle ->
                    handle.createQuery(query)
                            .bind(0, transportId)
                            .mapToBean(InforTransport.class)
                            .findFirst()
                            .orElse(null));
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ nếu có
            return null; // Trả về null nếu có lỗi xảy ra
        }
    }
}


