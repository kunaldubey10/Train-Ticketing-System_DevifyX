USE train_ticket_booking_system;

DELIMITER $$

CREATE PROCEDURE sp_book_ticket (
    IN p_user_id INT,
    IN p_schedule_id INT,
    IN p_seat_id INT,
    IN p_fare DECIMAL(10,2)
)
BEGIN
    DECLARE seat_taken INT;

    SELECT COUNT(*) INTO seat_taken
    FROM bookings
    WHERE schedule_id = p_schedule_id AND seat_id = p_seat_id AND status = 'Booked';

    IF seat_taken = 0 THEN
        INSERT INTO bookings (user_id, schedule_id, seat_id, fare, status)
        VALUES (p_user_id, p_schedule_id, p_seat_id, p_fare, 'Booked');
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seat already booked';
    END IF;
END$$

CREATE PROCEDURE sp_cancel_ticket (
    IN p_booking_id INT,
    IN p_refund_amount DECIMAL(10,2),
    IN p_reason TEXT
)
BEGIN
    UPDATE bookings
    SET status = 'Cancelled'
    WHERE booking_id = p_booking_id;

    INSERT INTO cancellations (booking_id, refund_amount, reason)
    VALUES (p_booking_id, p_refund_amount, p_reason);
END$$

CREATE PROCEDURE sp_calculate_fare (
    IN p_route_id INT,
    IN p_seat_class ENUM('Economy', 'Business', 'First'),
    OUT p_fare_amount DECIMAL(10,2)
)
BEGIN
    SELECT fare_amount INTO p_fare_amount
    FROM fares
    WHERE route_id = p_route_id AND seat_class = p_seat_class;
END$$

DELIMITER ;
