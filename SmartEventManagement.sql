CREATE DATABASE SmartEventManagement;
USE SmartEventManagement;

CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Organizers (
    organizer_id INT AUTO_INCREMENT PRIMARY KEY,
    organizer_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE Attendees (
    attendee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(150) NOT NULL,
    event_date DATETIME NOT NULL,
    venue_id INT,
    organizer_id INT,
    ticket_price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id) ON DELETE SET NULL,
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id) ON DELETE SET NULL
);


CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    attendee_id INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Confirmed', 'Cancelled', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (event_id) REFERENCES Events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id) ON DELETE CASCADE,
    -- Requirement 6.1: Ensure attendees cannot book the same event multiple times concurrently
    UNIQUE KEY unique_attendee_event (attendee_id, event_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL, -- Requirement 6.2: Link payments to tickets
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Success', 'Failed', 'Pending') DEFAULT 'Pending',
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id) ON DELETE CASCADE
);

-- 1. Venues 
INSERT INTO Venues (venue_name, location, capacity) VALUES
('Jio World Convention Centre', 'Mumbai', 2000),
('NICC Auditorium', 'Bengaluru', 300),
('Pragati Maidan Exhibition Hall', 'New Delhi', 1500),
('HITEX Exhibition Center', 'Hyderabad', 800),
('Science City Main Auditorium', 'Kolkata', 1200),
('Chennai Trade Centre', 'Chennai', 1000),
('Mahatma Mandir Convention Center', 'Gandhinagar', 2500),
('Jaipur Exhibition & Convention Centre', 'Jaipur', 600),
('Deendayal Hastkala Sankul', 'Varanasi', 400),
('Lonavala Creative Retreat', 'Pune', 150);

-- 2. Organizers 
INSERT INTO Organizers (organizer_name, contact_email, phone_number) VALUES
('Tech India Horizons', '  connect@techindia.in ', '+919876543210'),
('Bollywood Beats Entertainment', 'events@bollywoodbeats.co.in', ' +9122446688 '),
('NASSCOM Tech Forums', NULL, '011-23456789'),
('Titanium Startup Hub', 'pitch@titaniumhub.in', '+918887776665'),
('Green India Foundation', 'save@greenindia.org', '080-5554321'),
('Spic Macay Collective', 'info@spicmacay.org', '+919911223344'),
('Fintech Mumbai Ventures', 'admin@fintechmumbai.net', '022-77665544'),
('Ayush Wellness Expos', 'support@ayushwellness.in', '+917776665554'),
('IIT Madras Alumni Cell', 'reachus@iitm.ac.in', '044-90008000'),
('IndiGamers League', 'tournaments@indigamers.in', '+919090909090');

-- 3. Attendees 
INSERT INTO Attendees (name, email, phone_number) VALUES
('Aarav Sharma', 'aarav.sharma@gmail.com', '+919812345678'),
('Diya Patel', 'diya.patel@yahoo.com', '+919876543211'),
('Vihaan Khanna', NULL, '+919111222333'),
('Ananya Iyer', 'ananya.iyer@outlook.in', '+919444555666'),
('Kabir Singh', 'kabir.singh@gmail.com', '+919555666777'),
('Meera Nair', 'meera.nair@corporate.in', '+919666777888'),
('Sai Reddy', NULL, '+919777888999'),
('Rohan Das', 'rohan.das@rediffmail.com', '+919888999000'),
('Aditi Joshi', 'aditi.j@research.org', '+919999000111'),
('Arjun Verma', 'arjun.v@cinema.in', '+919000111222');

-- 4. Events 
INSERT INTO Events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) VALUES
('India AI Revolution Summit 2026', '2026-12-15 09:00:00', 2, 1, 4500.00, 200, 195),
('Sunburn Winter Rock Festival', '2026-12-20 18:00:00', 3, 2, 2500.00, 1000, 996),
('Advanced Data Science Masterclass', '2026-07-10 10:00:00', 1, 1, 6000.00, 100, 98),
('Bengaluru Startup Pitch Night', '2026-08-05 19:00:00', 8, 4, 500.00, 50, 48),
('National Sustainability Summit', '2026-09-22 08:30:00', 7, 5, 0.00, 300, 298),
('Global FinTech India Expo', '2026-10-14 09:00:00', 5, 7, 8500.00, 1500, 1498),
('Kala Ghoda Indie Art Showcase', '2026-11-02 14:00:00', 4, 6, 350.00, 350, 348),
('Indian Esports Arena Championship', '2026-12-05 10:00:00', 9, 10, 1200.00, 600, 597),
('Modern Higher Education Forum', '2026-07-25 13:00:00', 10, 9, 1500.00, 450, 449),
('Vedic Health & Holistic Seminar', '2026-08-18 11:00:00', 6, 8, 800.00, 800, 800);

