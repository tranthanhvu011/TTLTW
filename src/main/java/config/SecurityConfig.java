package config;

import java.util.*;

public class SecurityConfig {

    public static final String ROLE_ADMIN = "admin";
    public static final String ROLE_USER = "user";
    public static final String ROLE_MANAGE = "manage";

    private static final Map<String, List<String>> mapRole = new HashMap<>();

    static {
        init();
    }


    public static void init() {
        List<String> roleUsers = new ArrayList<>();
//        roleUsers.add("/cart");
        roleUsers.add("/contacts*");
        roleUsers.add("/page/news*");
        roleUsers.add("/user/order*");
        roleUsers.add("/payment*");
        roleUsers.add("/profile*");
        roleUsers.add("/user/info-account*");



        List<String> roleManages = new ArrayList<>();
        roleUsers.forEach(r -> roleManages.add(r));
        roleManages.add("/admin/revenue-statistics*");
        roleManages.add("/update-order*");
        roleManages.add("/admin/manage_manufacturer*");
        roleManages.add("/admin/manage_capacity*");
        roleManages.add("/admin/manage_discount*");
        roleManages.add("/admin/product/edit_product*");
        roleManages.add("/admin/product/manage_product*");
        roleManages.add("/admin/manage_color*");
        roleManages.add("/admin/product/add_product*");
        roleManages.add("/admin/manage_order*");
        roleManages.add("/admin/manage_warranty*");


        List<String> roleAdmins = new ArrayList<>();
        roleManages.forEach(r -> roleAdmins.add(r));
        roleUsers.forEach(r -> roleAdmins.add(r));
        roleAdmins.add("/page/news*");
        roleAdmins.add("/admin/user/update_user*");
        roleAdmins.add("/add-news*");
        roleAdmins.add("/manage-news*");
        roleAdmins.add("/add-news*");
        roleAdmins.add("/update-news*");
        roleAdmins.add("/admin/user/manage_user*");

        mapRole.put(ROLE_USER, roleUsers);
        mapRole.put(ROLE_MANAGE, roleManages);
        mapRole.put(ROLE_ADMIN, roleAdmins);

    }

    public static Set<String> getAllRoles() {
        return mapRole.keySet();
    }

    public static List<String> getListRole(String role) {
        return mapRole.get(role);
    }

}
