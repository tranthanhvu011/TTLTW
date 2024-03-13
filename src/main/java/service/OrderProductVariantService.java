package service;

import dao.OrderProductVariantDAO;
import model.OrderProductVariant;

import javax.inject.Inject;
import java.util.List;

public class OrderProductVariantService {
    
    @Inject
    private OrderProductVariantDAO orderProductVariantDAO;

    public boolean deleteOrder(int id) {
        return orderProductVariantDAO.deleteOrderProductVariant(id);
    }

    public boolean updateStatus(int id, int status) {
        return OrderProductVariantDAO.updateStatus(id, status);
    }


    public List<OrderProductVariant> getAllOrderProductVariants() {
        return orderProductVariantDAO.getAllOrderProductVariants();
    }

    public List<OrderProductVariant> searchOrder(String keyword) {
        return orderProductVariantDAO.searchOrder(keyword);
    }

    public int findOrderProductVariantById(int getID) {
        return orderProductVariantDAO.findOrderProductVariantById(getID);
    }

    public void deleteOrderProductVariantByProductVariantId(int idP) {
        orderProductVariantDAO.deleteOrderProductVariantByProductVariantId(idP);
    }

    public OrderProductVariant getOrderProductVariantById(int getID) {
        return orderProductVariantDAO.getOrderProductVariantById(getID);
    }

    public List<OrderProductVariant> filterByDate(String sDate, String eDate) {
        return orderProductVariantDAO.filterByDate(sDate, eDate);
    }

    public List<OrderProductVariant> filterByManufacturer(String nameManufacturer) {
        return orderProductVariantDAO.filterByManufacturer(nameManufacturer);
    }

    public List<OrderProductVariant> findOrderProductVariantsByOrderId(int status) {
        return orderProductVariantDAO.findOrderProductVariantsByOrderId(status);
    }
}
