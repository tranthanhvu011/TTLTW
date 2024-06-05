package model;

import java.sql.Date;

public class Account {

    private int id;
    private String email;
    private String first_name;
    private String last_name;
    private String phone_number;
    private String address;
    private String password;
    private int gender;
    private String role;
    private int is_active;
    private Date dob;
    private String created_at;
    private String last_login;
    private String lastIPLogin;
    private String countryLoginByIp;

    public Account(String email, String first_name, String last_name, String phone_number, String address, String password, int gender, String role, int is_active, Date dob, String lastIPLogin, String countryLoginByIp) {
        this.email = email;
        this.first_name = first_name;
        this.last_name = last_name;
        this.phone_number = phone_number;
        this.address = address;
        this.password = password;
        this.gender = gender;
        this.role = role;
        this.is_active = is_active;
        this.dob = dob;
        this.lastIPLogin = lastIPLogin;
        this.countryLoginByIp = countryLoginByIp;
    }

    public Account() {

    }

    public String getLastIPLogin() {
        return lastIPLogin;
    }

    public void setLastIPLogin(String lastIPLogin) {
        this.lastIPLogin = lastIPLogin;
    }

    public String getCountryLoginByIp() {
        return countryLoginByIp;
    }

    public void setCountryLoginByIp(String countryLoginByIp) {
        this.countryLoginByIp = countryLoginByIp;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getIs_active() {
        return is_active;
    }

    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    public java.sql.Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getLast_login() {
        return last_login;
    }

    public void setLast_login(String last_login) {
        this.last_login = last_login;
    }
}
