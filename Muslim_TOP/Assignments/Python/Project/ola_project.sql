CREATE DATABASE Ola;
USE Ola;

-- > Riders (Passengers) : --> parent table
CREATE TABLE riders (
    rider_id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique rider ID
    name VARCHAR(100),                                -- Rider's name
    email VARCHAR(100) UNIQUE,                        -- Email (must be unique)
    phone_number VARCHAR(15),                 		  -- Contact number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 	  -- Automatically set to current time
);

-- > Drivers: --> parent table
CREATE TABLE drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY, 		-- Unique driver ID
    name VARCHAR(100),                        		-- Driver's name
    email VARCHAR(100) UNIQUE,                		-- Email (must be unique)
    phone_number VARCHAR(15),                 		-- Contact number
    license_number VARCHAR(50),               		-- Driver's license number
    rating FLOAT DEFAULT 5.0,                 		-- Average rating, starting at 5.0
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Automatically set to current time
);


-- > Rides (Trips): --> parent or child
CREATE TABLE rides (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,   				 -- Unique ride ID
    rider_id INT,                              		 		 -- Rider's ID (links to rider table)
    driver_id INT,                             		 		 -- Driver's ID (links to driver table)
    pickup_location VARCHAR(255),              		     	 -- Location where the ride started
    dropoff_location VARCHAR(255),             		 		 -- Location where the ride ended
    ride_status ENUM('requested', 'ongoing', 'completed', 'cancelled'), -- Ride status
    fare DECIMAL(10, 2),                      		 		 -- Total fare for the ride
    start_time DATETIME,                       		 		 -- Start time of the ride
    end_time DATETIME,                         		 		 -- End time of the ride
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id), 	 -- Link to riders table
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id) 	 -- Link to drivers table
);

-- >Payments: --> child
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY, 				-- Unique payment ID
    ride_id INT,                               				-- Ride's ID (links to ride table)
    payment_method ENUM('cash', 'credit_card', 'wallet'), 	-- Payment method
    amount DECIMAL(10, 2),                     				-- Amount paid
    payment_status ENUM('pending', 'completed', 'failed'), -- Payment status
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 	   -- Time payment was made
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id)        -- Link to rides table
);

-- > Reviews: --> child 
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,  				-- Unique review ID
    rider_id INT,                              				-- Rider's ID (links to riders table)
    driver_id INT,                             				-- Driver's ID (links to drivers table)
    rating INT CHECK(rating >= 1 AND rating <= 5), 			-- Rating (1 to 5 stars)
    comments TEXT,                             				-- Written feedback
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 		-- Time review was submitted
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id), 	-- Link to riders table
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id) 	-- Link to drivers table
);

SELECT * FROM rides WHERE driver_id = 1;

SELECT AVG(rating)  vag_rating 
FROM reviews
WHERE driver_id = 1;

SELECT rider_id, ride_id, driver_id, pickup_location,dropoff_location,fare
FROM rides 
WHERE ride_status = 'completed';

SELECT  driver_id, COUNT(*) AS total_completed_rides
FROM rides
WHERE ride_status = 'completed'
GROUP  BY driver_id ;

SELECT driver_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY driver_id
ORDER BY avg_rating DESC
LIMIT 1;

SELECT * FROM payments
WHERE payment_status = 'pending';

SELECT rides.ride_id, riders.name AS rider_name, drivers.name AS driver_name, 
       rides.pickup_location, rides.dropoff_location, rides.ride_status, rides.fare
FROM rides
JOIN riders ON rides.rider_id = riders.rider_id
JOIN drivers ON rides.driver_id = drivers.driver_id;

SELECT payments.payment_id, payments.amount, payments.payment_method, payments.payment_status,
       riders.name AS rider_name, rides.pickup_location, rides.dropoff_location
FROM payments
JOIN rides ON payments.ride_id = rides.ride_id
JOIN riders ON rides.rider_id = riders.rider_id;


SELECT reviews.review_id, riders.name AS rider_name, drivers.name AS driver_name, 
       reviews.rating, reviews.comments, reviews.review_date
FROM reviews
JOIN riders ON reviews.rider_id = riders.rider_id
JOIN drivers ON reviews.driver_id = drivers.driver_id;

SELECT drivers.name AS driver_name, SUM(rides.fare) AS total_earnings
FROM drivers
JOIN rides ON drivers.driver_id = rides.driver_id
WHERE rides.ride_status = 'completed'
GROUP BY drivers.driver_id;

SELECT rides.ride_id, riders.name AS rider_name, drivers.name AS driver_name, 
       rides.pickup_location, rides.dropoff_location, rides.ride_status, 
       payments.payment_status, payments.amount
FROM rides
JOIN riders ON rides.rider_id = riders.rider_id
JOIN drivers ON rides.driver_id = drivers.driver_id
LEFT JOIN payments ON rides.ride_id = payments.ride_id;


SELECT drivers.name AS driver_name, rides.ride_id, reviews.rating, reviews.comments
FROM rides
JOIN drivers ON rides.driver_id = drivers.driver_id
LEFT JOIN reviews ON rides.driver_id = reviews.driver_id
ORDER BY drivers.name;


SELECT riders.name AS rider_name, COUNT(rides.ride_id) AS total_rides, 
       SUM(rides.fare) AS total_spent
FROM riders
JOIN rides ON riders.rider_id = rides.rider_id
GROUP BY riders.rider_id;
