-- List information about Exeter Food Festival 2023 and ticket details
SELECT
    e.EventName,
    e.Venue,
    e.EventDate AS StartDate,
    DATE_ADD(e.EventDate, INTERVAL e.InitialTotalNumberOfTickets DAY) AS EndDate,
    SUM(CASE WHEN tt.TypeName = 'Adult' THEN tt.QuantityAvailable ELSE 0 END) AS AdultTickets,
    SUM(CASE WHEN tt.TypeName = 'Child' THEN tt.QuantityAvailable ELSE 0 END) AS ChildTickets
FROM
    Event e
JOIN TicketType tt ON e.EventID = tt.EventID
WHERE
    e.EventName = 'Exeter Food Festival 2023'
GROUP BY
    e.EventID;

-- 2) List events in Exeter from 1 July, 2023, to 10 July, 2023
SELECT
    EventName,
    EventDate AS StartDate,
    DATE_ADD(EventDate, INTERVAL InitialTotalNumberOfTickets DAY) AS EndDate,
    Description
FROM
    Event
WHERE
    Venue = 'Exeter'
    AND EventDate BETWEEN '2023-07-01' AND '2023-07-10';

-- 3) List available amount and price for Bronze tickets for Exmouth Music Festival 2023
SELECT
    TypeName,
    QuantityAvailable AS AvailableAmount,
    Price
FROM
    TicketType
WHERE
    EventID = (SELECT EventID FROM Event WHERE EventName = 'Exmouth Music Festival 2023')
    AND TypeName = 'Bronze';

-- 4) List customer names and the number of Gold tickets booked for Exmouth Music Festival 2023
SELECT
    c.FirstName,
    c.LastName,
    COUNT(*) AS GoldTicketsBooked
FROM
    Customer c
JOIN Booking b ON c.CustomerID = b.CustomerID
JOIN BookingDetail bd ON b.BookingID = bd.BookingID
JOIN TicketType tt ON bd.TicketTypeID = tt.TicketTypeID
WHERE
    tt.TypeName = 'Gold'
    AND tt.EventID = (SELECT EventID FROM Event WHERE EventName = 'Exmouth Music Festival 2023')
GROUP BY
    c.CustomerID;

-- 5) List event names and the number of sold-out tickets in descending order
SELECT
    e.EventName,
    COALESCE(SUM(bd.Quantity), 0) AS TotalSoldTickets
FROM
    Event e
LEFT JOIN Booking b ON e.EventID = b.EventID
LEFT JOIN BookingDetail bd ON b.BookingID = bd.BookingID
GROUP BY
    e.EventID, e.EventName
ORDER BY
    TotalSoldTickets DESC;

-- 6) List relevant information for each booking
SELECT
    b.BookingID,
    c.FirstName,
    c.LastName,
    b.BookingDate,
    e.EventName,
    bd.Quantity AS NumTickets,
    tt.TypeName AS TicketType,
    b.TotalAmount,
    b.CollectionWay
FROM
    Booking b
JOIN Customer c ON b.CustomerID = c.CustomerID
JOIN Event e ON b.EventID = e.EventID
JOIN BookingDetail bd ON b.BookingID = bd.BookingID
JOIN TicketType tt ON bd.TicketTypeID = tt.TicketTypeID;

-- 7) Find the event with the maximum income
SELECT
    e.EventName,
    SUM(b.TotalAmount) AS TotalIncome
FROM
    Event e
JOIN Booking b ON e.EventID = b.EventID
GROUP BY
    e.EventID
ORDER BY
    TotalIncome DESC
LIMIT 1;