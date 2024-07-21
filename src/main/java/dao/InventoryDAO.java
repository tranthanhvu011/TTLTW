package dao;

import config.JDBIConnector;
import model.KhoHang;

import java.util.List;

public class InventoryDAO {
    public List<KhoHang> getAllInventory() {
        List<KhoHang> inventoryList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Kho")
                        .mapToBean(KhoHang.class)
                        .list());
        return inventoryList.isEmpty() ? null : inventoryList;
    }

    // Thêm kho hàng mới
    public boolean addInventory(String nameKho, String diaChiKho, String sdtKho, String emailKho) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO Kho (nameKho, diaChiKho, sdtKho, emailKho) VALUES (:nameKho, :diaChiKho, :sdtKho, :emailKho)")
                        .bind("nameKho", nameKho)
                        .bind("diaChiKho", diaChiKho)
                        .bind("sdtKho", sdtKho)
                        .bind("emailKho", emailKho)
                        .execute());
        return rowsAffected > 0;
    }

    // Xóa kho hàng theo ID
    public boolean deleteInventory(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM Kho WHERE id = :id")
                        .bind("id", id)
                        .execute());
        return rowsAffected > 0;
    }

    // Cập nhật kho hàng
    public boolean updateInventory(int id, String nameKho, String diaChiKho, String sdtKho, String emailKho) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE Kho SET nameKho = :nameKho, diaChiKho = :diaChiKho, sdtKho = :sdtKho, emailKho = :emailKho WHERE id = :id")
                        .bind("id", id)
                        .bind("nameKho", nameKho)
                        .bind("diaChiKho", diaChiKho)
                        .bind("sdtKho", sdtKho)
                        .bind("emailKho", emailKho)
                        .execute());
        return rowsAffected > 0;
    }

    // Lấy kho hàng theo ID
    public KhoHang getInventoryByID(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Kho WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(KhoHang.class)
                        .findOnly());
    }

    public static List<Integer> getAllIdInventory() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT id FROM Kho")
                        .mapTo(Integer.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        InventoryDAO inventoryDAO = new InventoryDAO();
        // Test các phương thức
//        System.out.println(inventoryDAO.addInventory("Kho A", "Địa chỉ A", "0123456789", "email@khoa.com"));
//        System.out.println(inventoryDAO.getInventoryByID(1));
//        System.out.println(inventoryDAO.updateInventory(1, "Kho B", "Địa chỉ B", "0987654321", "newemail@khoa.com"));
//        System.out.println(inventoryDAO.deleteInventory(1));
//        System.out.println(InventoryDAO.getAllIdInventory());
//        System.out.println(inventoryDAO.getAllInventory());
    }
}
