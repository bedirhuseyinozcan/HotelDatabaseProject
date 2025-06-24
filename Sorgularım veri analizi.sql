SELECT COUNT(DISTINCT Booking.Bk_Cust_ID) AS TotalCustomers,
       AVG(Booking.TotalPrice) AS AveragePrice
FROM Booking;


SELECT COUNT(*) AS TotalEmployees, AVG(Salary) AS AverageSalary
FROM Employee;


SELECT Hotel.Hotel_Name, Room.RoomNo
FROM Hotel
JOIN Room ON Hotel.Hotel_ID = Room.R_Hotel_ID
WHERE Room.Status = 'Occupied';



SELECT BookingID AS ID, Bk_Cust_ID AS CustomerID, BK_RoomNo AS RoomNo, CheckinDate AS Date, TotalPrice AS Amount
FROM Booking
UNION
SELECT PaymentID AS ID, Pay_BookingID AS CustomerID, NULL AS RoomNo, Payment_Date AS Date, Payment_Amount AS Amount
FROM Payment;


SELECT Payment.Payment_Method, SUM(Payment.Payment_Amount) AS TotalAmount
FROM Payment
GROUP BY Payment.Payment_Method
ORDER BY TotalAmount DESC;


SELECT Customer.Cust_ID, COUNT(Booking.BookingID) AS TotalBookings,
       AVG(Booking.TotalPrice) AS AverageSpending
FROM Customer
LEFT JOIN Booking ON Customer.Cust_ID = Booking.Bk_Cust_ID
GROUP BY Customer.Cust_ID
ORDER BY TotalBookings DESC;


SELECT MAX(SALARY),
MIN(SALARY), AVG(SALARY)
FROM EMPLOYEE


SELECT Hotel.Hotel_Name, COUNT(Booking.BookingID) AS TotalBookings,
       AVG(DATEDIFF(DAY, Booking.CheckinDate, Booking.CheckoutDate)) AS AverageStayDuration
FROM Hotel
LEFT JOIN Room ON Hotel.Hotel_ID = Room.R_Hotel_ID
LEFT JOIN Booking ON Room.RoomNo = Booking.Bk_RoomNo
WHERE Booking.BookingID IS NOT NULL
GROUP BY Hotel.Hotel_Name
ORDER BY TotalBookings DESC;


SELECT Hotel.Location, AVG(RoomType.Capacity) AS AverageCapacity,
       COUNT(Room.RoomNo) AS TotalRooms
FROM Hotel
LEFT JOIN Room ON Hotel.Hotel_ID = Room.R_Hotel_ID
LEFT JOIN RoomType ON Room.R_TypeID = RoomType.TypeID
GROUP BY Hotel.Location
ORDER BY AverageCapacity DESC, TotalRooms DESC;



SELECT Hotel.Hotel_Name, COUNT(Employee.Emp_ID) AS TotalEmployees,
       SUM(CASE WHEN Employee.Sex = 'M' THEN 1 ELSE 0 END) AS MaleEmployees,
       SUM(CASE WHEN Employee.Sex = 'F' THEN 1 ELSE 0 END) AS FemaleEmployees
FROM Hotel
LEFT JOIN Employee ON Hotel.Hotel_ID = Employee.E_Hotel_ID
GROUP BY Hotel.Hotel_Name
ORDER BY TotalEmployees DESC;


SELECT 
    Customer.Cust_ID, 
    Customer.FName, 
    Customer.LName,
    Booking.CheckinDate,
    Booking.TotalPrice,
    CASE 
        WHEN MONTH(Booking.CheckinDate) IN (6, 7, 8) THEN 'Summer Seoson'
        WHEN MONTH(Booking.CheckinDate) IN (12, 1, 2) THEN 'Winter Season'
        ELSE 'Other'
    END AS Season
FROM 
    Customer
JOIN 
    Booking ON Customer.Cust_ID = Booking.Bk_Cust_ID
ORDER BY 
    Booking.CheckinDate;