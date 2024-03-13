package service;

import dao.DiscountDAO;
import model.Discount;

import javax.inject.Inject;
import java.util.List;

public class DiscountService {

    @Inject
    private DiscountDAO discountDAO;
    @Inject
    private DiscountProductService discountProductService;

    public List<Discount> getAllDiscount() {
        return discountDAO.getAllDiscount();
    }

    public List<Discount> getDiscountNotInProduct(int productId){
        return discountDAO.getDiscountNotInProduct(productId);
    }

    public List<Discount> findDiscountWithKeyWord(String keyword) {
        return discountDAO.findDiscountWithKeyWord(keyword);
    }

    public boolean insertCapacity(Discount discount) {
        return discountDAO.insertCapacity(discount);
    }

    public Discount findDiscountById(int idDiscountEdit) {
        return discountDAO.findDiscountById(idDiscountEdit);
    }

    public boolean editDiscount(int idCapacity, Discount discountFromRequest) {
        return discountDAO.editDiscount(idCapacity, discountFromRequest);
    }

    public boolean deleteDiscount(int id) {
        try {
            discountProductService.deleteDiscountProductByDiscountId(id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return discountDAO.deleteDiscount(id);
    }
}
