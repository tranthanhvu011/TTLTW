package controller.admin;

import config.URLConfig;
import controller.enums.LogLevel;
import dao.DiscountProductDAO;
import dao.LogDAO;
import helper.UploadHelper;
import model.*;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/product/add_product"})
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,
        fileSizeThreshold = 1024 * 1024,
        maxRequestSize = 1024 * 1024 * 100
)
public class AddProductController extends HttpServlet {

    @Inject
    private CapacityService capacityService;
    @Inject
    private ColorService colorService;
    @Inject
    private DiscountService discountService;
    @Inject
    private ManufacturerService manufacturerService;
    @Inject
    private SpecificationService specificationService;
    @Inject
    private WarrantyService warrantyService;
    @Inject
    private ProductService productService;
    @Inject
    private DiscountProductDAO discountProductDAO;
    @Inject
    private ProductVariantService productVariantService;
    @Inject
    private ProductImageService productImageService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String ip = request.getRemoteAddr();
        Account account = (Account) request.getSession().getAttribute("account");
        if (action != null) {
            switch (action) {
                case "addParentProduct":
                    String name = request.getParameter("tensp-text");
                    String description = request.getParameter("description");
//                    String thumbnail = request.getParameter("productAvatar");
                    String manufacturerId = request.getParameter("manufacturer");
                    String warrantyId = request.getParameter("warranty");
                    String discountId = request.getParameter("discount");
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
                    String fileName = UploadHelper.uploadFile(request, filePart, URLConfig.URL_SAVE_THUMBALL);
                    if (fileName != null) {
                        System.out.println(fileName);
                    }
                    Specification specification = setSpecification(bluetooth, bcamare, acamare, battery, memory, chipset, cpu, dimensions, screen_type, charging_port, ram, rom, sim);
                    Integer idSpecification = specificationService.addSpecification(specification);
                    if (idSpecification != null) {
                        ProductDB productDB = new ProductDB();
                        productDB.setName(name);
                        productDB.setDescription(description);
                        productDB.setThumbnail_url(fileName);
                        productDB.setManufacturer_id(Integer.parseInt(manufacturerId));
                        productDB.setInfo_warranty_id(Integer.parseInt(warrantyId));
                        productDB.setSell_quantity(Integer.parseInt(sell_quantity));
                        productDB.setRemaning_quantity(Integer.parseInt(remain_quantity));
                        productDB.setSpecification_id(idSpecification);
                        productDB.setPrice(Integer.parseInt(price));
                        Integer idProduct = productService.addProduct(productDB);
                        if (idProduct != null && discountId != null) {
                            discountProductDAO.insert(idProduct, Integer.parseInt(discountId));
                            mapDataToRequest(request);
                            Product product = productService.findDetailProductById(idProduct);
                            request.getSession().setAttribute("status", true);
                            request.getSession().setAttribute("message", "Thêm sản phẩm thành công");
                            request.getSession().setAttribute("product", product);
                            request.getRequestDispatcher("/viewAdmin/add_product.jsp").forward(request, response);
                            LogDAO logDAO = new LogDAO();
                            logDAO.insertLog(account.getId(),ip, LogLevel.WARNING.toString(),"null",product.toString(),"Thêm sản phẩm");
                        } else {
                            request.getSession().setAttribute("status", false);
                            request.getSession().setAttribute("message", "Không thể thêm sản phẩm");
                            response.sendRedirect(request.getContextPath() + "/admin/product/add_product");
                        }
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không thể tìm thấy thông tin thông số kĩ thuật");
                        response.sendRedirect(request.getContextPath() + "/admin/product/add_product");
                    }
                    break;
                case "addChildProduct":
                    List<String> images = new ArrayList<>();
                    String colorId = request.getParameter("color");
                    String capacityId = request.getParameter("capacityId");
                    String priceVariant = request.getParameter("priceVariant");
                    List<Part> parts = new ArrayList<>(request.getParts());
                    for (Part part : parts) {
                        if (part.getSubmittedFileName() != null) {
                            String image = UploadHelper.uploadFile(request, part,URLConfig.URL_SAVE_IMAGE);
                            if (image != null) images.add(image);
                        }
                    }
                    String state = request.getParameter("state");
                    int idProduct = Integer.parseInt(request.getParameter("productId"));
                    ProductVariantDB productVariantDB = new ProductVariantDB();
                    productVariantDB.setProduct_id(idProduct);
                    productVariantDB.setPrice(Double.parseDouble(priceVariant));
                    productVariantDB.setCapacity_id(Integer.parseInt(capacityId));
                    productVariantDB.setColor_id(Integer.parseInt(colorId));
                    productVariantDB.setState(Integer.parseInt(state));
                    Integer idProductVariant = productVariantService.addProductVariant(productVariantDB);
                    if (idProductVariant != null) {
                        int rowUpdate = productImageService.addImages(idProductVariant, images);
                        if (rowUpdate > 0) {
                            List<ProductVariant> productVariants = productVariantService.getAllProductVariantByIdProduct(idProduct);
                            if (productVariants != null)
                                request.setAttribute("products", productVariants);
                            request.getSession().setAttribute("status", true);
                            request.getSession().setAttribute("message", "Thêm chi tiết sản phẩm thành công");
                            mapDataToRequest(request);
                            request.getRequestDispatcher("/viewAdmin/add_product.jsp").forward(request, response);
                        }
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thông thể thêm chi tiết sản phẩm");
                        response.sendRedirect(request.getContextPath() + "/admin/product/add_product");
                    }
                    break;
            }
        } else {
            mapDataToRequest(request);
            request.getRequestDispatcher("/viewAdmin/add_product.jsp").forward(request, response);
        }
    }

    public static Specification setSpecification(String bluetooth, String bcamera, String acamera, String battery, String memory, String chipset, String cpu, String dimensions, String screen_type, String charging_port, String ram, String rom, String sim) {
        Specification specification = new Specification();
        specification.setBluetooth(bluetooth);
        specification.setCamera_after(acamera);
        specification.setCamera_before(bcamera);
        specification.setBattery_capacity(battery);
        specification.setCart_slot(memory);
        specification.setChip_set(chipset);
        specification.setCpu_speed(cpu);
        specification.setDimensions(dimensions);
        specification.setDisplay_type(screen_type);
        specification.setPort_sac(charging_port);
        specification.setRam(ram);
        specification.setRom(rom);
        specification.setThe_sim(sim);
        return specification;
    }


    public void mapDataToRequest(HttpServletRequest request) {
        request.setAttribute("capacities", capacityService.getAllCapacities());
        request.setAttribute("colors", colorService.getAllColors());
        request.setAttribute("discounts", discountService.getAllDiscount());
        request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
        request.setAttribute("warranties", warrantyService.getAllWarranty());
    }
}