-- 5. Tickets 
INSERT INTO Tickets (event_id, attendee_id, booking_date, status) VALUES
(1, 1, '2026-07-02 10:00:00', 'Confirmed'),
(1, 2, '2026-07-03 11:30:00', 'Confirmed'),
(2, 2, '2026-07-04 14:00:00', 'Confirmed'),
(3, 3, '2026-07-01 09:00:00', 'Confirmed'),
(3, 4, '2026-07-01 09:15:00', 'Cancelled'),
(4, 5, '2026-07-06 16:45:00', 'Confirmed'),
(5, 6, '2026-07-07 09:00:00', 'Confirmed'),
(6, 7, '2026-07-07 10:15:00', 'Confirmed'),
(7, 8, '2026-07-07 11:00:00', 'Confirmed'),
(8, 9, '2026-07-07 12:30:00', 'Confirmed');

-- 6. Payments 
INSERT INTO Payments (ticket_id, amount_paid, payment_status, payment_date) VALUES
(1, 4500.00, 'Success', '2026-07-02 10:05:00'),
(2, 4500.00, 'Success', '2026-07-03 11:35:00'),
(3, 2500.00, 'Pending', '2026-07-04 14:00:00'),
(4, 6000.00, 'Success', '2026-07-01 09:05:00'),
(5, 0.00, 'Failed', '2026-07-01 09:20:00'),
(6, 500.00, 'Success', '2026-07-06 16:50:00'),
(7, 0.00, 'Success', '2026-07-07 09:00:00'), 
(8, 8500.00, 'Success', '2026-07-07 10:20:00'),
(9, 350.00, 'Success', '2026-07-07 11:05:00'),
(10, 1200.00, 'Pending', '2026-07-07 12:35:00');

-- Create (Add an Event)
INSERT INTO Events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) 
VALUES ('Cybersecurity Briefing', '2026-09-18 14:00:00', 2, 1, 50.00, 100, 100);

