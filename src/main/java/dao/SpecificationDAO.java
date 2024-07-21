package dao;

import config.JDBIConnector;
import model.Specification;

import java.util.List;
import java.util.Optional;

public class SpecificationDAO {
    public Specification findSpecificationBytId(int id) {
        Optional<Specification> specification = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT * FROM Specifications WHERE id = ?";
            return handle.createQuery(query).bind(0, id).mapToBean(Specification.class).findOne();
        });
        return specification.orElse(null);
    }

    public Integer addSpecification(Specification specification) {
        return JDBIConnector.me().withHandle(handle -> {
            String query = "INSERT INTO Specifications (bluetooth,camera_after,battery_capacity,camera_before,cart_slot" +
                    ",chip_set,cpu_speed,dimensions,display_type,port_sac,ram,rom,the_sim) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            return handle.createUpdate(query)
                    .bind(0, specification.getBluetooth())
                    .bind(1, specification.getCamera_after())
                    .bind(2, specification.getBattery_capacity())
                    .bind(3, specification.getCamera_before())
                    .bind(4, specification.getCart_slot())
                    .bind(5, specification.getChip_set())
                    .bind(6, specification.getCpu_speed())
                    .bind(7, specification.getDimensions())
                    .bind(8, specification.getDisplay_type())
                    .bind(9, specification.getPort_sac())
                    .bind(10, specification.getRam())
                    .bind(11, specification.getRom())
                    .bind(12, specification.getThe_sim())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
        });
    }

    public int findSpecificationIdBySpecification(Specification specification) {
        Optional<Integer> id = JDBIConnector.me().withHandle(handle -> {
            String query = "SELECT id FROM Specifications WHERE bluetooth = ? AND camera_after = ? AND battery_capacity = ? AND camera_before = ? AND cart_slot = ? AND chip_set = ? AND cpu_speed = ? AND dimensions = ? AND display_type = ? AND port_sac = ? AND ram = ? AND rom = ? AND the_sim = ?";
            return handle.createQuery(query)
                    .bind(0, specification.getBluetooth())
                    .bind(1, specification.getCamera_after())
                    .bind(2, specification.getBattery_capacity())
                    .bind(3, specification.getCamera_before())
                    .bind(4, specification.getCart_slot())
                    .bind(5, specification.getChip_set())
                    .bind(6, specification.getCpu_speed())
                    .bind(7, specification.getDimensions())
                    .bind(8, specification.getDisplay_type())
                    .bind(9, specification.getPort_sac())
                    .bind(10, specification.getRam())
                    .bind(11, specification.getRom())
                    .bind(12, specification.getThe_sim())
                    .mapTo(Integer.class)
                    .findOne();
        });
        return id.orElse(-1);
    }

    public int update(Specification specification) {
        String query = "UPDATE specifications SET bluetooth=?,camera_after=?,battery_capacity=?,camera_before=?," +
                "cart_slot=?,chip_set=?,cpu_speed=?,dimensions=?,display_type=?,port_sac=?,ram=?,rom=?,the_sim=? " +
                "WHERE id = ?";
        return JDBIConnector.me().withHandle(
                handle ->
                        handle.createUpdate(query)
                                .bind(0, specification.getBluetooth())
                                .bind(1, specification.getCamera_after())
                                .bind(2, specification.getBattery_capacity())
                                .bind(3, specification.getCamera_before())
                                .bind(4, specification.getCart_slot())
                                .bind(5, specification.getChip_set())
                                .bind(6, specification.getCpu_speed())
                                .bind(7, specification.getDimensions())
                                .bind(8, specification.getDisplay_type())
                                .bind(9, specification.getPort_sac())
                                .bind(10, specification.getRam())
                                .bind(11, specification.getRom())
                                .bind(12, specification.getThe_sim())
                                .bind(13, specification.getId())
                                .execute()

        );
    }

    public static void main(String[] args) {
        SpecificationDAO specificationDAO = new SpecificationDAO();
        System.out.print(specificationDAO.findSpecificationBytId(174));
    }
}
