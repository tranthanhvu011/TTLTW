package dao;

import config.JDBIConnector;
import model.ChiNhanhVariant;

import java.util.List;

public class ChiNhanhVariantDAO {

    // Lấy tất cả các biến thể chi nhánh
    public List<ChiNhanhVariant> getAllChiNhanhVariant() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM chinhanhproduct")
                        .mapToBean(ChiNhanhVariant.class)
                        .list()
        );
    }

    public boolean addChiNhanhVariant(int idchinhanh, int idproductvariant, int quantity, int idkho) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO chinhanhproduct (idchinhanh, idproductvariant, quantity, idkho) VALUES (:idchinhanh, :idproductvariant, :quantity, :idkho)")
                        .bind("idchinhanh", idchinhanh)
                        .bind("idproductvariant", idproductvariant)
                        .bind("quantity", quantity)
                        .bind("idkho", idkho)
                        .execute()
        );
        return rowsAffected > 0;
    }

    public boolean deleteChiNhanhVariant(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM chinhanhproduct WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }

    public boolean updateChiNhanhVariant(int id, int idchinhanh, int idproductvariant, int quantity, int idkho) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE chinhanhproduct SET idchinhanh = :idchinhanh, idproductvariant = :idproductvariant, quantity = :quantity, idkho = :idkho WHERE id = :id")
                        .bind("id", id)
                        .bind("idchinhanh", idchinhanh)
                        .bind("idproductvariant", idproductvariant)
                        .bind("quantity", quantity)
                        .bind("idkho", idkho)
                        .execute()
        );
        return rowsAffected > 0;
    }
// test
    public static void main(String[] args) {
        ChiNhanhVariantDAO dao = new ChiNhanhVariantDAO();
        System.out.println(dao.addChiNhanhVariant(1,1,500,1));
        System.out.println(dao.getAllChiNhanhVariant());
//        System.out.println(dao.updateChiNhanhVariant(1,22,22,22,22));
//        dao.deleteChiNhanhVariant(1);
    }
}
