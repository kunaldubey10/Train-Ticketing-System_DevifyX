USE train_ticket_booking_system;


DROP VIEW IF EXISTS view_available_seats;
DROP VIEW IF EXISTS view_upcoming_journeys;
DROP VIEW IF EXISTS view_booking_summary_by_user;

CREATE VIEW view_available_seats AS
SELECT
    s.schedule_id,
    se.seat_id,
    se.seat_number,
    v.model AS train_name,
    s.operating_date
FROM seats se
JOIN vehicles v ON se.vehicle_id = v.vehicle_id
JOIN schedules s ON s.vehicle_id = v.vehicle_id
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.schedule_id = s.schedule_id
    AND b.seat_id = se.seat_id
    AND b.status = 'Booked'
);

CREATE VIEW view_upcoming_journeys AS
SELECT
    s.schedule_id,
    r.route_id,
    src.station_name AS source,
    dest.station_name AS destination,
    v.model AS train_name,
    s.operating_date,
    s.departure_time,
    s.arrival_time
FROM schedules s
JOIN routes r ON s.route_id = r.route_id
JOIN vehicles v ON s.vehicle_id = v.vehicle_id
JOIN stations src ON r.source_station_id = src.station_id
JOIN stations dest ON r.destination_station_id = dest.station_id
WHERE s.operating_date >= CURDATE();


CREATE VIEW view_booking_summary_by_user AS
SELECT
    u.full_name,
    u.email,
    b.booking_id,
    s.schedule_id,
    se.seat_number,
    b.fare,
    b.status,
    b.booking_time
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN schedules s ON b.schedule_id = s.schedule_id
JOIN seats se ON b.seat_id = se.seat_id;
