package dao;

import config.JDBIConnector;
import model.Discount;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public class DiscountDAO {
    private static final Jdbi jdbi = JDBIConnector.me();

    public List<Discount> getDiscountsByProductId(int productId) {
        String query = "SELECT Discounts. * from Discounts INNER JOIN DiscountProduct\n" +
                "ON Discounts.id = DiscountProduct.discount_id\n" +
                "WHERE DiscountProduct.product_id = ?;";
        List<Discount> discounts = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query)
                    .bind(0, productId).map((ResultSet rs, StatementContext ctx) -> {
                        Discount discount = new Discount();
                        discount.setId(rs.getInt("id"));
                        discount.setName(rs.getString("name"));
                        discount.setCost(rs.getDouble("cost"));
                        discount.setCode(rs.getString("code"));
                        discount.setIs_active(rs.getInt("is_active"));
                        discount.setStart_at(rs.getDate("start_at"));
                        discount.setEnd_at(rs.getDate("end_at"));
                        return discount;
                    }).list();
        });
        return discounts.isEmpty() ? null : discounts;
    }


    public List<Discount> getAllDiscount() {
        String query = "SELECT * FROM discounts";
        List<Discount> discounts = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery(query)
                    .map((ResultSet rs, StatementContext ctx) -> {
                        Discount discount = new Discount();
                        discount.setId(rs.getInt("id"));
                        discount.setName(rs.getString("name"));
                        discount.setCost(rs.getDouble("cost"));
                        discount.setCode(rs.getString("code"));
                        discount.setIs_active(rs.getInt("is_active"));
                        discount.setStart_at(rs.getDate("start_at"));
                        discount.setEnd_at(rs.getDate("end_at"));
                        return discount;
                    }).list();
        });
        return discounts.isEmpty() ? null : discounts;
    }


    public Date convertToDateViaInstant(LocalDateTime dateToConvert) {
        return java.util.Date.from(dateToConvert.atZone(ZoneId.systemDefault())
                .toInstant());
    }



    public static Discount findDiscountByCode(String code) {
        String query = "SELECT * FROM discounts WHERE code = ?";
        Optional<Discount> result = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0,code)
                        .map((ResultSet rs, StatementContext ctx) -> {
                            Discount discount = new Discount();
                            discount.setId(rs.getInt("id"));
                            discount.setName(rs.getString("name"));
                            discount.setCost(rs.getDouble("cost"));
                            discount.setCode(rs.getString("code"));
                            discount.setIs_active(rs.getInt("is_active"));
                            discount.setStart_at(rs.getDate("start_at"));
                            discount.setEnd_at(rs.getDate("end_at"));
                            return discount;
                        })
                        .findFirst()
        );

        return result.orElse(null);
    }
    public static boolean isDiscount(int idProduct, int idDiscount) {
        String query = "SELECT COUNT(*) FROM discountproduct WHERE product_id=? AND discount_id=?";

        int count = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, idProduct)
                        .bind(1, idDiscount)
                        .mapTo(Integer.class)
                        .findOnly()
        );

        return count > 0;
    }

    public List<Discount> getDiscountNotInProduct(int productId) {
        String query = "SELECT * FROM discounts WHERE discounts.id NOT IN ( SELECT discount_id FROM discountproduct WHERE discountproduct.product_id = ?);";
        List<Discount> discounts = JDBIConnector.me().withHandle(handle -> handle.createQuery(query)
                .bind(0, productId).map((ResultSet rs, StatementContext ctx) -> {
                    Discount discount = new Discount();
                    discount.setId(rs.getInt("id"));
                    discount.setName(rs.getString("name"));
                    discount.setCost(rs.getDouble("cost"));
                    discount.setCode(rs.getString("code"));
                    discount.setIs_active(rs.getInt("is_active"));
                    discount.setStart_at(rs.getDate("start_at"));
                    discount.setEnd_at(rs.getDate("end_at"));
                    return discount;
                }).list());
        return discounts.isEmpty() ? null : discounts;
    }

    public List<Discount> findDiscountWithKeyWord(String keyword) {
        String query = "SELECT * FROM discounts WHERE name LIKE ? OR code LIKE ? OR id like ?;";
        List<Discount> discounts = JDBIConnector.me().withHandle(handle -> handle.createQuery(query)
                .bind(0, "%" + keyword + "%")
                .bind(1, "%" + keyword + "%")
                .bind(2, "%" + keyword + "%")
                .map((ResultSet rs, StatementContext ctx) -> {
                    Discount discount = new Discount();
                    discount.setId(rs.getInt("id"));
                    discount.setName(rs.getString("name"));
                    discount.setCost(rs.getDouble("cost"));
                    discount.setCode(rs.getString("code"));
                    discount.setIs_active(rs.getInt("is_active"));
                    discount.setStart_at(rs.getDate("start_at"));
                    discount.setEnd_at(rs.getDate("end_at"));
                    return discount;
                }).list());
        return discounts.isEmpty() ? null : discounts;
    }

    public boolean insertCapacity(Discount discount) {
        String query = "INSERT INTO discounts (name, cost, code, start_at, end_at, is_active) VALUES (?, ?, ?, ?, ?, ?);";
        int result = JDBIConnector.me().withHandle(handle -> handle.createUpdate(query)
                .bind(0, discount.getName())
                .bind(1, discount.getCost())
                .bind(2, discount.getCode())
                .bind(3, discount.getStart_at())
                .bind(4, discount.getEnd_at())
                .bind(5, discount.getIs_active())
                .execute());
        return result > 0;
    }

    public Discount findDiscountById(int idDiscountEdit) {
        String query = "SELECT * FROM discounts WHERE id = ?;";
        Optional<Discount> discount = JDBIConnector.me().withHandle(
                handle -> handle.createQuery(query)
                        .bind(0, idDiscountEdit)
                        .map((ResultSet rs, StatementContext ctx) -> {
                            Discount discount1 = new Discount();
                            discount1.setId(rs.getInt("id"));
                            discount1.setName(rs.getString("name"));
                            discount1.setCost(rs.getDouble("cost"));
                            discount1.setCode(rs.getString("code"));
                            discount1.setIs_active(rs.getInt("is_active"));
                            discount1.setStart_at(rs.getDate("start_at"));
                            discount1.setEnd_at(rs.getDate("end_at"));
                            return discount1;
                        }).findFirst()
        );
        return discount.orElse(null);
    }

    public boolean editDiscount(int idCapacity, Discount discountFromRequest) {
        String query = "UPDATE discounts SET name = ?, cost = ?, code = ?, start_at = ?, end_at = ?, is_active = ? WHERE id = ?;";
        int result = JDBIConnector.me().withHandle(handle -> handle.createUpdate(query)
                .bind(0, discountFromRequest.getName())
                .bind(1, discountFromRequest.getCost())
                .bind(2, discountFromRequest.getCode())
                .bind(3, discountFromRequest.getStart_at())
                .bind(4, discountFromRequest.getEnd_at())
                .bind(5, discountFromRequest.getIs_active())
                .bind(6, idCapacity)
                .execute());
        return result > 0;
    }
    public Optional<Discount> getDiscountByIdProduct(int idProduct) {
        String query = "SELECT discounts.* FROM discounts " +
                "INNER JOIN discountproduct ON discounts.id = discountproduct.discount_id " +
                "INNER JOIN products ON discountproduct.product_id = products.id " +
                "WHERE products.id = ?";
        try {
            return jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, idProduct)
                    .map((rs, ctx) -> {
                        Discount discount = new Discount();
                        discount.setId(rs.getInt("id"));
                        discount.setCost(rs.getDouble("cost"));
                        discount.setName(rs.getString("name"));
                        discount.setCode(rs.getString("code"));
                        discount.setIs_active(rs.getInt("is_active"));
                        discount.setAtStart(rs.getString("start_at"));
                        discount.setEndStart(rs.getString("end_at"));
                        return discount;
                    })
                    .findOne());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }


    public boolean deleteDiscount(int id) {
        String query = "DELETE FROM discounts WHERE id = ?;";
        int result = JDBIConnector.me().withHandle(handle -> handle.createUpdate(query)
                .bind(0, id)
                .execute());
        return result > 0;
    }

    public static void main(String[] args) {
        DiscountDAO discountDAO = new DiscountDAO();
        Discount discount =   findDiscountByCode("CODE2");
        System.out.print(DiscountDAO.isDiscount(306,discount.getId()));

    }
}
