package model;

public class ProductDetail {
    private int id;
    private Object comment;
    private String soDienThoai;
    private String nameComment;
    private String dateTimeCreateComment;

    public ProductDetail() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Object getComment() {
        return comment;
    }

    public void setComment(Object comment) {
        this.comment = comment;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getNameComment() {
        return nameComment;
    }

    public void setNameComment(String nameComment) {
        this.nameComment = nameComment;
    }

    public String getDateTimeCreateComment() {
        return dateTimeCreateComment;
    }

    public void setDateTimeCreateComment(String dateTimeCreateComment) {
        this.dateTimeCreateComment = dateTimeCreateComment;
    }

    @Override
    public String toString() {
        return "ProductDetail{" +
                "id=" + id +
                ", comment=" + comment +
                ", soDienThoai='" + soDienThoai + '\'' +
                ", nameComment='" + nameComment + '\'' +
                ", dateTimeCreateComment='" + dateTimeCreateComment + '\'' +
                '}';
    }
}
