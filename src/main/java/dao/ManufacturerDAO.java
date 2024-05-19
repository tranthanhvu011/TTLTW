package dao;

import config.JDBIConnector;
import model.Manufacturer;

import java.util.List;
import java.util.Optional;

public class ManufacturerDAO {
    public Manufacturer findManufacturerById(int manufacturerId) {
        Optional<Manufacturer> manufacturer = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM manufacturers WHERE id = ?";
            return handle.createQuery(query).bind(0, manufacturerId).mapToBean(Manufacturer.class).findOne();
        });
        return manufacturer.orElse(null);
    }

    public List<Manufacturer> getAllManufacturer() {
        String query = "SELECT * FROM manufacturers";
        List<Manufacturer> manufacturers = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).mapToBean(Manufacturer.class).list());
        return manufacturers.isEmpty() ? null : manufacturers;
    }

    public List<Manufacturer> findManufacturerWithKeyword(String keyword) {
        String query = "SELECT * FROM manufacturers WHERE name LIKE ? or id LIKE ?";
        List<Manufacturer> manufacturers = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, "%" + keyword + "%")
                        .bind(1, "%" + keyword + "%")
                        .mapToBean(Manufacturer.class).list());
        return manufacturers.isEmpty() ? null : manufacturers;
    }

    public boolean insertManufacturer(String name) {
        String query = "INSERT INTO manufacturers (name) VALUES (?)";
        int result = JDBIConnector.me().withHandle(handle -> handle.createUpdate(query).bind(0, name).execute());
        return result > 0;
    }

    public boolean deleteManufacturer(int id) {
        String query = "DELETE FROM manufacturers WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle -> handle.createUpdate(query).bind(0, id).execute());
        return result > 0;
    }

    public boolean alertManufacturer(int idManufacturer, String nameManufacturer) {
        String query = "UPDATE manufacturers SET name = ? WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query).bind(0, nameManufacturer).bind(1, idManufacturer).execute());
        return result > 0;
    }

    public Manufacturer findManufacturerByName(String name) {
        Optional<Manufacturer> manufacturer = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM manufacturers WHERE name = ?";
            return handle.createQuery(query).bind(0, name).mapToBean(Manufacturer.class).findOne();
        });
        return manufacturer.orElse(null);
    }
}
