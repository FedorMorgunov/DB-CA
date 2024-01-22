-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Event table
CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255),
    EventDate DATE,
    Venue VARCHAR(255),
    Description TEXT,
    InitialTotalNumberOfTickets INT
);

-- Create TicketType table
CREATE TABLE TicketType (
    TicketTypeID INT PRIMARY KEY,
    EventID INT,
    TypeName VARCHAR(255),
    Price DECIMAL(10, 2),
    QuantityAvailable INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create Booking table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    BookingReferenceCode VARCHAR(255),
    CustomerID INT,
    EventID INT,
    BookingDate DATE,
    TotalAmount DECIMAL(10, 2),
    PaymentStatus VARCHAR(50),
    IsCancelled BOOLEAN,
    CancellationDate DATE,
    CollectionWay VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create BookingDetail table
CREATE TABLE BookingDetail (
    BookingDetailID INT PRIMARY KEY,
    BookingID INT,
    TicketTypeID INT,
    Quantity INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (TicketTypeID) REFERENCES TicketType(TicketTypeID)
);

-- Create Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    CardType VARCHAR(50),
    CardNumber VARCHAR(20),
    SecurityCode VARCHAR(10),
    ExpiryDate DATE,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- Create VoucherCode table
CREATE TABLE VoucherCode (
    Code VARCHAR(255) PRIMARY KEY,
    EventID INT,
    DiscountPercentage DECIMAL(5, 2),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Create Applies table
CREATE TABLE Applies (
    BookingID INT,
    Code VARCHAR(255),
    PRIMARY KEY (BookingID, Code),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (Code) REFERENCES VoucherCode(Code)
);

-- Insert sample data
-- Insert data into Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES
    (1, 'Joe', 'Smith', 'joe.smith@example.com', '1234567890', '123 Main St'),
    (2, 'Alex', 'Mead', 'alex.mead@example.com', '9876543210', '456 Oak St');

-- Insert data into Event table
INSERT INTO Event (EventID, EventName, EventDate, Venue, Description, InitialTotalNumberOfTickets)
VALUES
    (1, 'Exeter Food Festival 2023', '2023-08-15', 'Exeter Park', 'Food festival in Exeter', 800),
    (2, 'Exmouth Music Festival 2023', '2023-09-20', 'Exmouth Arena', 'Music festival in Exmouth', 600),
    (3, 'Exeter Event 1', '2023-07-02', 'Exeter', 'Description 1', 200),
    (4, 'Exeter Event 2', '2023-07-05', 'Exeter', 'Description 2', 150),
    (5, 'Exeter Event 3', '2023-07-08', 'Exeter', 'Description 3', 180);

-- Insert data into TicketType table
INSERT INTO TicketType (TicketTypeID, EventID, TypeName, Price, QuantityAvailable)
VALUES
    (1, 1, 'Adult', 20.00, 500),
    (2, 1, 'Child', 10.00, 300),
    (3, 2, 'Gold', 50.00, 200),
    (4, 2, 'Silver', 30.00, 300),
    (5, 2, 'Bronze', 20.00, 100);

-- Insert data into Booking table
INSERT INTO Booking (BookingID, BookingReferenceCode, CustomerID, EventID, BookingDate, TotalAmount, PaymentStatus, IsCancelled, CancellationDate, CollectionWay)
VALUES
    (1, 'ABC123', 1, 1, '2023-08-01', 50.00, 'Paid', 0, NULL, 'In-person'),
    (2, 'XYZ456', 2, 2, '2023-09-01', 100.00, 'Paid', 0, NULL, 'Electronic');

-- Insert data into BookingDetail table
INSERT INTO BookingDetail (BookingDetailID, BookingID, TicketTypeID, Quantity)
VALUES
    (1, 1, 1, 2),
    (2, 1, 2, 3),
    (3, 2, 3, 1),
    (4, 2, 4, 2),
    (5, 2, 5, 1);

-- Insert data into Payment table
INSERT INTO Payment (PaymentID, BookingID, CardType, CardNumber, SecurityCode, ExpiryDate, PaymentStatus)
VALUES
    (1, 1, 'Visa', '1234-5678-9012-3456', '123', '2023-09-01', 'Paid'),
    (2, 2, 'MasterCard', '9876-5432-1098-7654', '456', '2023-09-02', 'Paid');

-- Insert data into VoucherCode table
INSERT INTO VoucherCode (Code, EventID, DiscountPercentage)
VALUES
    ('VOUCHER50', 1, 10.00),
    ('VOUCHER25', 2, 5.00),
    ('FOOD10', 1, 10.00);