package dao;

import config.JDBIConnector;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;

public class RevenueStatic {
    private static final Jdbi jdbi = JDBIConnector.me();
    public static model.RevenueStatic getProfileOderAccount(int idOderVariant, int idOder, int idTransport) {
        String query = "Select accounts.first_name,accounts.last_name, accounts.gender, accounts.phone_number, infotransports.address_reciver " +
                "from orderproductvariant inner join orders on orderproductvariant.order_id = orders.id " +
                "inner join accounts on orders.account_id = accounts.id " +
                "inner join infotransports on orderproductvariant.transport_id = infotransports.id " +
                "where orderproductvariant.id =? AND orderproductvariant.order_id = ? AND orderproductvariant.transport_id = ?";
        try {
            return jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, idOderVariant)
                    .bind(1, idOder)
                    .bind(2, idTransport)
                    .map((ResultSet rs, StatementContext ctx) -> {
                        model.RevenueStatic revenueStatic = new model.RevenueStatic();
                        revenueStatic.setId(idOder);
                        revenueStatic.setFirstName(rs.getString("accounts.first_name"));
                        revenueStatic.setLastName(rs.getString("accounts.last_name"));
                        revenueStatic.setGioiTinh(rs.getInt("accounts.gender"));
                        revenueStatic.setSdt(rs.getString("accounts.phone_number"));
                        revenueStatic.setDiachi(rs.getString("infotransports.address_reciver"));
                        return revenueStatic;
                    }).one());
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public static void main(String[] args) {
        System.out.print(getProfileOderAccount(10,1,11));
    }
}
