USE LittleLemonDB;

#  Recreating Bookings table
DROP TABLE IF EXISTS Bookings;
CREATE TABLE Bookings
(
    BookingID   INT UNSIGNED AUTO_INCREMENT,
    BookingDate DATE         NOT NULL DEFAULT (CURRENT_DATE()),
    TableNumber INT UNSIGNED NOT NULL CHECK ( TableNumber != 0 ),
    CustomerID  INT UNSIGNED NOT NULL CHECK ( CustomerID != 0 ),
    PRIMARY KEY (BookingID)
);

# Populating Bookings table
INSERT INTO Bookings(BookingDate, TableNumber, CustomerID)
VALUES ("2022-10-10", 5, 1),
       ("2022-11-12", 3, 3),
       ("2022-10-11", 2, 2),
       ("2022-10-13", 2, 1);

DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(bookingID INT UNSIGNED,
                            customerID INT UNSIGNED,
                            tableNumber INT UNSIGNED,
                            bookingDate DATE)
BEGIN
    INSERT INTO Bookings(BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (bookingID, customerID, bookingDate, tableNumber);
    SELECT "New booking added" as Confirmation;
END;
//
DELIMITER ;


CALL AddBooking(9, 3, 4, "2022-12-30");



DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(bookingID INT UNSIGNED,
                               bookingDate DATE)
BEGIN
    UPDATE Bookings
    SET Bookings.BookingDate = bookingDate
    WHERE Bookings.BookingID = bookingID;
    SELECT CONCAT("Booking ", bookingID, " updated") as Confirmation;
END;
//
DELIMITER ;

CALL UpdateBooking(9, "2022-12-17");

DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(bookingID INT UNSIGNED)
BEGIN
    DELETE
    FROM Bookings
    WHERE Bookings.BookingID = bookingID;
    SELECT CONCAT("Booking ", bookingID, " cancelled") as Confirmation;
END;
//
DELIMITER ;

CALL CancelBooking(9);
