package dao;

import config.JDBIConnector;
import model.NhapHang;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class NhapHangDAO {

    public List<NhapHang> getAll() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM nhapHang")
                        .mapToBean(NhapHang.class)
                        .list()
        );
    }

    public boolean update(int id, int idKho, int idChiNhanh, String tenNguoiDaiDien) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE nhapHang SET idKho = :idKho, idChiNhanh = :idChiNhanh, tenNguoiDaiDien = :tenNguoiDaiDien WHERE id = :id")
                        .bind("id", id)
                        .bind("idKho", idKho)
                        .bind("idChiNhanh", idChiNhanh)
                        .bind("tenNguoiDaiDien", tenNguoiDaiDien)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public boolean delete(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM nhapHang WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public boolean add(int idKho, int idChiNhanh, String tenNguoiDaiDien) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO nhapHang (idKho, idChiNhanh, tenNguoiDaiDien) VALUES (:idKho, :idChiNhanh, :tenNguoiDaiDien)")
                        .bind("idKho", idKho)
                        .bind("idChiNhanh", idChiNhanh)
                        .bind("tenNguoiDaiDien", tenNguoiDaiDien)
                        .execute()
        );
        return rowsAffected > 0;
    }
    public NhapHang getById(int id) {
        String query = "SELECT * FROM nhapHang WHERE id = :id";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind("id", id)
                        .mapToBean(NhapHang.class)
                        .findFirst()
                        .orElse(null)
        );
    }
    public static void main(String[] args) {
        NhapHangDAO nhapHangDAO = new NhapHangDAO();
        System.out.println(nhapHangDAO.getById(1));
    }
}
