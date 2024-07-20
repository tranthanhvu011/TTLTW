package dao;

import config.JDBIConnector;
import model.ChiNhanh;

import java.util.List;

public class BranchDAO {

    // Lấy tất cả các chi nhánh
    public List<ChiNhanh> getAllBranches() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM chinhanh")
                        .mapToBean(ChiNhanh.class)
                        .list()
        );
    }

    // Thêm chi nhánh mới
    public boolean addBranch(String name) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO chinhanh (name) VALUES (:name)")
                        .bind("name", name)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Xóa chi nhánh theo ID
    public boolean deleteBranch(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM chinhanh WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Cập nhật chi nhánh theo ID
    public boolean updateBranch(int id, String name) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE chinhanh SET name = :name WHERE id = :id")
                        .bind("id", id)
                        .bind("name", name)
                        .execute()
        );
        return rowsAffected > 0;
    }

    // Lấy chi nhánh theo ID
    public ChiNhanh getBranchById(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM chinhanh WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(ChiNhanh.class)
                        .findOnly()
        );
    }

    public static void main(String[] args) {
        BranchDAO branchDAO = new BranchDAO();

    }
}
