Smart Event Management System
Comprehensive Database Documentation &amp; Operational Handbook

1. Project Overview
A robust, highly optimized relational MySQL database schema designed to seamlessly streamline core
corporate event planning operations, venue assignments, attendee transaction lifecycle tracking, secure
ticket booking states, and immediate real-time payment clearings. This architectural specification details
the comprehensive database schema design, enterprise mock data mappings, and extensive analytical
operational query modules ranging from basic transactional operations to advanced window-partitioned
analytics.
Key System Features &amp; Safeguards
 Real-Time Capacity Auditing: Dynamic counter verification protocols tracking operational structural
limits across physical installations via strict total_seats vs available_seats computations.
 Strict Multi-Registration Prevention: Enforcement of multi-column business logic rules using
specialized compound indexing to safeguard against overlapping ticket distributions per isolated
attendee identifier profile.
 Cascading Data Integrity Layouts: Engineered architecture specifying programmatic referential
clearings using contextualized ON DELETE SET NULL and ON DELETE CASCADE structural
directives to preserve long-term transactional referential integrity records.
2. Relational Database Schema Model
The relational data persistence engine consists of six entity architectures mapped cleanly to reduce
redundant structural declarations while prioritizing low operational query latencies:
 Venues: Maintains corporate facility data records, geographical address properties, and physical
maximum structural volumetric occupancy capacity guidelines.
 Organizers: Houses entity attributes representing internal/external teams responsible for planning,
corporate coordinating, and financing actions.
 Attendees: Collects detailed primary communication channels, metadata profiles, and structural
identifiers for individuals registering for events.
 Events: Acts as the central entity hub mapping scheduled operations directly across physical
locations and coordinating corporate teams alongside dynamic price levels.

 Tickets: Builds state transitions mapping individuals cleanly to events using localized categorical
status boundaries (Confirmed, Cancelled, Pending).
 Payments: Fulfill ledger integrity requirements logging incoming electronic revenue transactions
directly to individual issued ticketing items.
3. Database Schema Implementation Script
Execute the following complete DDL and configuration sequence inside your target MySQL engine client
window environment to initialize your architecture components:
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
status ENUM(&#39;Confirmed&#39;, &#39;Cancelled&#39;, &#39;Pending&#39;) DEFAULT &#39;Pending&#39;,
FOREIGN KEY (event_id) REFERENCES Events(event_id) ON DELETE CASCADE,

FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id) ON DELETE CASCADE,
UNIQUE KEY unique_attendee_event (attendee_id, event_id)
);
CREATE TABLE Payments (
payment_id INT AUTO_INCREMENT PRIMARY KEY,
ticket_id INT NOT NULL,
amount_paid DECIMAL(10, 2) NOT NULL,
payment_status ENUM(&#39;Success&#39;, &#39;Failed&#39;, &#39;Pending&#39;) DEFAULT &#39;Pending&#39;,
payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id) ON DELETE CASCADE
);

