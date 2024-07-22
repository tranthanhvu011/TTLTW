package dao;

import config.JDBIConnector;
import model.ChiNhanh;

import java.util.List;

public class BranchDAO {

    // Lấy tất cả các chi nhánh
    public List<ChiNhanh> getAllBranches() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM ChiNhanh")
                        .mapToBean(ChiNhanh.class)
                        .list()
        );
    }

    // Thêm chi nhánh mới
    public boolean addBranch(String name, String diaChiChiNhanh, String sdtChiNhanh, String emailChiNhanh) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO ChiNhanh (name, diaChiChiNhanh, sdtChiNhanh, emailChiNhanh) VALUES (:name, :diaChiChiNhanh, :sdtChiNhanh, :emailChiNhanh)")
                        .bind("name", name)
                        .bind("diaChiChiNhanh", diaChiChiNhanh)
                        .bind("sdtChiNhanh", sdtChiNhanh)
                        .bind("emailChiNhanh", emailChiNhanh)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Xóa chi nhánh theo ID
    public boolean deleteBranch(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM ChiNhanh WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Cập nhật chi nhánh theo ID
    public boolean updateBranch(int id, String name, String diaChiChiNhanh, String sdtChiNhanh, String emailChiNhanh) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE ChiNhanh SET name = :name, diaChiChiNhanh = :diaChiChiNhanh, sdtChiNhanh = :sdtChiNhanh, emailChiNhanh = :emailChiNhanh WHERE id = :id")
                        .bind("id", id)
                        .bind("name", name)
                        .bind("diaChiChiNhanh", diaChiChiNhanh)
                        .bind("sdtChiNhanh", sdtChiNhanh)
                        .bind("emailChiNhanh", emailChiNhanh)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Lấy chi nhánh theo ID
    public ChiNhanh getBranchById(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM ChiNhanh WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(ChiNhanh.class)
                        .findFirst() // Sử dụng findFirst() để tránh lỗi khi không có kết quả
                        .orElse(null) // Trả về null nếu không có kết quả
        );
    }


    public static List<Integer> getAllIdBranch() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT id FROM ChiNhanh")
                        .mapTo(Integer.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        BranchDAO branchDAO = new BranchDAO();
        System.out.println(branchDAO.getAllBranches());
        // Test thêm chi nhánh
//         System.out.println(branchDAO.addBranch("Chi nhánh mới", "Địa chỉ mới", "0123456789", "email@example.com"));
        // Test xóa chi nhánh
//         System.out.println(branchDAO.deleteBranch(1));
        // Test cập nhật chi nhánh
//         System.out.println(branchDAO.updateBranch(2, "Tên mới", "Địa chỉ mới", "0987654321", "newemail@example.com"));
    }
}
