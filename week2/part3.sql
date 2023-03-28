USE LittleLemonDB;

#  Recreating Bookings table
TRUNCATE TABLE Bookings;

# Populating Bookings table
INSERT INTO Bookings(BookingDate, TableNumber, CustomerID)
VALUES ("2022-10-10", 5, 1),
       ("2022-11-12", 3, 3),
       ("2022-10-11", 2, 2),
       ("2022-10-13", 2, 1);

# Showing records
SELECT *
FROM Bookings;

DROP PROCEDURE IF EXISTS CheckBooking;
CREATE PROCEDURE CheckBooking(bookingDate DATE, tableNumber INT UNSIGNED)
SELECT IF(EXISTS(SELECT TRUE FROM Bookings WHERE BookingDate = bookingDate AND TableNumber = tableNumber),
          CONCAT("Table ", tableNumber, " is already booked"),
          CONCAT("Table ", tableNumber, " is free")) AS "Booking status";

CALL CheckBooking('2022-11-12', 3);

DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking(bookingDate DATE,
                                 tableNumber INT UNSIGNED,
                                 customerID INT UNSIGNED)
BEGIN
    DECLARE numBookingRecords INT UNSIGNED DEFAULT 1;
    START TRANSACTION;
    INSERT INTO Bookings(BookingDate, TableNumber, CustomerID) VALUES (bookingDate, tableNumber, CustomerID);

    SELECT COUNT(1)
    INTO numBookingRecords
    FROM Bookings
    WHERE Bookings.BookingDate = BookingDate
      AND Bookings.TableNumber = tableNumber;
    CASE
        WHEN numBookingRecords = 1 THEN BEGIN
            SELECT CONCAT("Table ", tableNumber, " is NOW booked for customer ", customerID);
            COMMIT;
        END;
        ELSE BEGIN
            SELECT CONCAT("Table ", tableNumber, " is already booked - booking cancelled ");
            ROLLBACK;
        END;
        END CASE;
END;
//
DELIMITER ;

SELECT "AddValidBooking(2022-11-12, 10, 4) should pass";
CALL AddValidBooking('2022-11-12', 10, 4);
SELECT "AddValidBooking(2022-11-12, 10, 4) should fail";
CALL AddValidBooking('2022-11-12', 10, 4);
SELECT "AddValidBooking(2022-12-31, 10, 4) should pass";
CALL AddValidBooking('2022-12-31', 10, 4);

SELECT "Viewing all records";
SELECT *
FROM Bookings;