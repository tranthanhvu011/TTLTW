package model;

import java.time.LocalDateTime;

public class Contacts {
    private int id;
    private String fullname;
    private String email_address;
    private String title;
    private String phone_number;
    private int action;
    private String content;
    private LocalDateTime create_at;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    @Override
    public String toString() {
        return "Contacts{" +
                "id=" + id +
                ", fullname='" + fullname + '\'' +
                ", email_address='" + email_address + '\'' +
                ", title='" + title + '\'' +
                ", phone_number='" + phone_number + '\'' +
                ", action=" + action +
                ", content='" + content + '\'' +
                ", create_at=" + create_at +
                '}';
    }

    public int getAction() {
        return action;
    }

    public void setAction(int action) {
        this.action = action;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail_address() {
        return email_address;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }

}
