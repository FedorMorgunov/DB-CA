-- 1) Increase the amount of Adult tickets for the Exeter Food Festival by 100
UPDATE TicketType
SET QuantityAvailable = QuantityAvailable + 100
WHERE EventID = (SELECT EventID FROM Event WHERE EventName = 'Exeter Food Festival 2023')
  AND TypeName = 'Adult';

-- 2) Ian Cooper's booking for the Exeter Food Festival
-- Insert data into Customer table for Ian Cooper
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber, Address)
VALUES
    (4, 'Ian', 'Cooper', 'ian.cooper@example.com', '5551234567', '789 Oak St');

-- Insert data into Booking table for Ian Cooper
INSERT INTO Booking (BookingID, BookingReferenceCode, CustomerID, EventID, BookingDate, TotalAmount, PaymentStatus, IsCancelled, CancellationDate, CollectionWay)
VALUES
    (3, 'IAN123', 4, 1, '2023-11-11', 0, 'Pending', 0, NULL, 'Email');

-- Insert data into BookingDetail table for Ian Cooper
INSERT INTO BookingDetail (BookingDetailID, BookingID, TicketTypeID, Quantity)
VALUES
    (6, 3, 1, 2),
    (7, 3, 2, 1);

-- Insert data into Payment table for Ian Cooper
INSERT INTO Payment (PaymentID, BookingID, CardType, CardNumber, SecurityCode, ExpiryDate, PaymentStatus)
VALUES
    (3, 3, 'Credit Card', '1111-2222-3333-4444', '123', '2023-11-12', 'Pending');

-- Insert data into Applies table for Ian Cooper's voucher code
INSERT INTO Applies (BookingID, Code)
VALUES
    (3, 'FOOD10');

-- 3) Joe Smith's cancellation for an unfulfilled booking
UPDATE Booking
SET IsCancelled = 1, CancellationDate = '2023-11-11'
WHERE BookingID = 1;

-- 4) Add one more voucher code for the Exmouth Music Festival 2023
-- Insert data into VoucherCode table
INSERT INTO VoucherCode (Code, EventID, DiscountPercentage)
VALUES
    ('SUMMER20', 2, 20.00);