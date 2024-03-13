package dao;

import config.JDBIConnector;
import model.*;
import modelDB.OrderProductVariantDB;
import modelDB.ProductVariantDB;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public class OrderProductVariantDAO {

    @Inject
    private OrderDAO orderDAO;

    @Inject
    private ProductVariantDAO productVariantDAO;

    @Inject
    private TransportDAO transportDAO;

    public boolean deleteOrderProductVariant(int id) {
        String query = "DELETE FROM orderproductvariant WHERE id = ?";
        int res = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, id)
                        .execute()
        );

        return res > 0;
    }


    public static boolean updateStatus(int id, int newStatus) {
        String query = "UPDATE orderproductvariant SET status = ? WHERE id = ?";

        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, newStatus)
                        .bind(1, id)
                        .execute()
        );

        return result > 0;
    }

    public List<OrderProductVariant> getAllOrderProductVariants() {
        final String query = "SELECT * FROM orderproductvariant";
        List<OrderProductVariantDB> lists = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .list()
        );
        List<OrderProductVariant> orders = lists.stream().map(this::mapData).toList();

        return orders.isEmpty() ? null : orders;

    }

    public static boolean findOrderByID_Account(int id) {
        String query = "SELECT COUNT(*) FROM orders WHERE account_id = ?";
        int count = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, id)
                        .mapTo(Integer.class)
                        .one());

        return count > 0;
    }

    public static Order findOrderByID_AccountModel(int id) {
        String query = "SELECT * FROM orders WHERE account_id = ?";

        try {
            Order order = JDBIConnector.me().withHandle(handle ->
                    handle.createQuery(query)
                            .bind(0, id)
                            .mapToBean(Order.class)
                            .findFirst()
                            .orElse(null)); // Nếu không tìm thấy, trả về null

            return order;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ nếu có
            return null; // Trả về null nếu có lỗi xảy ra
        }
    }


    public static boolean createOrderByID_Account(int accountId) {
        String query = "INSERT INTO orders (account_id) VALUES (?)";
        try {
            int rowsAffected = JDBIConnector.me().withHandle(handle ->
                    handle.createUpdate(query)
                            .bind(0, accountId)
                            .execute());

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean createOrderProductVariant(int product_variant_id, int order_id, int quantity,
                                                    int transport_id, double total_price, int status) {
        String query = "INSERT INTO orderproductvariant (product_variant_id, order_id, quantity, transport_id, buy_at, total_price, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Date buy_at = new Date();
        try {
            int rowsAffected = JDBIConnector.me().withHandle(handle ->
                    handle.createUpdate(query)
                            .bind(0, product_variant_id)
                            .bind(1, order_id)
                            .bind(2, quantity)
                            .bind(3, transport_id)
                            .bind(4, buy_at)
                            .bind(5, total_price)
                            .bind(6, status)
                            .execute());

            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<OrderProductVariant> filterByDate(String sDate, String eDate) {
        final String query = "SELECT * FROM orderproductvariant WHERE buy_at BETWEEN ? AND ?";
        List<OrderProductVariantDB> lists = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, sDate)
                        .bind(1, eDate)
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .list()
        );

        List<OrderProductVariant> orders = lists.stream().map(this::mapData).toList();

        return orders.isEmpty() ? null : orders;
    }

    public List<OrderProductVariant> filterByManufacturer(String nameManufacturer) {
        final String query = "SELECT orderproductvariant. * from orderproductvariant INNER JOIN ( productvariants INNER JOIN products ON productvariants.product_id = products.id)ON productvariants.id = orderproductvariant.product_variant_id WHERE products.manufacturer_id = ?";
        List<OrderProductVariantDB> lists = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, Integer.parseInt(nameManufacturer))
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .list()
        );

        List<OrderProductVariant> orders = lists.stream().map(this::mapData).toList();

        return orders.isEmpty() ? null : orders;

    }

    public List<OrderProductVariant> findOrderProductVariantsByOrderId(int orderID) {
        String query = "SELECT * FROM orderproductvariant WHERE order_id = ?";
        List<OrderProductVariantDB> lists = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, orderID)
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .list()
        );

        List<OrderProductVariant> orders = lists.stream().map(this::mapData).toList();

        return orders.isEmpty() ? null : orders;
    }

    public OrderProductVariant mapData(OrderProductVariantDB orderProductVariantDB) {
        OrderProductVariant orderProductVariant = new OrderProductVariant();
        orderProductVariant.setId(orderProductVariantDB.getId());
        orderProductVariant.setBuy_at(orderProductVariantDB.getBuy_at());
        orderProductVariant.setTotal_price(orderProductVariantDB.getTotal_price());
        orderProductVariant.setStatus(orderProductVariantDB.getStatus());
        orderProductVariant.setQuantity(orderProductVariantDB.getQuantity());
        ProductVariantDB productVariantDB = productVariantDAO.findProductVariantById(orderProductVariantDB.getProduct_variant_id());
        orderProductVariant.setProductVariant(productVariantDAO.convertData(productVariantDB));
        orderProductVariant.setOrder(orderDAO.getOrderById(orderProductVariantDB.getOrder_id()));
        orderProductVariant.setInforTransport(transportDAO.findInfoTransportById(orderProductVariantDB.getTransport_id()));
        return orderProductVariant;
    }

    public int findOrderProductVariantById(int getID) {
        final String query = "SELECT status FROM orderproductvariant WHERE id = ?";
        Optional<Integer> status = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, getID)
                        .mapTo(Integer.class)
                        .findFirst()
        );

        return status.orElse(0);
    }

    public List<OrderProductVariant> searchOrder(String keyword) {
        final String query = "SELECT * FROM orderproductvariant WHERE id LIKE ? OR product_variant_id LIKE ? OR order_id LIKE ? OR quantity LIKE ? OR transport_id LIKE ? OR buy_at LIKE ? OR total_price LIKE ? OR status LIKE ?";
        List<OrderProductVariantDB> lists = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, "%" + keyword + "%")
                        .bind(1, "%" + keyword + "%")
                        .bind(2, "%" + keyword + "%")
                        .bind(3, "%" + keyword + "%")
                        .bind(4, "%" + keyword + "%")
                        .bind(5, "%" + keyword + "%")
                        .bind(6, "%" + keyword + "%")
                        .bind(7, "%" + keyword + "%")
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .list()
        );

        List<OrderProductVariant> orders = lists.stream().map(this::mapData).toList();

        return orders.isEmpty() ? null : orders;
    }

    public void deleteOrderProductVariantByOrderId(Integer orderId) {
        String query = "DELETE FROM orderproductvariant WHERE order_id = ?";
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, orderId)
                        .execute()
        );
    }

    public void deleteOrderProductVariantByProductVariantId(int idP) {
        String query = "DELETE FROM orderproductvariant WHERE product_variant_id = ?";
        JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, idP)
                        .execute()
        );
    }

    public OrderProductVariant getOrderProductVariantById(int getID) {
        final String query = "SELECT * FROM orderproductvariant WHERE id = ?";
        Optional<OrderProductVariantDB> orderProductVariantDBs = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, getID)
                        .map((rs, ctx) -> {
                            OrderProductVariantDB orderProductVariantDB = new OrderProductVariantDB();
                            orderProductVariantDB.setId(rs.getInt("id"));
                            orderProductVariantDB.setProduct_variant_id(rs.getInt("product_variant_id"));
                            orderProductVariantDB.setOrder_id(rs.getInt("order_id"));
                            orderProductVariantDB.setQuantity(rs.getInt("quantity"));
                            orderProductVariantDB.setTransport_id(rs.getInt("transport_id"));
                            orderProductVariantDB.setBuy_at(Date.from(rs.getTimestamp("buy_at").toInstant()));
                            orderProductVariantDB.setTotal_price(rs.getDouble("total_price"));
                            orderProductVariantDB.setStatus(rs.getInt("status"));
                            return orderProductVariantDB;
                        })
                        .findFirst()
        );

        return orderProductVariantDBs.map(this::mapData).orElse(null);
    }

    public static InforTransport findInfoTransportByAccountId(int accountId) {
        String query = "SELECT * FROM infotransports WHERE account_id = ?";

        try {
            InforTransport infoTransport = JDBIConnector.me().withHandle(handle ->
                    handle.createQuery(query)
                            .bind(0, accountId)
                            .mapToBean(InforTransport.class)
                            .findFirst()
                            .orElse(null));

            return infoTransport;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ nếu có
            return null; // Trả về null nếu có lỗi xảy ra
        }


    }
}