CREATE DATABASE train_ticket_booking_system;
USE train_ticket_booking_system;

CREATE TABLE stations (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    station_code VARCHAR(10) UNIQUE
);

CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    source_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    distance_km DECIMAL(6,2),
    duration_minutes INT,
    FOREIGN KEY (source_station_id) REFERENCES stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES stations(station_id)
);

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_type ENUM('Bus', 'Train') NOT NULL,
    model VARCHAR(50),
    total_seats INT NOT NULL,
    registration_number VARCHAR(20) UNIQUE
);

CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    route_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    operating_date DATE NOT NULL,
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    user_type ENUM('Passenger', 'Admin') DEFAULT 'Passenger'
);

CREATE TABLE seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_type ENUM('Regular', 'Recliner', 'Sleeper'),
    class ENUM('Economy', 'Business', 'First') NOT NULL,
    is_window BOOLEAN,
    UNIQUE(vehicle_id, seat_number),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id INT NOT NULL,
    seat_id INT NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fare DECIMAL(10,2),
    status ENUM('Booked', 'Cancelled') DEFAULT 'Booked',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id),
    FOREIGN KEY (seat_id) REFERENCES seats(seat_id),
    UNIQUE(schedule_id, seat_id)
);

CREATE TABLE cancellations (
    cancellation_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    cancelled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    refund_amount DECIMAL(10,2),
    reason TEXT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE fares (
    fare_id INT AUTO_INCREMENT PRIMARY KEY,
    route_id INT NOT NULL,
    seat_class ENUM('Economy', 'Business', 'First'),
    fare_amount DECIMAL(10,2),
    dynamic_pricing BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
