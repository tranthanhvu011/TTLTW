package service;

import dao.WarrantyDAO;
import model.InfoWarranty;

import javax.inject.Inject;
import java.util.List;

public class WarrantyService {

    @Inject
    private WarrantyDAO warrantyDAO;

    @Inject
    private ProductService productService;

    public List<InfoWarranty> getAllWarranty(){
        return warrantyDAO.getAllWarranty();
    }

    public List<InfoWarranty> findWarrantyWithKeyWord(String keyword) {
        return warrantyDAO.findWarrantyWithKeyWord(keyword);
    }

    public boolean insertWarranty(InfoWarranty warranty) {
        return warrantyDAO.insertWarranty(warranty);
    }

    public InfoWarranty findWarrantyById(int idWarrantyEdit) {
        return warrantyDAO.findWarrantyById(idWarrantyEdit);
    }

    public boolean editWarranty(int idWarranty, InfoWarranty warrantyFromRequest) {
        return warrantyDAO.editWarranty(idWarranty, warrantyFromRequest);
    }

    public boolean deleteWarranty(int id) {
        List<Integer> idProducts = productService.findProductByIDWarranty(id);
        try {
            if(!idProducts.isEmpty()){
                idProducts.forEach(idP -> productService.deleteProduct(idP));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return warrantyDAO.deleteWarranty(id);
    }
}
