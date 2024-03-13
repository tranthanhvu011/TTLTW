package model;

public class InfoWarranty {

    private int id;

    private String time_warranty;

    private String address_warranty;

    private String term_waranty;

    @Override
    public String toString() {
        return "InfoWarranty{" +
                "id=" + id +
                ", time_warranty='" + time_warranty + '\'' +
                ", address_warranty='" + address_warranty + '\'' +
                ", term_waranty='" + term_waranty + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTime_warranty() {
        return time_warranty;
    }

    public void setTime_warranty(String time_warranty) {
        this.time_warranty = time_warranty;
    }

    public String getAddress_warranty() {
        return address_warranty;
    }

    public void setAddress_warranty(String address_warranty) {
        this.address_warranty = address_warranty;
    }

    public String getTerm_waranty() {
        return term_waranty;
    }

    public void setTerm_waranty(String term_waranty) {
        this.term_waranty = term_waranty;
    }
}
