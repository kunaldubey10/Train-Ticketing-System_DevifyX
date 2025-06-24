USE train_ticket_booking_system;

DELIMITER $$

CREATE TRIGGER trg_after_booking_cancel
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    IF NEW.status = 'Cancelled' THEN
        INSERT INTO cancellations (booking_id, refund_amount, reason)
        VALUES (NEW.booking_id, 0.00, 'Auto-generated via trigger');
    END IF;
END$$

DELIMITER ;
