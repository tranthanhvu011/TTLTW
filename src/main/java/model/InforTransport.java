package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class InforTransport {

    int id;
    String name;
    int time_delivery;
    double cost;
    String phone_reciver;
    String address_reciver;
    String name_reciver;

    public InforTransport() {
    }

    public InforTransport(int id, String name, int time_delivery, double cost, String phone_reciver, String address_reciver, String name_reciver) {
        this.id = id;
        this.name = name;
        this.time_delivery = time_delivery;
        this.cost = cost;
        this.phone_reciver = phone_reciver;
        this.address_reciver = address_reciver;
        this.name_reciver = name_reciver;
    }

    @Override
    public String toString() {
        return "InforTransport{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", time_delivery=" + time_delivery +
                ", cost=" + cost +
                ", phone_reciver='" + phone_reciver + '\'' +
                ", address_reciver='" + address_reciver + '\'' +
                ", name_reciver='" + name_reciver + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getTime_delivery() {
        return time_delivery;
    }

    public void setTime_delivery(int time_delivery) {
        this.time_delivery = time_delivery;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public String getPhone_reciver() {
        return phone_reciver;
    }

    public void setPhone_reciver(String phone_reciver) {
        this.phone_reciver = phone_reciver;
    }

    public String getAddress_reciver() {
        return address_reciver;
    }

    public void setAddress_reciver(String address_reciver) {
        this.address_reciver = address_reciver;
    }

    public String getName_reciver() {
        return name_reciver;
    }

    public void setName_reciver(String name_reciver) {
        this.name_reciver = name_reciver;
    }
}
