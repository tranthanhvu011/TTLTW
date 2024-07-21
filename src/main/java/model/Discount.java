package model;


import java.time.LocalDateTime;
import java.util.Date;

public class Discount {

    private int id;

    private String name;

    private double cost;

    private String code;

    private int is_active;

    private Date start_at;

    private Date end_at;

    private String atStart;
    private String endStart;

    public String getAtStart() {
        return atStart;
    }

    public void setAtStart(String atStart) {
        this.atStart = atStart;
    }

    public String getEndStart() {
        return endStart;
    }

    public void setEndStart(String endStart) {
        this.endStart = endStart;
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

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getIs_active() {
        return is_active;
    }

    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    public Date getStart_at() {
        return start_at;
    }

    public void setStart_at(Date start_at) {
        this.start_at = start_at;
    }

    public Date getEnd_at() {
        return end_at;
    }

    public void setEnd_at(Date end_at) {
        this.end_at = end_at;
    }

    @Override
    public String toString() {
        return "Discount{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", cost=" + cost +
                ", code='" + code + '\'' +
                ", is_active=" + is_active +
                ", start_at=" + start_at +
                ", end_at=" + end_at +
                ", atStart='" + atStart + '\'' +
                ", endStart='" + endStart + '\'' +
                '}';
    }
}
