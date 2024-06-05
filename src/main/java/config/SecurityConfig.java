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
        List<String> roleUsers = Arrays.asList(
                "/contacts*", "/page/news*", "/user/order*",
                "/payment*", "/profile*", "/user/info-account*"
        );

        List<String> roleManages = new ArrayList<>(roleUsers);
        roleManages.addAll(Arrays.asList(
                "/admin/revenue-statistics*", "/update-order*",
                "/admin/manage_manufacturer*", "/admin/manage_capacity*",
                "/admin/manage_discount*", "/admin/manage_color*",
                "/admin/product/add_product*", "/admin/manage_order*",
                "/admin/manage_warranty*"
        ));

        List<String> roleAdmins = new ArrayList<>(roleManages);
        roleAdmins.addAll(Arrays.asList(
                "/admin/product/edit_product*", "/admin/product/manage_product*",
                "/page/news*", "/admin/user/update_user*",
                "/add-news*", "/manage-news*",
                "/add-news*", "/update-news*",
                "/admin/user/manage_user*"
        ));

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
