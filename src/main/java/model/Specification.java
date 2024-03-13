package model;

public class Specification {

    private int id;
    private String bluetooth;
    private String camera_after;
    private String camera_before;
    private String battery_capacity;
    private String cart_slot;
    private String chip_set;
    private String cpu_speed;
    private String dimensions;
    private String display_type;
    private String port_sac;
    private String ram;
    private String rom;
    private String the_sim;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBluetooth() {
        return bluetooth;
    }

    public void setBluetooth(String bluetooth) {
        this.bluetooth = bluetooth;
    }

    public String getCamera_after() {
        return camera_after;
    }

    public void setCamera_after(String camera_after) {
        this.camera_after = camera_after;
    }

    public String getCamera_before() {
        return camera_before;
    }

    public void setCamera_before(String camera_before) {
        this.camera_before = camera_before;
    }

    public String getBattery_capacity() {
        return battery_capacity;
    }

    public void setBattery_capacity(String battery_capacity) {
        this.battery_capacity = battery_capacity;
    }

    public String getCart_slot() {
        return cart_slot;
    }

    public void setCart_slot(String cart_slot) {
        this.cart_slot = cart_slot;
    }

    public String getChip_set() {
        return chip_set;
    }

    public void setChip_set(String chip_set) {
        this.chip_set = chip_set;
    }

    public String getCpu_speed() {
        return cpu_speed;
    }

    public void setCpu_speed(String cpu_speed) {
        this.cpu_speed = cpu_speed;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public String getDisplay_type() {
        return display_type;
    }

    public void setDisplay_type(String display_type) {
        this.display_type = display_type;
    }

    public String getPort_sac() {
        return port_sac;
    }

    public void setPort_sac(String port_sac) {
        this.port_sac = port_sac;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public String getRom() {
        return rom;
    }

    public void setRom(String rom) {
        this.rom = rom;
    }

    public String getThe_sim() {
        return the_sim;
    }

    public void setThe_sim(String the_sim) {
        this.the_sim = the_sim;
    }

    @Override
    public String toString() {
        return "Specification{" +
                "id=" + id +
                ", bluetooth='" + bluetooth + '\'' +
                ", camera_after='" + camera_after + '\'' +
                ", camera_before='" + camera_before + '\'' +
                ", battery_capacity='" + battery_capacity + '\'' +
                ", cart_slot='" + cart_slot + '\'' +
                ", chip_set='" + chip_set + '\'' +
                ", cpu_speed='" + cpu_speed + '\'' +
                ", dimensions='" + dimensions + '\'' +
                ", display_type='" + display_type + '\'' +
                ", port_sac='" + port_sac + '\'' +
                ", ram='" + ram + '\'' +
                ", rom='" + rom + '\'' +
                ", the_sim='" + the_sim + '\'' +
                '}';
    }
}
