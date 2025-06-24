CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY NOT NULL,
    Hotel_Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(255) NOT NULL,
);

CREATE TABLE RoomType (
    TypeID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) UNIQUE NOT NULL,
    PricePerNightPerPerson DECIMAL(10, 2) NOT NULL,
    Capacity INT Check(Capacity>0) NOT NULL,
);
CREATE TABLE Room (
    RoomNo INT PRIMARY KEY NOT NULL,
    R_Hotel_ID INT NOT NULL,
    R_TypeID INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (R_Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (R_TypeID) REFERENCES RoomType(TypeID)
);
CREATE TABLE Customer (
    Cust_ID VARCHAR(50) PRIMARY KEY NOT NULL,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    Bdate DATE,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Sex CHAR(1) CHECK (Sex IN ('M', 'F')) NOT NULL
);
CREATE TABLE Booking (
    BookingID VARCHAR(50) PRIMARY KEY NOT NULL,
    Bk_Cust_ID VARCHAR(50) NOT NULL,
    Bk_RoomNo INT NOT NULL,
    CheckinDate DATE NOT NULL,
    CheckoutDate DATE NOT NULL,
    TotalPrice DECIMAL(10, 2) Check(TotalPrice>0) NOT NULL,
    FOREIGN KEY (Bk_Cust_ID) REFERENCES Customer(Cust_ID),
    FOREIGN KEY (Bk_RoomNo) REFERENCES Room(RoomNo)
);

CREATE TABLE Payment (
    PaymentID VARCHAR(50) PRIMARY KEY NOT NULL,
    Pay_BookingID VARCHAR(50) NOT NULL,
    Payment_Amount DECIMAL(10, 2) Check(Payment_Amount>0) NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Method VARCHAR(50) NOT NULL,
    FOREIGN KEY (Pay_BookingID) REFERENCES Booking(BookingID)
);
Create Table Employee (
    Emp_ID VARCHAR(50) PRIMARY KEY NOT NULL,
	E_Hotel_ID INT NOT NULL,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    BDate DATE NOT NULL,
	Sex char(1) Check(Sex IN ('M', 'F')) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
	Role  VARCHAR(20) NOT NULL,
	Work_Hours VARCHAR(20) NOT NULL,
	Salary Decimal(10,2) Check (Salary>0) NOT NULL,
	FOREIGN KEY (E_Hotel_ID) References Hotel(Hotel_ID)

);