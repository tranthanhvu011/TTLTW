package dao;

import config.JDBIConnector;
import model.InfoWarranty;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.Optional;

public class WarrantyDAO {
    private static final Jdbi jdbi = JDBIConnector.me();

    public InfoWarranty findWarrantyById(int productId) {

        Optional<InfoWarranty> infoWarranties = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM InfoWarranties WHERE id = ?";
            return handle.createQuery(query).
                    bind(0, productId).
                    mapToBean(InfoWarranty.class).
                    findOne();
        });

        return infoWarranties.orElse(null);
    }

    public List<InfoWarranty> getAllWarranty() {
        String query = "SELECT * FROM InfoWarranties";
        List<InfoWarranty> infoWarranties = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(InfoWarranty.class).list());
        return infoWarranties.isEmpty() ? null : infoWarranties;
    }

    public List<InfoWarranty> findWarrantyWithKeyWord(String keyword) {
        String query = "SELECT * FROM InfoWarranties WHERE infowarranties.term_waranty LIKE ? OR address_warranty LIKE ? OR  time_warranty LIKE ? or  id LIKE ?";
        List<InfoWarranty> infoWarranties = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, "%" + keyword + "%")
                        .bind(1, "%" + keyword + "%")
                        .bind(2, "%" + keyword + "%")
                        .bind(3, "%" + keyword + "%")
                        .mapToBean(InfoWarranty.class).list());
        return infoWarranties.isEmpty() ? null : infoWarranties;
    }

    public boolean insertWarranty(InfoWarranty warranty) {
        String query = "INSERT INTO InfoWarranties (term_waranty, address_warranty, time_warranty) VALUES (?, ?, ?)";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, warranty.getTerm_waranty())
                        .bind(1, warranty.getAddress_warranty())
                        .bind(2, warranty.getTime_warranty())
                        .execute());
        return result > 0;
    }

    public boolean editWarranty(int idWarranty, InfoWarranty warrantyFromRequest) {
        String query = "UPDATE InfoWarranties SET term_waranty = ?, address_warranty = ?, time_warranty = ? WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, warrantyFromRequest.getTerm_waranty())
                        .bind(1, warrantyFromRequest.getAddress_warranty())
                        .bind(2, warrantyFromRequest.getTime_warranty())
                        .bind(3, idWarranty)
                        .execute());
        return result > 0;
    }

    public boolean deleteWarranty(int id) {
        String query = "DELETE FROM InfoWarranties WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, id)
                        .execute());
        return result > 0;
    }
    public Optional<InfoWarranty> getInfoWarantyByIDProduct(int idProduct) {
        String query = "SELECT infowarranties.* FROM infowarranties " +
                "INNER JOIN products ON infowarranties.id = products.info_warranty_id " +
                "WHERE products.id = ?";
        try {
            return jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, idProduct)
                    .map((rs, ctx) -> {
                        InfoWarranty infoWarranty = new InfoWarranty();
                        infoWarranty.setId(rs.getInt("id"));
                        infoWarranty.setTime_warranty(rs.getString("time_warranty"));
                        infoWarranty.setAddress_warranty(rs.getString("address_warranty"));
                        infoWarranty.setTerm_waranty(rs.getString("term_waranty"));
                        return infoWarranty;
                    })
                    .findOne());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public static void main(String[] args) {
        WarrantyDAO warrantyDAO = new WarrantyDAO();
        System.out.print(warrantyDAO.getInfoWarantyByIDProduct(197));
    }
}
