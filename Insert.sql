-- 🔄 Use the correct DB
USE train_ticket_booking_system;

-- 🚉 stations
INSERT INTO stations (station_name, location, station_code) VALUES
('Old Delhi Junction', 'Delhi', 'DLI'),
('Kanpur Central', 'Kanpur, Uttar Pradesh', 'CNB'),
('Prayagraj Junction', 'Prayagraj, Uttar Pradesh', 'PRYJ');

-- 🛤️ routes
INSERT INTO routes (source_station_id, destination_station_id, distance_km, duration_minutes) VALUES
(1, 2, 440.00, 360), -- Delhi to Kanpur
(2, 3, 200.00, 180), -- Kanpur to Prayagraj
(1, 3, 640.00, 600); -- Delhi to Prayagraj direct

-- 🚆 vehicles (realistic trains)
INSERT INTO vehicles (vehicle_type, model, total_seats, registration_number) VALUES
('Train', '12301 - Rajdhani Express', 120, 'IND12301'),
('Train', '12225 - Kaifiyat Express', 100, 'IND12225');

-- 👤 users
INSERT INTO users (full_name, email, phone, user_type) VALUES
('Kunal Dubey', 'kunal@example.com', '9876543210', 'Passenger'),
('Anjali Sharma', 'anjali@example.com', '9811223344', 'Passenger');

-- 📅 schedules (for specific dates/routes)
INSERT INTO schedules (route_id, vehicle_id, departure_time, arrival_time, operating_date) VALUES
(1, 1, '2025-06-25 06:10:00', '2025-06-25 12:10:00', '2025-06-25'), -- DLI to CNB by Rajdhani
(2, 2, '2025-06-26 08:00:00', '2025-06-26 11:00:00', '2025-06-26'), -- CNB to PRYJ by Kaifiyat
(3, 1, '2025-06-27 07:30:00', '2025-06-27 17:30:00', '2025-06-27'); -- DLI to PRYJ direct by Rajdhani

-- 🪑 seats (each train)
INSERT INTO seats (vehicle_id, seat_number, seat_type, class, is_window) VALUES
(1, 'S1-01', 'Sleeper', 'Economy', TRUE),
(1, 'S1-02', 'Sleeper', 'Economy', FALSE),
(2, 'A1-01', 'Regular', 'Business', TRUE),
(2, 'A1-02', 'Regular', 'Business', FALSE);

-- 💸 fares (per route and class)
INSERT INTO fares (route_id, seat_class, fare_amount, dynamic_pricing) VALUES
(1, 'Economy', 450.00, FALSE),
(2, 'Business', 600.00, TRUE),
(3, 'Economy', 900.00, TRUE);

-- 🎟️ bookings
INSERT INTO bookings (user_id, schedule_id, seat_id, fare, status) VALUES
(1, 1, 1, 450.00, 'Booked'),
(2, 2, 3, 600.00, 'Booked');

-- ❌ cancellations
INSERT INTO cancellations (booking_id, refund_amount, reason) VALUES
(2, 400.00, 'Change in plan');
