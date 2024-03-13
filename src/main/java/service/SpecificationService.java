package service;

import dao.SpecificationDAO;
import model.Specification;

import javax.inject.Inject;
import java.util.List;

public class SpecificationService {

    @Inject
    private SpecificationDAO specificationDAO;

    public Integer addSpecification(Specification specification) {
        return specificationDAO.addSpecification(specification);
    }

    public int findSpecificationIdBySpecification(Specification specification) {
        return specificationDAO.findSpecificationIdBySpecification(specification);
    }

    public String update(Specification specification) {
        String status = null;
        try {
            int rowUpdate = specificationDAO.update(specification);
            if(rowUpdate == 0)
                status = "FAIL";
            else
                status = "OK";
        }catch (Exception e){
            status = "ERROR";
            e.printStackTrace();
        }
        return status;
    }
}
