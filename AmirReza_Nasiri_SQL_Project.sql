

-- ###### CREATE TABLES


-- Table: users (with enhanced security)
CREATE TABLE IF NOT EXISTS users (
user_id SERIAL PRIMARY KEY,
username VARCHAR(50) NOT NULL,
password_hash CHAR(60) NOT NULL, -- Hashed password using a strong algorithm
email VARCHAR(100) NOT NULL,
phone_number VARCHAR(15),
email_verified BOOLEAN DEFAULT FALSE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: contacts
CREATE TABLE IF NOT EXISTS contacts (
contact_id SERIAL PRIMARY KEY,
user_id INT NOT NULL,
name VARCHAR(50) NOT NULL,
phone_number VARCHAR(15) NOT NULL,
email VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

-- Table: messages
CREATE TABLE IF NOT EXISTS messages (
message_id SERIAL PRIMARY KEY,
user_id INT NOT NULL,
contact_id INT NOT NULL,
message_text TEXT NOT NULL,
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE,
FOREIGN KEY (contact_id) REFERENCES contacts (contact_id) ON DELETE CASCADE
);

-- Table: apps
CREATE TABLE IF NOT EXISTS apps (
app_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
description TEXT,
version VARCHAR(20),
installed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_id INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

-- Table: notes
CREATE TABLE IF NOT EXISTS notes (
note_id SERIAL PRIMARY KEY,
user_id INT NOT NULL,
title VARCHAR(100) NOT NULL,
content TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

-- Table: photos
CREATE TABLE IF NOT EXISTS photos (
photo_id SERIAL PRIMARY KEY,
user_id INT NOT NULL,
filename VARCHAR(100) NOT NULL,
description TEXT,
taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

-- sample data for the users
INSERT INTO users (username, password_hash, email, phone_number, email_verified, created_at)
VALUES 
    ('john_doe', 'hash1', 'john.doe@example.com', '1234567890', true, '2024-03-13 10:00:00'),
    ('jane_smith', 'hash2', 'jane.smith@example.com', '9876543210', false, '2024-03-13 11:00:00'),
    ('mark_johnson', 'hash3', 'mark.johnson@example.com', '5555555555', false, '2024-03-13 12:00:00'),
    ('sarah_wilson', 'hash4', 'sarah.wilson@example.com', '1111111111', true, '2024-03-13 13:00:00'),
    ('michael_brown', 'hash5', 'michael.brown@example.com', '9999999999', true, '2024-03-13 14:00:00');

-- sample data for the contacts
INSERT INTO contacts (user_id, name, phone_number, email, created_at)
VALUES 
    (1, 'Alice Johnson', '5551234567', 'alice.johnson@example.com', '2024-03-13 10:30:00'),
    (1, 'Bob Smith', '5559876543', 'bob.smith@example.com', '2024-03-13 11:30:00'),
    (2, 'Charlie Brown', '5555555555', 'charlie.brown@example.com', '2024-03-13 12:30:00'),
    (3, 'David Wilson', '5551111111', 'david.wilson@example.com', '2024-03-13 13:30:00'),
    (4, 'Eve Davis', '5551234567', 'eve.davis@example.com', '2024-03-13 14:30:00');

-- sample data for the messages
INSERT INTO messages (user_id, contact_id, message_text, sent_at)
VALUES 
    (1, 1, 'Hello Alice!', '2024-03-13 10:45:00'),
    (1, 2, 'Hey Bob, how are you?', '2024-03-13 11:45:00'),
    (2, 3, 'Hi Charlie, long time no see!', '2024-03-13 12:45:00'),
    (3, 4, 'Hi David, lets catch up soon!', '2024-03-13 13:45:00'),
    (4, 5, 'Hey Eve, hows it going?', '2024-03-13 14:45:00');

-- sample data for the apps
INSERT INTO apps (name, description, version, installed_at, user_id)
VALUES 
    ('App 1', 'Description for App 1', '1.0', '2024-03-13 10:00:00', 1),
    ('App 2', 'Description for App 2', '2.0', '2024-03-13 11:00:00', 1),
    ('App 3', 'Description for App 3', '1.5', '2024-03-13 12:00:00', 2),
    ('App 4', 'Description for App 4', '2.2', '2024-03-13 13:00:00', 3),
    ('App 5', 'Description for App 5', '1.2', '2024-03-13 14:00:00', 4);

-- sample data for the notes
INSERT INTO notes (user_id, title, content, created_at)
VALUES 
    (1, 'Note 1', 'Content for Note 1', '2024-03-13 10:30:00'),
    (1, 'Note 2', 'Content for Note 2', '2024-03-13 11:30:00'),
    (2, 'Note 3', 'Content for Note 3', '2024-03-13 12:30:00'),
    (3, 'Note 4', 'Content for Note 4', '2024-03-13 13:30:00'),
    (4, 'Note 5', 'Content for Note 5', '2024-03-13 14:30:00');

-- sample data for the photos
INSERT INTO photos (user_id, filename, description, taken_at)
VALUES 
    (1, 'photo1.jpg', 'Description for Photo 1', '2024-03-13 10:45:00'),
    (1, 'photo2.jpg', 'Description for Photo 2', '2024-03-13 11:45:00'),
    (2, 'photo3.jpg', 'Description for Photo 3', '2024-03-13 12:45:00'),
    (3, 'photo4.jpg', 'Description for Photo 4', '2024-03-13 13:45:00'),
    (4, 'photo5.jpg', 'Description for Photo 5', '2024-03-13 14:45:00');
	 

-- ###### VIEWS

CREATE VIEW user_messages AS
SELECT m.message_id, m.user_id, c.name AS contact_name, m.contact_id, m.message_text, m.sent_at
FROM messages m
JOIN contacts c ON m.contact_id = c.contact_id
WHERE m.user_id = 1; -- Replace 1 with the desired user ID

CREATE VIEW user_apps AS
SELECT a.app_id, a.name, a.description, a.version, a.installed_at
FROM apps a
WHERE a.user_id = 1; -- Replace 1 with the desired user ID

CREATE VIEW user_notes AS
SELECT n.note_id, n.user_id, n.title, n.content, n.created_at
FROM notes n
WHERE n.user_id = 1; -- Replace 1 with the desired user ID

CREATE VIEW user_photos AS
SELECT p.photo_id, p.user_id, p.filename, p.description, p.taken_at
FROM photos p
WHERE p.user_id = 1; -- Replace 1 with the desired user ID


-- ###### SAMPLE EASY QUERIES


-- Query: Get all messages sent by a user
SELECT *
FROM messages
WHERE user_id = 1;

-- Query: Get all installed apps for a user
SELECT *
FROM apps
WHERE user_id = 1;