package service;

import dao.ContactsDAO;
import model.Contacts;

import java.sql.SQLException;
import java.time.LocalDateTime;

public class ContactsService {
    public boolean saveContacts(Contacts contacts) throws SQLException {
        contacts.setCreate_at(LocalDateTime.now()) ;
        return ContactsDAO.saveContacts(contacts);
    }
}
