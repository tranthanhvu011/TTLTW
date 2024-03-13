package service;

import dao.ManufacturerDAO;
import model.Manufacturer;

import javax.inject.Inject;
import java.util.List;

public class ManufacturerService {

    @Inject
    private ManufacturerDAO manufacturerDAO;

    @Inject
    private ProductService productService;

    public List<Manufacturer> getAllManufacturer() {
        return manufacturerDAO.getAllManufacturer();
    }

    public List<Manufacturer> findManufacturerWithKeyword(String keyword) {
        return manufacturerDAO.findManufacturerWithKeyword(keyword);
    }

    public boolean insertManufacturer(String name) {
        return manufacturerDAO.insertManufacturer(name);
    }

    public boolean deleteManufacturer(int id) {
        List<Integer> idProducts = productService.findProductByIDManufacturer(id);
        try {
            if(!idProducts.isEmpty()){
                idProducts.forEach(idP -> productService.deleteProduct(idP));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return manufacturerDAO.deleteManufacturer(id);
    }

    public Manufacturer findManufacturerById(int idManufacturerEdit) {
        return manufacturerDAO.findManufacturerById(idManufacturerEdit);
    }

    public boolean alertManufacturer(int idManufacturer, String nameManufacturer) {
        return manufacturerDAO.alertManufacturer(idManufacturer, nameManufacturer);
    }

    public int findManufacturerByName(String name) {
        Manufacturer manufacturer = manufacturerDAO.findManufacturerByName(name);
        if (manufacturer != null) {
            return 1;
        }
        return 0;
    }
}
