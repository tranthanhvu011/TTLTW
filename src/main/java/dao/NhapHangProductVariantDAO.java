package dao;

import config.JDBIConnector;
import model.NhapHangProductVariant;

import java.util.List;

public class NhapHangProductVariantDAO {
    public boolean addNhapHangProductVariant(int idNhapHang, int idKho, int idProductVariant, int quantityProduct, double priceOneProduct, double priceAllProduct) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO nhaphangproductvariant (idNhapHang, idKho, idProductVariant, quantityProduct, priceOneProduct, priceAllProduct) VALUES (:idNhapHang, :idKho, :idProductVariant, :quantityProduct, :priceOneProduct, :priceAllProduct)")
                        .bind("idNhapHang", idNhapHang)
                        .bind("idKho", idKho)
                        .bind("idProductVariant", idProductVariant)
                        .bind("quantityProduct", quantityProduct)
                        .bind("priceOneProduct", priceOneProduct)
                        .bind("priceAllProduct", priceAllProduct)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public List<NhapHangProductVariant> getAll() {
        String query = "SELECT * FROM nhaphangproductvariant";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(NhapHangProductVariant.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        NhapHangProductVariantDAO nhapHangProductVariantDAO = new NhapHangProductVariantDAO();
        List<NhapHangProductVariant> list = nhapHangProductVariantDAO.getAll();
        for (NhapHangProductVariant item : list) {
            System.out.println(item.getQuantityProduct());
        }
    }
}