4. Seed Verification Datasets
The sample datasets below include multi-regional data setups to fully validate production query rules
and edge conditions:
-- 1. Seeding Venues
INSERT INTO Venues (venue_name, location, capacity) VALUES
(&#39;Jio World Convention Centre&#39;, &#39;Mumbai&#39;, 2000),
(&#39;NICC Auditorium&#39;, &#39;Bengaluru&#39;, 300),
(&#39;Pragati Maidan Exhibition Hall&#39;, &#39;New Delhi&#39;, 1500),
(&#39;HITEX Exhibition Center&#39;, &#39;Hyderabad&#39;, 800),
(&#39;Science City Main Auditorium&#39;, &#39;Kolkata&#39;, 1200),
(&#39;Chennai Trade Centre&#39;, &#39;Chennai&#39;, 1000),
(&#39;Mahatma Mandir Convention Center&#39;, &#39;Gandhinagar&#39;, 2500),
(&#39;Jaipur Exhibition &amp; Convention Centre&#39;, &#39;Jaipur&#39;, 600),
(&#39;Deendayal Hastkala Sankul&#39;, &#39;Varanasi&#39;, 400),
(&#39;Lonavala Creative Retreat&#39;, &#39;Pune&#39;, 150);
-- 2. Seeding Organizers
INSERT INTO Organizers (organizer_name, contact_email, phone_number) VALUES
(&#39;Tech India Horizons&#39;, &#39;connect@techindia.in&#39;, &#39;+919876543210&#39;),
(&#39;Bollywood Beats Entertainment&#39;, &#39;events@bollywoodbeats.co.in&#39;, &#39;+9122446688&#39;),
(&#39;NASSCOM Tech Forums&#39;, NULL, &#39;011-23456789&#39;),
(&#39;Titanium Startup Hub&#39;, &#39;pitch@titaniumhub.in&#39;, &#39;+918887776665&#39;),
(&#39;Green India Foundation&#39;, &#39;save@greenindia.org&#39;, &#39;080-5554321&#39;),
(&#39;Spic Macay Collective&#39;, &#39;info@spicmacay.org&#39;, &#39;+919911223344&#39;),
(&#39;Fintech Mumbai Ventures&#39;, &#39;admin@fintechmumbai.net&#39;, &#39;022-77665544&#39;),
(&#39;Ayush Wellness Expos&#39;, &#39;support@ayushwellness.in&#39;, &#39;+917776665554&#39;),
(&#39;IIT Madras Alumni Cell&#39;, &#39;reachus@iitm.ac.in&#39;, &#39;044-90008000&#39;),
(&#39;IndiGamers League&#39;, &#39;tournaments@indigamers.in&#39;, &#39;+919090909090&#39;);
-- 3. Seeding Attendees
INSERT INTO Attendees (name, email, phone_number) VALUES
(&#39;Aarav Sharma&#39;, &#39;aarav.sharma@gmail.com&#39;, &#39;+919812345678&#39;),
(&#39;Diya Patel&#39;, &#39;diya.patel@yahoo.com&#39;, &#39;+919876543211&#39;),
(&#39;Vihaan Khanna&#39;, NULL, &#39;+919111222333&#39;),
(&#39;Ananya Iyer&#39;, &#39;ananya.iyer@outlook.in&#39;, &#39;+919444555666&#39;),
(&#39;Kabir Singh&#39;, &#39;kabir.singh@gmail.com&#39;, &#39;+919555666777&#39;),
(&#39;Meera Nair&#39;, &#39;meera.nair@corporate.in&#39;, &#39;+919666777888&#39;),
(&#39;Sai Reddy&#39;, NULL, &#39;+919777888999&#39;),

(&#39;Rohan Das&#39;, &#39;rohan.das@rediffmail.com&#39;, &#39;+919888999000&#39;),
(&#39;Aditi Joshi&#39;, &#39;aditi.j@research.org&#39;, &#39;+919999000111&#39;),
(&#39;Arjun Verma&#39;, &#39;arjun.v@cinema.in&#39;, &#39;+919000111222&#39;);
-- 4. Seeding Events
INSERT INTO Events (event_name, event_date, venue_id, organizer_id, ticket_price,
total_seats, available_seats) VALUES
(&#39;India AI Revolution Summit 2026&#39;, &#39;2026-12-15 09:00:00&#39;, 2, 1, 4500.00, 200, 195),
(&#39;Sunburn Winter Rock Festival&#39;, &#39;2026-12-20 18:00:00&#39;, 3, 2, 2500.00, 1000, 996),
(&#39;Advanced Data Science Masterclass&#39;, &#39;2026-07-10 10:00:00&#39;, 1, 1, 6000.00, 100, 98),
(&#39;Bengaluru Startup Pitch Night&#39;, &#39;2026-08-05 19:00:00&#39;, 8, 4, 500.00, 50, 48),
(&#39;National Sustainability Summit&#39;, &#39;2026-09-22 08:30:00&#39;, 7, 5, 0.00, 300, 298),
(&#39;Global FinTech India Expo&#39;, &#39;2026-10-14 09:00:00&#39;, 5, 7, 8500.00, 1500, 1498),
(&#39;Kala Ghoda Indie Art Showcase&#39;, &#39;2026-11-02 14:00:00&#39;, 4, 6, 350.00, 350, 348),
(&#39;Indian Esports Arena Championship&#39;, &#39;2026-12-05 10:00:00&#39;, 9, 10, 1200.00, 600, 597),
(&#39;Modern Higher Education Forum&#39;, &#39;2026-07-25 13:00:00&#39;, 10, 9, 1500.00, 450, 449),
(&#39;Vedic Health &amp; Holistic Seminar&#39;, &#39;2026-08-18 11:00:00&#39;, 6, 8, 800.00, 800, 800);
-- 5. Seeding Tickets
INSERT INTO Tickets (event_id, attendee_id, booking_date, status) VALUES
(1, 1, &#39;2026-07-02 10:00:00&#39;, &#39;Confirmed&#39;),
(1, 2, &#39;2026-07-03 11:30:00&#39;, &#39;Confirmed&#39;),
(2, 2, &#39;2026-07-04 14:00:00&#39;, &#39;Confirmed&#39;),
(3, 3, &#39;2026-07-01 09:00:00&#39;, &#39;Confirmed&#39;),
(3, 4, &#39;2026-07-01 09:15:00&#39;, &#39;Cancelled&#39;),
(4, 5, &#39;2026-07-06 16:45:00&#39;, &#39;Confirmed&#39;),
(5, 6, &#39;2026-07-07 09:00:00&#39;, &#39;Confirmed&#39;),
(6, 7, &#39;2026-07-07 10:15:00&#39;, &#39;Confirmed&#39;),
(7, 8, &#39;2026-07-07 11:00:00&#39;, &#39;Confirmed&#39;),
(8, 9, &#39;2026-07-07 12:30:00&#39;, &#39;Confirmed&#39;);
-- 6. Seeding Payments
INSERT INTO Payments (ticket_id, amount_paid, payment_status, payment_date) VALUES
(1, 4500.00, &#39;Success&#39;, &#39;2026-07-02 10:05:00&#39;),
(2, 4500.00, &#39;Success&#39;, &#39;2026-07-03 11:35:00&#39;),
(3, 2500.00, &#39;Pending&#39;, &#39;2026-07-04 14:00:00&#39;),
(4, 6000.00, &#39;Success&#39;, &#39;2026-07-01 09:05:00&#39;),
(5, 0.00, &#39;Failed&#39;, &#39;2026-07-01 09:20:00&#39;),
(6, 500.00, &#39;Success&#39;, &#39;2026-07-06 16:50:00&#39;),
(7, 0.00, &#39;Success&#39;, &#39;2026-07-07 09:00:00&#39;),
(8, 8500.00, &#39;Success&#39;, &#39;2026-07-07 10:20:00&#39;),
(9, 350.00, &#39;Success&#39;, &#39;2026-07-07 11:05:00&#39;),
(10, 1200.00, &#39;Pending&#39;, &#39;2026-07-07 12:35:00&#39;);

5. Primary Operational Queries
Core CRUD Logic Elements
-- CREATE (Add an Event Record)
INSERT INTO Events (event_name, event_date, venue_id, organizer_id, ticket_price,
total_seats, available_seats)
VALUES (&#39;Cybersecurity Briefing&#39;, &#39;2026-09-18 14:00:00&#39;, 2, 1, 50.00, 100, 100);

-- READ (Filter Budget Events)
SELECT * FROM Events WHERE ticket_price &lt;= 100.00;
-- UPDATE (Modify Ticket Booking Status)
UPDATE Tickets SET status = &#39;Cancelled&#39; WHERE ticket_id = 5;
-- DELETE (Clean Canceled Transactions)
DELETE FROM Tickets WHERE status = &#39;Cancelled&#39;;

Business Intelligence &amp; Analytics Modules
-- 1. Identify Top 5 Revenue Generating Operations
SELECT E.event_id, E.event_name, SUM(P.amount_paid) AS total_revenue
FROM Events E
JOIN Tickets T ON E.event_id = T.event_id
JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE P.payment_status = &#39;Success&#39;
GROUP BY E.event_id, E.event_name
ORDER BY total_revenue DESC
LIMIT 5;
-- 2. Query Regional Active Schedules (Mumbai Context)
SELECT E.* FROM Events E
JOIN Venues V ON E.venue_id = V.venue_id
WHERE V.location = &#39;Mumbai&#39; AND E.event_date &gt; NOW();
-- 3. Dynamic Threshold Valuation vs Running Average Sales
SELECT event_id, event_name
FROM (
SELECT E.event_id, E.event_name, COALESCE(SUM(P.amount_paid), 0) AS event_revenue
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id
LEFT JOIN Payments P ON T.ticket_id = P.ticket_id AND P.payment_status = &#39;Success&#39;
GROUP BY E.event_id, E.event_name
) AS EventRevenues
WHERE event_revenue &gt; (
SELECT AVG(revenue) FROM (
SELECT COALESCE(SUM(P2.amount_paid), 0) AS revenue
FROM Events E2
LEFT JOIN Tickets T2 ON E2.event_id = T2.event_id
LEFT JOIN Payments P2 ON T2.ticket_id = P2.ticket_id AND P2.payment_status =
&#39;Success&#39;
GROUP BY E2.event_id
) AS AvgCalc
);

Advanced Analytic Windows &amp; Demand Forecasting
-- 1. Global Revenue Competitive Performance Ranking Ladder
SELECT E.event_id, E.event_name, COALESCE(SUM(P.amount_paid), 0) AS total_revenue,
RANK() OVER (ORDER BY COALESCE(SUM(P.amount_paid), 0) DESC) AS revenue_rank
FROM Events E
LEFT JOIN Tickets T ON E.event_id = T.event_id

LEFT JOIN Payments P ON T.ticket_id = P.ticket_id AND P.payment_status = &#39;Success&#39;
GROUP BY E.event_id, E.event_name;
-- 2. Chronological Running Sum Bookkeeping Computations
SELECT T.ticket_id, T.event_id, P.amount_paid,
SUM(P.amount_paid) OVER (ORDER BY T.booking_date) AS cumulative_ticket_sales
FROM Tickets T
JOIN Payments P ON T.ticket_id = P.ticket_id
WHERE P.payment_status = &#39;Success&#39;;
-- 3. Live Adaptive Demand Capacity Classification Block
SELECT event_id, event_name, available_seats, total_seats,
CASE
WHEN available_seats &lt; (total_seats * 0.20) THEN &#39;High Demand&#39;
WHEN available_seats BETWEEN (total_seats * 0.20) AND (total_seats * 0.50)
THEN &#39;Moderate Demand&#39;
ELSE &#39;Low Demand&#39;
END AS demand_category
FROM Events;
