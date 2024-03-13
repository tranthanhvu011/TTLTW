package dao;

import config.JDBIConnector;
import model.Contacts;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;
import java.util.List;

public class ContactsDAO {
    private static final Jdbi jdbi = JDBIConnector.me();

    public static boolean saveContacts(Contacts contacts) throws SQLException {
        String query = "INSERT INTO contacts (full_name, email_address, phone_number, title, content, create_at, action) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int rowUpdated = jdbi.withHandle(handle -> {
                    return handle.createUpdate(query)
                            .bind(0, contacts.getFullname())
                            .bind(1, contacts.getEmail_address())
                            .bind(2, contacts.getPhone_number())
                            .bind(3, contacts.getTitle())
                            .bind(4, contacts.getContent())
                            .bind(5, contacts.getCreate_at())
                            .bind(6, contacts.getAction())
                            .execute();
                }
        );
        return rowUpdated > 0;
    }

    public static List<Contacts> selectContacts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM contacts")
                        .mapToBean(Contacts.class)
                        .list()
        );
    }
    public boolean removeContacts (int idContacts){
        int affectedRows = jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM contacts WHERE id = :id")
                        .bind("id", idContacts)
                        .execute()
        );
        return affectedRows > 0; // Trả về true nếu có hàng bị ảnh hưởng
    }
    public boolean updateAction(int idContacts) {
        int updateAction = jdbi.withHandle(handle ->
                handle.createUpdate("Update contacts set action = 1 where id = :id")
                        .bind("id", idContacts)
                        .execute()
        );
        return updateAction > 0;
    }


    public static void main(String[] args) {
        ContactsDAO contactsDAO = new ContactsDAO();
//        System.out.print(contactsDAO.selectContacts());
//        System.out.print(contactsDAO.removeContacts(1));
        System.out.print(contactsDAO.updateAction(5));

    }



}
