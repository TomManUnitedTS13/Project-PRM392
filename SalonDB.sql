
-- Tạo bảng Customers (Khách hàng)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(15) NOT NULL UNIQUE,
    email NVARCHAR(100) UNIQUE,
    member_rank INT,  -- Liên kết đến bảng MembershipProgram
    points INT DEFAULT 0,
    registration_date DATE DEFAULT GETDATE(),
    birthday DATE,
    address NVARCHAR(255)
);

-- Tạo bảng MembershipProgram (Chương trình hạng thành viên)
CREATE TABLE MembershipProgram (
    rank_id INT PRIMARY KEY IDENTITY(1,1),
    rank_name NVARCHAR(50) NOT NULL,  -- Ví dụ: Bronze, Silver, Gold
    required_points INT NOT NULL,     -- Số điểm yêu cầu để đạt hạng
    discount_rate DECIMAL(5, 2) NOT NULL -- Tỷ lệ giảm giá (Ví dụ: 10 = 10%)
);

-- Tạo bảng ServicePackages (Các gói dịch vụ)
CREATE TABLE ServicePackages (
    package_id INT PRIMARY KEY IDENTITY(1,1),
    package_name NVARCHAR(100) NOT NULL,  -- Ví dụ: Cắt tóc, uốn tóc, nhuộm tóc
    description NVARCHAR(255),
    price DECIMAL(10, 2) NOT NULL        -- Giá gói dịch vụ
);

-- Tạo bảng Promotions (Khuyến mãi)
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY IDENTITY(1,1),
    promotion_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    discount_amount DECIMAL(10, 2),      -- Số tiền hoặc phần trăm giảm giá
    start_date DATE,
    end_date DATE
);

-- Tạo bảng Stylists (Stylist)
CREATE TABLE Stylists (
    stylist_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    experience INT NOT NULL,            -- Số năm kinh nghiệm
    specialization NVARCHAR(255),       -- Chuyên môn (Ví dụ: cắt tóc nam, nữ)
    rating DECIMAL(3, 2)                -- Đánh giá (Ví dụ: 4.5)
);

-- Tạo bảng Appointments (Lịch hẹn)
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    stylist_id INT FOREIGN KEY REFERENCES Stylists(stylist_id),
    package_id INT FOREIGN KEY REFERENCES ServicePackages(package_id),
    appointment_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    total_price DECIMAL(10, 2) NOT NULL,
    promotion_id INT FOREIGN KEY REFERENCES Promotions(promotion_id),
    status NVARCHAR(50)                 -- Ví dụ: Đã hoàn thành, Đã hủy
);

-- Tạo bảng ServiceHistory (Lịch sử dịch vụ)
CREATE TABLE ServiceHistory (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    appointment_id INT FOREIGN KEY REFERENCES Appointments(appointment_id),
    service_date DATE NOT NULL,
    feedback NVARCHAR(255),
    rating DECIMAL(3, 2)
);

-- Tạo bảng MembershipPoints (Điểm hạng thành viên)
CREATE TABLE MembershipPoints (
    transaction_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    points_earned INT NOT NULL,         -- Số điểm tích lũy
    points_used INT NOT NULL,           -- Số điểm đã sử dụng
    transaction_date DATE DEFAULT GETDATE()
);

-- Tạo bảng Payment (Thanh toán)
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    appointment_id INT FOREIGN KEY REFERENCES Appointments(appointment_id),
    amount DECIMAL(10, 2) NOT NULL,     -- Số tiền thanh toán
    payment_method NVARCHAR(50),        -- Ví dụ: Tiền mặt, thẻ, ví điện tử
    payment_date DATE DEFAULT GETDATE()
);

-- Tạo bảng Feedback (Phản hồi)
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    stylist_id INT FOREIGN KEY REFERENCES Stylists(stylist_id),
    comments NVARCHAR(255),
    rating DECIMAL(3, 2),               -- Đánh giá từ khách hàng
    feedback_date DATE DEFAULT GETDATE()
);

-- Tạo bảng Schedule (Lịch làm việc của stylist)
CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY IDENTITY(1,1),
    stylist_id INT FOREIGN KEY REFERENCES Stylists(stylist_id),
    work_day NVARCHAR(50),              -- Ngày làm việc (Ví dụ: Thứ 2, Thứ 3)
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- Thiết lập liên kết giữa bảng Customers và MembershipProgram
ALTER TABLE Customers
ADD CONSTRAINT FK_Customers_MembershipProgram
FOREIGN KEY (member_rank) REFERENCES MembershipProgram(rank_id);
