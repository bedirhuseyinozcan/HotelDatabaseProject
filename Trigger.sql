--1.trigger
CREATE TRIGGER EmployeeAgeCheck
ON Employee
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any of the newly inserted employees is under 18 years old
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATEDIFF(YEAR, BDate, GETDATE()) < 18
    )
    BEGIN
        PRINT 'Error: Employees must be at least 18 years old.';
        DELETE FROM Employee WHERE Emp_ID IN (SELECT Emp_ID FROM inserted);
    END
END;
INSERT INTO Employee (Emp_ID, E_Hotel_ID, FName, LName, BDate, Sex, Address, Phone, Email, Role,Work_Hours, Salary)
VALUES ('E001', 1, 'John', 'Doe', '2010-01-15', 'M', '123 Main St', '555-1234', 'john@example.com', 'Manager','07:00-15:00' ,50000.00);

--2.trigger
CREATE TRIGGER CheckRoomStatus
ON Room
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kontrolü yap
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Status NOT IN ('Available', 'Occupied')
    )
    BEGIN
        PRINT 'Error: Invalid room status. Status must be Available or Occupied.';
        DELETE FROM Room WHERE RoomNo IN (SELECT RoomNo FROM inserted);
    END
END;

INSERT INTO Room (RoomNo, R_Hotel_ID, R_TypeID, Status)
VALUES 
(120, 1, 1, 'InvalidStatus');
--3.trigger

CREATE TRIGGER CheckBookingDates
ON Booking
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Yeni eklenen rezervasyonlarýn tarihlerini kontrol et
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE CheckinDate >= CheckoutDate
    )
    BEGIN
        PRINT 'Error: Check-out date must be after check-in date.';
        DELETE FROM Booking WHERE BookingID IN (SELECT BookingID FROM inserted);
    END
END;

Insert Into Booking(BookingID,Bk_Cust_ID,BK_RoomNo,CheckinDate,CheckoutDate,TotalPrice)
   VALUES
   ('Book202', 'Cust200', 011, '2023-12-10', '2023-10-30', 8000);

--4.trigger
CREATE TRIGGER CustomerAgeCheck
ON Customer
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- 18 yaþýndan küçük müþteri var mý kontrol et
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATEDIFF(YEAR, Bdate, GETDATE()) < 18
    )
    BEGIN
        PRINT 'Error: Customers must be at least 18 years old.';
        DELETE FROM Customer WHERE Cust_ID IN (SELECT Cust_ID FROM inserted);
    END
END;


INSERT INTO Customer (Cust_ID, FName, LName, Bdate, Address, Phone, Email, Sex)
VALUES ('Cust201', 'Viyus', 'Andmrte', '2015-09-15', 'Oslo, Norway', '+47 55 123 416', 'viyus.andmerte@email.com', 'M');







