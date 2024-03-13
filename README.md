# SQL-Project---SmartPhone
 
This document describes the structure of the provided sample database and includes examples of basic queries.

# Tables:

users: Stores user information including username, password hash (encrypted for security), email, phone number, email verification status, and creation timestamp.
contacts: Stores user contacts with their names, phone numbers, emails, and creation timestamp. Each contact is linked to a specific user using a foreign key.
messages: Stores message information including sender user ID, recipient contact ID, message content, and sent timestamp. Foreign keys link messages to users and contacts.
apps: Stores information about apps installed by users, including app name, description, version, installation time, and the user ID.
notes: Stores user notes with titles, content, and creation timestamps. Each note is linked to a specific user using a foreign key.
photos: Stores information about user photos, including filename, description, capture time, and the user ID.

# Sample Data:

The script includes sample data inserted into each table to demonstrate its functionality.

# Views:

user_messages: This view retrieves message details (ID, sender ID, contact name, recipient ID, message content, sent time) for a specific user (replace 1 with the desired user ID).
user_apps: This view retrieves information about apps installed by a specific user (replace 1 with the desired user ID).
user_notes: This view retrieves details about notes created by a specific user (replace 1 with the desired user ID).
user_photos: This view retrieves information about photos belonging to a specific user (replace 1 with the desired user ID).
