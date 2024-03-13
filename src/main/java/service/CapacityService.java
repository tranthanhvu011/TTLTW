package service;

import dao.CapacityDAO;
import model.Capacity;
import model.Manufacturer;

import javax.inject.Inject;
import java.util.List;

public class CapacityService {

    @Inject
    private CapacityDAO capacityDAO;

    @Inject
    private ProductVariantService productVariantService;


    public List<Capacity> getAllCapacities() {
        List<Capacity> capacities = capacityDAO.getAllCapacities();
        return capacities.isEmpty() ? null : capacities;
    }

    public List<Capacity> findCapacityWithKeyWord(String keyword) {
        List<Capacity> capacities = capacityDAO.findCapacityWithKeyword(keyword);
        return capacities.isEmpty() ? null : capacities;
    }

    public boolean insertCapacity(String name) {
        Capacity capacity = capacityDAO.findCapacityByName(name);
        if (capacity != null) {
            return false;
        }
        capacityDAO.insertCapacity(name);
        return true;
    }

    public Capacity findCapacityById(int idCapacityEdit) {
        return capacityDAO.findCapacityById(idCapacityEdit);
    }

    public boolean alertCapacity(int idCapacity, String nameCapacity) {
        return capacityDAO.alertCapacity(idCapacity, nameCapacity);
    }

    public boolean deleteCapacity(int id) {
        List<Integer> productVariantIDs = productVariantService.findProductVariantByCapacityId(id);
        try {
            productVariantIDs.forEach(productVariantID -> {
                productVariantService.deleteProductVariant(productVariantID);
            });
        } catch (Exception e) {
            return false;
        }
        return capacityDAO.deleteCapacity(id);
    }

    public int findCapacityByName(String name) {
        Capacity capacity = capacityDAO.findCapacityByName(name);
        if (capacity != null) {
            return 1;
        }
        return 0;
    }
}
