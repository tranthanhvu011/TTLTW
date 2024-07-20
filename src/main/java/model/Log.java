package model;


public class Log {
    private int id;
    private int userID;
    private String ipAddress;
    private String level;
    private String beforeData;
    private String afterData;
    private String action;
    private String time;

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public String getBeforeData() { return beforeData; }
    public void setBeforeData(String beforeData) { this.beforeData = beforeData; }

    public String getAfterData() { return afterData; }
    public void setAfterData(String afterData) { this.afterData = afterData; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", userID=" + userID +
                ", ipAddress='" + ipAddress + '\'' +
                ", level='" + level + '\'' +
                ", beforeData='" + beforeData + '\'' +
                ", afterData='" + afterData + '\'' +
                ", action='" + action + '\'' +
                ", time='" + time + '\'' +
                '}';
    }

}
