package service;

import dao.DiscountProductDAO;

import javax.inject.Inject;

public class DiscountProductService {

    @Inject
    private DiscountProductDAO discountProductDAO;

    public void insert(int idProduct, int idDiscount) {
        discountProductDAO.insert(idProduct, idDiscount);
    }

    public void deleteDiscountProductByDiscountId(int id) {
        discountProductDAO.deleteDiscountProductByDiscountId(id);
    }
}
