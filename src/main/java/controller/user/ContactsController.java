package controller.user;

import model.Contacts;
import service.ContactsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/contacts"})

public class ContactsController extends HttpServlet {
    ContactsService contactsService = new ContactsService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/contact.jsp").forward(req, resp);

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Contacts contacts = new Contacts();
            contacts.setFullname(req.getParameter("name"));
            contacts.setEmail_address(req.getParameter("email_address"));
            contacts.setPhone_number(req.getParameter("phone_number"));
            contacts.setTitle(req.getParameter("title"));
            contacts.setContent(req.getParameter("content"));
            System.out.println(contacts);
            if (contacts.getFullname().equals("") || contacts.getEmail_address().equals("") || contacts.getPhone_number().equals("") || contacts.getTitle().equals("") || contacts.getContent().equals("                                    ") ) {
                req.setAttribute("thatBaiContacts", "Vui Lòng Nhập Đầy Đủ Thông Tin");
                req.getRequestDispatcher("/view/contact.jsp").forward(req, resp);
            } else {
                contactsService.saveContacts(contacts);
                req.setAttribute("thanhCongContacts", "Bạn đã gửi liên hệ thành công");
                req.getRequestDispatcher("/view/contact.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }}