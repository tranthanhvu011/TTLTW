package controller.admin;

import config.URLConfig;
import helper.FileHelper;
import helper.UploadHelper;
import model.Product;
import model.ProductVariant;
import model.Specification;
import modelDB.ProductDB;
import modelDB.ProductVariantDB;
import service.*;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/product/edit_product"})
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,
        fileSizeThreshold = 1024 * 1024,
        maxRequestSize = 1024 * 1024 * 100
)
public class EditProductController extends HttpServlet {

    @Inject
    private ProductService productService;
    @Inject
    private ProductVariantService productVariantService;
    @Inject
    private CapacityService capacityService;
    @Inject
    private ColorService colorService;
    @Inject
    private DiscountService discountService;
    @Inject
    private ManufacturerService manufacturerService;
    @Inject
    private WarrantyService warrantyService;
    @Inject
    private SpecificationService specificationService;
    @Inject
    private DiscountProductService discountProductService;
    private Integer idProduct;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        idProduct = Integer.parseInt(request.getParameter("id"));
        System.out.println(idProduct);
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Product product = productService.findDetailProductById(idProduct);
        List<ProductVariant> productVariants = productVariantService.getAllProductVariantByIdProduct(idProduct);
        if (action != null) {
            switch (action) {
                case "editParentProduct":
                    String name = request.getParameter("tensp-text");
                    String description = request.getParameter("description");
                    String manufacturerId = request.getParameter("manufacturer");
                    String warrantyId = request.getParameter("warranty");
                    int discountId = Integer.parseInt(request.getParameter("idDisCount"));
                    String sell_quantity = request.getParameter("sell_quantity");
                    String remain_quantity = request.getParameter("remain_quantity");
                    String price = request.getParameter("price");
                    String bluetooth = request.getParameter("bluetooth");
                    String bcamare = request.getParameter("bcamera");
                    String acamare = request.getParameter("acamera");
                    String battery = request.getParameter("battery");
                    String memory = request.getParameter("memory");
                    String chipset = request.getParameter("chipset");
                    String cpu = request.getParameter("cpu_speed");
                    String dimensions = request.getParameter("dimensions");
                    String screen_type = request.getParameter("screen_type");
                    String charging_port = request.getParameter("charging_port");
                    String ram = request.getParameter("ram");
                    String rom = request.getParameter("rom");
                    String sim = request.getParameter("sim");
                    Part filePart = request.getPart("productAvatar");
                    if (discountId != 0) {
                        discountProductService.insert(idProduct, discountId);
                    }
                    ProductDB productDB = ProductDB.mapDataToObject(idProduct, name, Integer.parseInt(manufacturerId)
                            , Integer.parseInt(sell_quantity), Integer.parseInt(remain_quantity),
                            Double.parseDouble(price), description,
                            Integer.parseInt(warrantyId));
                    Specification specification = AddProductController.setSpecification(bluetooth, bcamare
                            , acamare, battery, memory, chipset, cpu, dimensions, screen_type, charging_port, ram, rom, sim);
                    specification.setId(product.getSpecification().getId());
                    String isSuccessInsertSpe = specificationService.update(specification);
                    System.out.println(isSuccessInsertSpe);
                    if (!filePart.getSubmittedFileName().equals(product.getThumbnailURL())) {
                        FileHelper.removeFile(product.getThumbnailURL());
                        String fileName = UploadHelper.uploadFile(request, filePart, URLConfig.URL_SAVE_THUMBALL);
                        productDB.setThumbnail_url(fileName);
                    }
                    String isSuccess = productService.updateProduct(productDB);
                    System.out.println(isSuccess);
                    if (isSuccess.equals("OK")) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thay đổi thông tin thành công");
                        response.sendRedirect(request.getContextPath() + "/admin/product/edit_product?id=" + idProduct);
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thay đổi thông tin thất bại ");
                        response.sendRedirect(request.getContextPath() + "/admin/product/edit_product?id=" + idProduct);
                    }
                    break;
                case "editSubProduct":
                    int idProductVariant = Integer.parseInt(request.getParameter("idProductVariant"));
                    int color = Integer.parseInt(request.getParameter("color"));
                    int capacity = Integer.parseInt(request.getParameter("capacityId"));
                    double priceVariant = Double.parseDouble(request.getParameter("priceVariant"));
                    Part image = request.getPart("productPictures");
                    int state = Integer.parseInt(request.getParameter("state"));
                    ProductVariantDB productVariantDB = new ProductVariantDB();
                    productVariantDB.setId(idProductVariant);
                    productVariantDB.setProduct_id(idProduct);
                    productVariantDB.setPrice(priceVariant);
                    productVariantDB.setState(state);
                    productVariantDB.setColor_id(color);
                    productVariantDB.setCapacity_id(capacity);

                    boolean isUpdate = productVariantService.update(productVariantDB) > 0;
                    if (isUpdate) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thay dổi thông tin chi tiết sản phẩm thành công");
                        response.sendRedirect(request.getContextPath() + "/admin/product/edit_product?id=" + idProduct);
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thay dổi thông tin chi tiết sản phẩm thất bại");
                        request.getRequestDispatcher("/viewAdmin/edit_product.jsp").forward(request, response);
                    }
                    break;
            }
        } else {
            mapDataToRequest(request);
            request.setAttribute("product", product);
            request.setAttribute("productVariants", productVariants);
            request.getRequestDispatcher("/viewAdmin/edit_product.jsp").forward(request, response);
        }
    }

    public void mapDataToRequest(HttpServletRequest request) {
        request.setAttribute("capacities", capacityService.getAllCapacities());
        request.setAttribute("colors", colorService.getAllColors());
        request.setAttribute("discounts", discountService.getDiscountNotInProduct(idProduct));
        request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
        request.setAttribute("warranties", warrantyService.getAllWarranty());
    }
}
