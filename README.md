<p align="center">
  <img src="https://img.shields.io/badge/Java-16-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" alt="Java 16"/>
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Maven-3.x-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white" alt="Maven"/>
  <img src="https://img.shields.io/badge/Servlet-4.0-6DB33F?style=for-the-badge&logo=java&logoColor=white" alt="Servlet"/>
  <img src="https://img.shields.io/badge/JSP-2.0-007396?style=for-the-badge&logo=java&logoColor=white" alt="JSP"/>
  <img src="https://img.shields.io/badge/PayPal-Sandbox-00457C?style=for-the-badge&logo=paypal&logoColor=white" alt="PayPal"/>
  <img src="https://img.shields.io/badge/License-Academic-blue?style=for-the-badge" alt="License"/>
</p>

<h1 align="center">📱 TelephoneShop — Hệ Thống Thương Mại Điện Tử Điện Thoại</h1>

<p align="center">
  <strong>Đồ án môn học Thiết kế & Triển khai Phần mềm Web (TTLTW)</strong><br/>
  Web application thương mại điện tử full-stack cho cửa hàng điện thoại di động,<br/>
  được xây dựng trên nền tảng Java Servlet/JSP theo kiến trúc MVC 3 lớp.
</p>

---

## 📑 Mục Lục

- [Tổng Quan Dự Án](#-tổng-quan-dự-án)
- [Tính Năng Chính](#-tính-năng-chính)
- [Kiến Trúc Hệ Thống](#-kiến-trúc-hệ-thống)
- [Công Nghệ Sử Dụng](#-công-nghệ-sử-dụng)
- [Cấu Trúc Dự Án](#-cấu-trúc-dự-án)
- [Database Schema](#-database-schema)
- [Cài Đặt & Chạy](#-cài-đặt--chạy)
- [Tài Khoản Demo](#-tài-khoản-demo)
- [Bảo Mật](#-bảo-mật)
- [Đóng Góp](#-đóng-góp)

---

## 🎯 Tổng Quan Dự Án

**TelephoneShop** là hệ thống thương mại điện tử chuyên bán điện thoại di động, cung cấp đầy đủ các chức năng cho cả **người dùng cuối** (User) và **quản trị viên** (Admin/Manager). Hệ thống hỗ trợ:

- 🛒 **Mua sắm trực tuyến** — duyệt sản phẩm, giỏ hàng, thanh toán online qua PayPal
- 👤 **Quản lý tài khoản** — đăng ký, đăng nhập, Google OAuth, xác thực email OTP
- 📊 **Quản trị doanh nghiệp** — quản lý sản phẩm, đơn hàng, kho hàng, khuyến mãi, thống kê doanh thu
- 🌐 **Đa ngôn ngữ** — hỗ trợ Tiếng Việt và Tiếng Anh
- 🔒 **Bảo mật** — RBAC 3 cấp, BCrypt, IP rate limiting, audit logging

---

## ✨ Tính Năng Chính

### 🛍️ Dành cho Khách Hàng (User)

| Tính năng | Mô tả |
|:---|:---|
| **Trang chủ** | Hiển thị sản phẩm, bộ lọc theo hãng, giá, tìm kiếm autocomplete |
| **Chi tiết sản phẩm** | Thông số kỹ thuật, biến thể (màu sắc, dung lượng), hình ảnh, đánh giá, bảo hành |
| **Giỏ hàng** | Thêm/sửa/xóa sản phẩm, áp dụng mã giảm giá |
| **Thanh toán** | Hỗ trợ PayPal Sandbox, nhập thông tin giao hàng (Tỉnh/Huyện/Xã) |
| **Quản lý đơn hàng** | Theo dõi trạng thái đơn hàng, hủy đơn |
| **Tài khoản** | Đăng ký/Đăng nhập, đổi mật khẩu, cập nhật profile |
| **Quên mật khẩu** | Reset password qua OTP email |
| **Google Login** | Đăng nhập bằng tài khoản Google OAuth2 |
| **Tin tức** | Đọc tin tức, khuyến mãi |
| **Liên hệ** | Gửi phản hồi, yêu cầu hỗ trợ |

### 🛠️ Dành cho Quản Trị Viên (Admin/Manager)

| Tính năng | Mô tả |
|:---|:---|
| **Dashboard thống kê** | Biểu đồ doanh thu, số lượng bán, lọc theo khoảng thời gian |
| **Quản lý sản phẩm** | CRUD sản phẩm, biến thể, hình ảnh, thông số kỹ thuật |
| **Quản lý đơn hàng** | Cập nhật trạng thái (chuẩn bị → giao hàng → hoàn thành), tìm kiếm, lọc |
| **Quản lý người dùng** | CRUD users, khóa/mở tài khoản, phân quyền |
| **Quản lý kho** | Nhập hàng, quản lý phiếu nhập, kiểm kê |
| **Quản lý khuyến mãi** | CRUD mã giảm giá, gán discount cho sản phẩm, lịch trình theo ngày |
| **Quản lý danh mục** | Hãng sản xuất, màu sắc, dung lượng, bảo hành |
| **Quản lý chi nhánh** | Chi nhánh cửa hàng, sản phẩm theo chi nhánh |
| **Quản lý tin tức** | CRUD bài viết tin tức |
| **Quản lý bình luận** | Duyệt/xóa đánh giá sản phẩm |
| **Audit Log** | Ghi lại mọi thao tác quản trị (ai, what, when, IP) |

---

## 🏗️ Kiến Trúc Hệ Thống

```
┌─────────────────────────────────────────────────────────┐
│                      CLIENT (Browser)                   │
│         JSP Pages + JSTL + JavaScript + CSS             │
└───────────────────────┬─────────────────────────────────┘
                        │ HTTP Request/Response
┌───────────────────────▼─────────────────────────────────┐
│                  FILTER CHAIN                           │
│   EncodingFilter (UTF-8) → SecurityFilter (RBAC)       │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│              CONTROLLER LAYER (Servlets)                │
│   @WebServlet annotated HttpServlets                    │
│   auth/ │ user/ │ admin/ │ API/ │ paypal/ │ google/    │
└───────────────────────┬─────────────────────────────────┘
                        │ @Inject (CDI/Weld)
┌───────────────────────▼─────────────────────────────────┐
│              SERVICE LAYER (Business Logic)             │
│   UserService │ ProductService │ OrderService │ ...     │
│   Validation │ BCrypt │ Business Rules                  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│              DAO LAYER (Data Access Objects)            │
│   UserDAO │ ProductDAO │ OrderProductVariantDAO │ ...   │
│   JDBI 3 │ SQL Queries │ ResultSet Mapping              │
└───────────────────────┬─────────────────────────────────┘
                        │ JDBC / JDBI
┌───────────────────────▼─────────────────────────────────┐
│              DATABASE (MySQL 8.0 / MariaDB)             │
│   telephone_shop schema │ 20+ tables │ UTF8MB4          │
└─────────────────────────────────────────────────────────┘
```

### Design Patterns Áp Dụng

| Pattern | Ứng dụng |
|:---|:---|
| **MVC** | Controller (Servlet) → Service → DAO → JSP View |
| **Singleton** | `JDBIConnector.me()` — database connection |
| **DTO/VO** | `modelDB.*` (DB DTOs) ↔ `model.*` (Domain models) |
| **Filter Chain** | `SecurityFilter` + `EncodingFilter` via `web.xml` |
| **Dependency Injection** | CDI (`@Inject`) qua Weld Servlet container |
| **Repository** | DAO classes abstract hóa data access |

---

## 🔧 Công Nghệ Sử Dụng

### Backend

| Thành phần | Công nghệ | Phiên bản | Mô tả |
|:---|:---|:---|:---|
| **Ngôn ngữ** | Java | 16 | OpenJDK 16+ |
| **Build Tool** | Apache Maven | 3.x | Dependency management & WAR packaging |
| **Web Container** | Apache Tomcat | 9.x/10.x | Servlet Container |
| **Web Framework** | Java Servlet API | 4.0.1 | HTTP request handling |
| **View Engine** | JSP + JSTL | 2.0 / 1.2 | Server-side rendering |
| **Database Access** | JDBI 3 | 3.41.3 | Lightweight SQL abstraction |
| **Database** | MySQL | 8.0.33 | Relational database (InnoDB) |
| **DI Container** | Weld (CDI) | 3.1.9.Final | Dependency Injection |
| **Password Security** | jBCrypt | 0.4 | BCrypt password hashing |
| **JSON Processing** | Gson / Jackson / org.json | 2.10.1 / 2.15.2 | JSON serialization/deserialization |
| **Email** | JavaMail | 1.6.2 | SMTP email (Gmail) |
| **Payment** | PayPal REST SDK | 1.14.0 | Online payment (Sandbox) |
| **HTTP Client** | Apache HttpComponents | 4.5.13 | External API calls |
| **Code Generation** | Lombok | 1.18.30 | Boilerplate reduction |

### Frontend

| Thành phần | Công nghệ | Mô tả |
|:---|:---|:---|
| **Template** | JSP + JSTL + EL | Server-side HTML rendering |
| **Styling** | CSS3 + Bootstrap | Responsive design |
| **Scripting** | JavaScript (Vanilla) | Client-side interactions |
| **i18n** | Resource Bundle | `messages_vi.properties`, `messages_en.properties` |

### External Integrations

| Integration | Provider | Mô tả |
|:---|:---|:---|
| **Payment Gateway** | PayPal (Sandbox) | Thanh toán quốc tế |
| **OAuth2 Login** | Google | Đăng nhập bằng Google |
| **Email Service** | Gmail SMTP | Gửi OTP, thông báo |
| **Address Data** | JSON files | Tỉnh/Huyện/Xã Việt Nam |

---

## 📂 Cấu Trúc Dự Án

```
TelephoneShop/
│
├── pom.xml                          # Maven configuration
├── telephone.sql                    # Full database dump (schema + seed data)
├── README.md                        # Documentation (file này)
│
├── AI PROMPT/                       # AI-assisted development framework
│   ├── SYSTEM_PROMPT.MD             # AI Orchestrator — BA/DEV/TEST modes
│   ├── BA.MD                        # Business Analyst workflow (10 steps)
│   ├── DEV.md                       # Developer workflow (9 steps)
│   ├── TEST.md                      # QA/Security Auditor workflow (9 steps)
│   ├── PLAN.md                      # Master project checklist
│   ├── context.md                   # Project state tracking
│   └── task-queue.md                # Task backlog & status
│
└── src/main/
    ├── java/                        # Java source code
    │   ├── config/                  # ⚙️ Configuration
    │   │   ├── DBConnection.java    #    Database properties loader
    │   │   ├── JDBIConnector.java   #    JDBI singleton connector
    │   │   ├── SecurityConfig.java  #    RBAC URL-role mapping
    │   │   └── URLConfig.java       #    File upload paths
    │   │
    │   ├── filter/                  # 🔒 Servlet Filters
    │   │   ├── SecurityFilter.java  #    Auth & authorization enforcement
    │   │   └── EncodingFilter.java  #    UTF-8 encoding
    │   │
    │   ├── controller/              # 🎮 Controllers (65+ Servlets)
    │   │   ├── auth/                #    Login, Register, Reset Password (9)
    │   │   ├── user/                #    User-facing pages (22)
    │   │   ├── admin/               #    Admin management pages (31)
    │   │   ├── API/                 #    Province/District/Ward API (3)
    │   │   ├── google/              #    Google OAuth2
    │   │   └── paypal/              #    PayPal payment
    │   │
    │   ├── service/                 # 💼 Business Logic (19 classes)
    │   │   ├── UserService.java     #    Account management
    │   │   ├── ProductService.java  #    Product operations
    │   │   ├── EmailSender.java     #    SMTP email
    │   │   └── ...
    │   │
    │   ├── dao/                     # 🗄️ Data Access Objects (31 classes)
    │   │   ├── UserDAO.java         #    Account CRUD + auth queries
    │   │   ├── ProductDAO.java      #    Product queries
    │   │   ├── OrderProductVariantDAO.java  # Order management
    │   │   └── ...
    │   │
    │   ├── model/                   # 📦 Domain Models (31 classes)
    │   │   ├── Account.java         #    User account entity
    │   │   ├── Product.java         #    Product with relations
    │   │   ├── ProductVariant.java  #    Color/capacity variants
    │   │   ├── Order.java           #    Order header
    │   │   └── ...
    │   │
    │   ├── modelDB/                 # 📋 Database DTOs (5 classes)
    │   ├── helper/                  # 🛠️ Utilities (6 classes)
    │   ├── Utils/                   # ✅ Validation utilities
    │   └── exception/               # ⚠️ Custom exceptions
    │
    ├── resources/                   # Resource files
    │   ├── DB.properties            #    Database connection config
    │   ├── messages_vi.properties   #    Vietnamese translations
    │   └── messages_en.properties   #    English translations
    │
    └── webapp/                      # Web resources
        ├── index.jsp                #    Entry point → redirect /home
        ├── view/                    #    User JSP pages (21 pages)
        ├── viewAdmin/               #    Admin JSP pages (28 pages)
        ├── common/                  #    Shared JSP fragments
        ├── resources/               #    CSS, JS, Images
        ├── json/                    #    Province/District/Ward data
        └── WEB-INF/
            ├── web.xml              #    Servlet & filter config
            └── beans.xml            #    CDI configuration
```

---

## 🗄️ Database Schema

Database **`telephone_shop`** gồm **20+ bảng** chính:

```
┌──────────────────┐     ┌──────────────────┐     ┌──────────────────┐
│    accounts      │     │    products       │     │   manufacturers  │
│──────────────────│     │──────────────────│     │──────────────────│
│ id (PK)          │     │ id (PK)          │     │ id (PK)          │
│ email            │     │ name             │     │ name             │
│ password (BCrypt)│     │ manufacturer_id  │────▶│                  │
│ role             │     │ specification_id │     └──────────────────┘
│ is_active        │     │ info_warranty_id │
│ ban              │     │ price            │     ┌──────────────────┐
│ lastIPLogin      │     │ thumbnail_url    │     │  specifications  │
└────────┬─────────┘     │ description      │     │──────────────────│
         │               └────────┬─────────┘     │ screen, os, cpu  │
         │                        │               │ ram, rom, camera  │
    ┌────▼─────────┐     ┌────────▼─────────┐     └──────────────────┘
    │   orders     │     │ productvariants  │
    │──────────────│     │──────────────────│     ┌──────────────────┐
    │ id (PK)      │     │ id (PK)          │     │     colors       │
    │ account_id   │     │ product_id       │     │──────────────────│
    └────┬─────────┘     │ color_id ────────│────▶│ name             │
         │               │ capacity_id ─────│──┐  └──────────────────┘
    ┌────▼──────────────┐│ price            │  │
    │orderproductvariant││ name             │  │  ┌──────────────────┐
    │───────────────────│└──────────────────┘  └─▶│   capacities     │
    │ product_variant_id│                         │ name (64GB, etc) │
    │ order_id          │  ┌──────────────────┐   └──────────────────┘
    │ quantity          │  │  productimages   │
    │ transport_id      │  │──────────────────│
    │ total_price       │  │ product_variant_id│
    │ status (0-6)      │  │ image_url        │
    │ buy_at            │  └──────────────────┘
    └───────────────────┘
```

### Trạng Thái Đơn Hàng (`status`)

| Code | Trạng thái | Mô tả |
|:---|:---|:---|
| `0` | ❌ Đã hủy | Đơn hàng bị hủy |
| `1` | 📦 Đang chuẩn bị | Đang chuẩn bị hàng |
| `2` | 🚚 Đang giao | Đang vận chuyển |
| `3` | ✅ Đã nhận | Giao hàng thành công |
| `6` | 💰 Hoàn thành | Đã thanh toán (tính doanh thu) |

### Bảng Phụ Trợ

| Bảng | Mô tả |
|:---|:---|
| `discounts` | Chương trình khuyến mãi (code, giá trị, thời hạn) |
| `discountproduct` | Liên kết discount ↔ product (N:N) |
| `infotransports` | Thông tin vận chuyển (người nhận, địa chỉ, phí) |
| `infowarranties` | Thông tin bảo hành (thời gian, nơi BH, hình thức) |
| `rates` | Đánh giá sản phẩm (sao, bình luận) |
| `contacts` | Phản hồi từ khách hàng |
| `news` | Bài viết tin tức |
| `log` | Audit log (userID, action, beforeData, afterData, IP) |
| `logging_login` | Ghi nhật ký đăng nhập (IP, country, status) |
| `passwordresetcodes` | OTP codes cho reset/verify email |
| `chinhanh` / `chinhanhproduct` | Chi nhánh và hàng tồn kho theo chi nhánh |
| `khohang` / `inventory` | Quản lý kho hàng |

---

## 🚀 Cài Đặt & Chạy

### Yêu Cầu Hệ Thống

| Phần mềm | Phiên bản tối thiểu |
|:---|:---|
| **JDK** | 16+ |
| **Apache Maven** | 3.6+ |
| **Apache Tomcat** | 9.x hoặc 10.x |
| **MySQL** | 8.0+ (hoặc MariaDB 10.4+) |
| **IDE** (khuyến nghị) | IntelliJ IDEA Ultimate |

### Bước 1: Clone Repository

```bash
git clone <repository-url>
cd TelephoneShop
```

### Bước 2: Tạo Database

```bash
# Đăng nhập MySQL
mysql -u root -p

# Tạo database
CREATE DATABASE telephone_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# Import schema + seed data
USE telephone_shop;
SOURCE telephone.sql;
```

### Bước 3: Cấu Hình Database

Chỉnh sửa file `src/main/resources/DB.properties`:

```properties
db.host = localhost
db.port = 3306
db.username = root
db.password = your_password_here
db.name = telephone_shop
```

### Bước 4: Build & Deploy

```bash
# Build WAR file
mvn clean package

# Copy WAR vào Tomcat
cp target/TelephoneShop.war $CATALINA_HOME/webapps/
```

**Hoặc** chạy trực tiếp từ IntelliJ IDEA:
1. Mở project bằng IntelliJ IDEA
2. Cấu hình Tomcat Local Server
3. Add Artifact: `TelephoneShop:war exploded`
4. Run ▶️

### Bước 5: Truy Cập

```
🌐 User:  http://localhost:8080/home
🔧 Admin: http://localhost:8080/admin/revenue-statistics
```

---

## 👤 Tài Khoản Demo

| Role | Email | Password | Quyền hạn |
|:---|:---|:---|:---|
| **Admin** | `ngusidep@gmail.com` | *(BCrypt hash trong DB)* | Toàn quyền quản trị |
| **Manager** | `ngusidan123@gmail.com` | *(BCrypt hash trong DB)* | Quản lý sản phẩm, đơn hàng |
| **User** | `tranvu@gmail.com` | *(BCrypt hash trong DB)* | Mua hàng, quản lý tài khoản |

> **Lưu ý:** Tạo tài khoản mới qua trang `/register` để test đầy đủ flow.

---

## 🔒 Bảo Mật

| Tính năng | Triển khai |
|:---|:---|
| **Password Hashing** | BCrypt (`jBCrypt 0.4`) — salt tự động |
| **RBAC** | 3 roles (`admin`, `manage`, `user`) — URL-based access control |
| **Session Management** | `HttpSession` — lưu account object sau login |
| **Brute Force Protection** | IP-based rate limiting — 5 failed attempts → 30 phút ban |
| **Login Auditing** | Ghi nhận IP, quốc gia, trạng thái mỗi lần đăng nhập |
| **Email Verification** | OTP 6 chữ số có thời hạn gửi qua email |
| **Input Validation** | Regex validation cho email, phone, password ở server-side |
| **Encoding Filter** | UTF-8 enforcement trên toàn bộ request/response |
| **Audit Trail** | Bảng `log` ghi trước/sau dữ liệu cho mọi thao tác admin |

---

## 🌐 Đa Ngôn Ngữ (i18n)

Hệ thống hỗ trợ 2 ngôn ngữ qua **Resource Bundle**:

- 🇻🇳 `messages_vi.properties` — Tiếng Việt (mặc định)
- 🇬🇧 `messages_en.properties` — English

Chuyển đổi ngôn ngữ qua parameter: `?lang=vi` hoặc `?lang=en`

---

## 📊 Metrics

| Metric | Số lượng |
|:---|:---|
| **Java Classes** | ~100+ |
| **Servlet Controllers** | 65+ |
| **JSP Pages** | 49 (21 user + 28 admin) |
| **Database Tables** | 20+ |
| **Service Classes** | 19 |
| **DAO Classes** | 31 |
| **Domain Models** | 31 |

---

## 🤝 Đóng Góp

### Team Members

| STT | Họ và Tên | MSSV | Vai trò |
|:---|:---|:---|:---|
| 1 | Trần Thanh Vũ | 21130616 | Developer |

### Convention

- **Commit format**: `feat/fix/refactor(scope): description`
- **Branch naming**: `feature/task-name`, `bugfix/issue-name`
- **Code style**: Java conventions, UTF-8 encoding

---

## 📝 License

Dự án này được thực hiện phục vụ mục đích **học thuật** trong khuôn khổ môn học **Thiết kế & Triển khai Phần mềm Web** tại **Trường Đại học Nông Lâm TP.HCM **.

---

<p align="center">
  <sub>Built with ❤️ using Java Servlet + JSP + MySQL</sub>
</p>