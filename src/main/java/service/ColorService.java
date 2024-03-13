package service;

import dao.ColorDAO;
import model.Color;

import javax.inject.Inject;
import java.util.List;

public class ColorService {

    @Inject
    private ColorDAO colorDAO;

    @Inject
    private ProductVariantService productVariantService;

    public List<Color> getAllColors() {
        return colorDAO.getAllColors();
    }

    public List<Color> findColorWithKeyWord(String keyword) {
        return colorDAO.findColorWithKeyWord(keyword);
    }

    public boolean insertColor(String name) {
        Color color = colorDAO.findColorByName(name);
        if (color != null) {
            return false;
        }
        return colorDAO.insertColor(name);
    }

    public Color findColorById(int idColorEdit) {
        return colorDAO.findColorById(idColorEdit);
    }

    public boolean editColor(int idColor, String nameColor) {
        return colorDAO.editColor(idColor, nameColor);
    }

    public boolean deleteColor(int id) {
        List<Integer> productVariantIDs = productVariantService.findProductVariantByColorId(id);
        try {
            if(!productVariantIDs.isEmpty()) {
                productVariantIDs.forEach(productVariantID -> {
                    productVariantService.deleteProductVariant(productVariantID);
                });
            }
        } catch (Exception e) {
            return false;
        }
        return colorDAO.deleteColor(id);
    }

    public int findColorByName(String name) {
        Color color = colorDAO.findColorByName(name);
        if (color != null) {
            return 1;
        }
        return 0;
    }
}