-- Read (Search for Events
SELECT * FROM Events WHERE ticket_price <= 100.00;

-- Update (Modify Ticket Booking Status)
UPDATE Tickets SET status = 'Cancelled' WHERE ticket_id = 5;

-- Delete (Remove a canceled ticket transaction)
DELETE FROM Tickets WHERE status = 'Cancelled';

-- SQL Clauses

SELECT E.* FROM Events E
JOIN Venues V ON E.venue_id = V.venue_id
WHERE V.location = 'Mumbai' AND E.event_date > NOW();

-- --Retrieve the top 5 highest revenue-generating events

SELECT E.event_id, E.event_name, SUM(P.amount_paid) AS total_revenue
FROM Events E
JOIN Tickets T ON E.event_id = T.event_id
JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE P.payment_status = 'Success'
GROUP BY E.event_id, E.event_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Find attendees who booked tickets in the last 7 days

SELECT DISTINCT A.* FROM Attendees A
JOIN Tickets T ON A.attendee_id = T.attendee_id
WHERE T.booking_date >= DATE_SUB(NOW(), INTERVAL 7 DAY);


-- --Retrieve events scheduled in December AND have more than 50% available seats 

SELECT * FROM Events
WHERE MONTH(event_date) = 12 
  AND available_seats > (total_seats * 0.5);
  
--   List attendees who have booked a ticket OR have a pending payment

SELECT DISTINCT A.* FROM Attendees A
JOIN Tickets T ON A.attendee_id = T.attendee_id
LEFT JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE T.status = 'Confirmed' OR P.payment_status = 'Pending';

-- Identify events that are NOT fully booked

SELECT * FROM Events
WHERE NOT (available_seats = 0);

-- •	Sort events by date in ascending order:

SELECT * FROM Events
ORDER BY event_date ASC;

-- 	Count the number of attendees per event:
SELECT E.event_id, E.event_name, COUNT(T.attendee_id) AS total_attendees
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id AND T.status = 'Confirmed'
GROUP BY E.event_id, E.event_name;

-- 	Show the total revenue generated per event:

SELECT E.event_id, E.event_name, COALESCE(SUM(P.amount_paid), 0) AS total_revenue
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id
LEFT JOIN Payments P ON T.ticket_id = P.ticket_id AND P.payment_status = 'Success'
GROUP BY E.event_id, E.event_name;

-- 	Calculate the total revenue generated from all events:

SELECT SUM(amount_paid) AS total_global_revenue 
FROM Payments 
WHERE payment_status = 'Success';


-- 	Find the event with the highest number of attendees:

SELECT E.event_id, E.event_name, COUNT(T.ticket_id) AS attendee_count
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id AND T.status = 'Confirmed'
GROUP BY E.event_id, E.event_name
ORDER BY attendee_count DESC
LIMIT 1;

-- •	Compute the average ticket price across all events:

SELECT AVG(ticket_price) AS average_ticket_price 
FROM Events;

-- Retrieve event details along with venue information using INNER JOIN:

SELECT E.event_id, E.event_name, E.event_date, V.venue_name, V.location
FROM Events E
INNER JOIN Venues V ON E.venue_id = V.venue_id;


-- Get a list of attendees who booked a ticket but did not complete payment using LEFT JOIN:

SELECT A.attendee_id, A.name, T.ticket_id, P.payment_status
FROM Attendees A
INNER JOIN Tickets T ON A.attendee_id = T.attendee_id
LEFT JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE P.payment_id IS NULL OR P.payment_status != 'Success';


-- 	Identify events without any attendees using RIGHT JOIN:

SELECT E.event_id, E.event_name
FROM Tickets T
RIGHT JOIN Events E ON T.event_id = E.event_id
WHERE T.ticket_id IS NULL;

-- 	Show attendees who have not booked any ticket using FULL OUTER JOIN (Simulated via LEFT JOIN + UNION for MySQL compatibility):

SELECT A.attendee_id, A.name
FROM Attendees A
LEFT JOIN Tickets T ON A.attendee_id = T.attendee_id
WHERE T.ticket_id IS NULL;

-- 	Find events that generated revenue above the average ticket sales:

SELECT event_id, event_name
FROM (
    SELECT E.event_id, E.event_name, COALESCE(SUM(P.amount_paid), 0) AS event_revenue
    FROM Events E
    LEFT JOIN Tickets T ON E.event_id = T.event_id
    LEFT JOIN Payments P ON T.ticket_id = P.ticket_id AND P.payment_status = 'Success'
    GROUP BY E.event_id, E.event_name
) AS EventRevenues
WHERE event_revenue > (
    SELECT AVG(revenue) FROM (
        SELECT COALESCE(SUM(P2.amount_paid), 0) AS revenue
        FROM Events E2
        LEFT JOIN Tickets T2 ON E2.event_id = T2.event_id
        LEFT JOIN Payments P2 ON T2.ticket_id = P2.ticket_id AND P2.payment_status = 'Success'
        GROUP BY E2.event_id
    ) AS AvgCalc
);


-- Identify attendees who have booked tickets for multiple events:

SELECT attendee_id, name 
FROM Attendees
WHERE attendee_id IN (
    SELECT attendee_id 
    FROM Tickets 
    WHERE status = 'Confirmed'
    GROUP BY attendee_id 
    HAVING COUNT(DISTINCT event_id) > 1
);


-- Retrieve organizers who have managed more than 3 events:

SELECT organizer_id, organizer_name 
FROM Organizers
WHERE organizer_id IN (
    SELECT organizer_id 
    FROM Events 
    GROUP BY organizer_id 
    HAVING COUNT(event_id) > 3
);

-- Extract the month from event_date to analyze event trends:

SELECT event_id, event_name, MONTH(event_date) AS event_month 
FROM Events;


-- Calculate the number of days remaining for an upcoming event:

SELECT event_id, event_name, DATEDIFF(event_date, NOW()) AS days_remaining
FROM Events
WHERE event_date > NOW();


-- Format payment_date as YYYY-MM-DD HH:MM:SS:

SELECT payment_id, DATE_FORMAT(payment_date, '%Y-%m-%d %H:%i:%s') AS formatted_payment_date
FROM Payments;


-- Convert all organizer names to uppercase:

SELECT organizer_id, UPPER(organizer_name) AS upper_organizer_name 
FROM Organizers;


-- Remove extra spaces from attendee names using TRIM():

SELECT attendee_id, TRIM(name) AS cleaned_name 
FROM Attendees;


-- Replace NULL email fields with "Not Provided":

SELECT attendee_id, name, COALESCE(email, 'Not Provided') AS email_status
FROM Attendees;

-- Rank events based on total revenue earned:

SELECT E.event_id, E.event_name, COALESCE(SUM(P.amount_paid), 0) AS total_revenue,
       RANK() OVER (ORDER BY COALESCE(SUM(P.amount_paid), 0) DESC) AS revenue_rank
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id
LEFT JOIN Payments P ON T.ticket_id = P.ticket_id AND P.payment_status = 'Success'
GROUP BY E.event_id, E.event_name;


-- Display the cumulative sum of ticket sales (Ordered by booking date):

SELECT T.ticket_id, T.event_id, P.amount_paid,
       SUM(P.amount_paid) OVER (ORDER BY T.booking_date) AS cumulative_ticket_sales
FROM Tickets T
JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE P.payment_status = 'Success';


-- Show the running total of attendees registered per event (Ordered by booking date):

SELECT T.event_id, T.attendee_id, T.booking_date,
       COUNT(T.attendee_id) OVER (PARTITION BY T.event_id ORDER BY T.booking_date) AS running_attendee_total
FROM Tickets T
WHERE T.status = 'Confirmed';


-- Categorize events based on ticket sales:

SELECT event_id, event_name, available_seats, total_seats,
       CASE 
           WHEN available_seats < (total_seats * 0.20) THEN 'High Demand'
           WHEN available_seats BETWEEN (total_seats * 0.20) AND (total_seats * 0.50) THEN 'Moderate Demand'
           ELSE 'Low Demand'
       END AS demand_category
FROM Events;


-- Assign payment statuses: 

SELECT payment_id, ticket_id, payment_status,
       CASE 
           WHEN payment_status = 'Success' THEN 'Successful'
           WHEN payment_status = 'Failed' THEN 'Failed'
           ELSE 'Pending'
       END AS descriptive_status
FROM Payments;