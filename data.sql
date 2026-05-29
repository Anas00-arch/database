-- 1. Database Initialization
DROP DATABASE IF EXISTS CatCareSystem;
CREATE DATABASE CatCareSystem;
USE CatCareSystem;

-- 2. Table Creation
CREATE TABLE Breeds (
    breed_id INT PRIMARY KEY AUTO_INCREMENT,
    breed_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Owners (
    owner_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE
);

CREATE TABLE Vets (
    vet_id INT PRIMARY KEY AUTO_INCREMENT,
    vet_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50) NOT NULL
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) DEFAULT 'General'
);

CREATE TABLE Cats (
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    breed_id INT,
    owner_id INT,
    FOREIGN KEY (breed_id) REFERENCES Breeds(breed_id),
    FOREIGN KEY (owner_id) REFERENCES Owners(owner_id)
);

CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_date DATE NOT NULL,
    diagnosis TEXT NOT NULL,
    cat_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (cat_id) REFERENCES Cats(cat_id),
    FOREIGN KEY (vet_id) REFERENCES Vets(vet_id)
);

CREATE TABLE Vaccines (
    vaccine_id INT PRIMARY KEY AUTO_INCREMENT,
    vaccine_name VARCHAR(50) NOT NULL UNIQUE,
    period_months INT CHECK (period_months > 0)
);

CREATE TABLE Vaccination_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_id INT NOT NULL,
    vaccine_id INT NOT NULL,
    vaccination_date DATE NOT NULL,
    FOREIGN KEY (cat_id) REFERENCES Cats(cat_id),
    FOREIGN KEY (vaccine_id) REFERENCES Vaccines(vaccine_id)
);

CREATE TABLE Foods (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(50) NOT NULL,
    food_type VARCHAR(50),
    stock_quantity INT DEFAULT 0
);

CREATE TABLE Appointments (
    app_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_id INT NOT NULL,
    room_id INT,
    app_date DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (cat_id) REFERENCES Cats(cat_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- 1. Breeds (15 Records)
INSERT INTO Breeds (breed_name, description) VALUES 
('Maine Coon', 'Large and friendly'), ('Bengal', 'Leopard-like spots'), ('Persian', 'Long hair, flat face'),
('Siamese', 'Vocal and social'), ('Ragdoll', 'Docile and floppy'), ('Sphynx', 'Hairless breed'),
('British Shorthair', 'Stocky and calm'), ('Abyssinian', 'Active and intelligent'), ('Burmese', 'Playful and affectionate'),
('Scottish Fold', 'Folded ears'), ('Birman', 'Silk-like coat'), ('Russian Blue', 'Silver-blue coat'),
('Siberian', 'Very thick coat'), ('Bombay', 'Solid black coat'), ('Manx', 'Tailless cat');

-- 2. Owners (15 Records)
INSERT INTO Owners (full_name, phone) VALUES 
('Ahmed Ali', '050001'), ('Sara Mansour', '050002'), ('John Doe', '050003'),
('Khalid Omar', '050004'), ('Laila Hasan', '050005'), ('Mona Saad', '050006'),
('Yousef Rami', '050007'), ('Fatima Adel', '050008'), ('Omar Fawzi', '050009'),
('Zainab Ali', '050010'), ('Hussain Kareem', '050011'), ('Rania Said', '050012'),
('Sami Jaber', '050013'), ('Noura Bader', '050014'), ('Fahad Sultan', '050015');

-- 3. Vets (15 Records)
INSERT INTO Vets (vet_name, specialization) VALUES 
('Dr. Salem', 'Surgery'), ('Dr. Nora', 'General'), ('Dr. Mike', 'Dermatology'),
('Dr. Aisha', 'Cardiology'), ('Dr. Ryan', 'Neurology'), ('Dr. Hana', 'Nutrition'),
('Dr. Paul', 'Surgery'), ('Dr. Linda', 'General'), ('Dr. Adam', 'Radiology'),
('Dr. Sofia', 'General'), ('Dr. Mark', 'Dentistry'), ('Dr. Elena', 'Behavior'),
('Dr. Tom', 'Oncology'), ('Dr. Kate', 'General'), ('Dr. Jack', 'Orthopedics');

-- 4. Rooms (15 Records)
INSERT INTO Rooms (room_number, room_type) VALUES 
('101', 'Exam'), ('102', 'Exam'), ('201', 'Surgery'), ('202', 'Surgery'),
('301', 'Recovery'), ('302', 'Recovery'), ('401', 'X-Ray'), ('402', 'Lab'),
('501', 'Grooming'), ('502', 'General'), ('601', 'ICU'), ('602', 'ICU'),
('701', 'Office'), ('702', 'Waiting'), ('801', 'Storage');

-- 5. Cats (15 Records)
INSERT INTO Cats (cat_name, gender, breed_id, owner_id) VALUES 
('Leo', 'Male', 1, 1), ('Luna', 'Female', 2, 2), ('Misty', 'Female', 3, 3),
('Simba', 'Male', 4, 4), ('Bella', 'Female', 5, 5), ('Max', 'Male', 6, 6),
('Chloe', 'Female', 7, 7), ('Charlie', 'Male', 8, 8), ('Lucy', 'Female', 9, 9),
('Oliver', 'Male', 10, 10), ('Daisy', 'Female', 11, 11), ('Rocky', 'Male', 12, 12),
('Sophie', 'Female', 13, 13), ('Toby', 'Male', 14, 14), ('Nala', 'Female', 15, 15);

-- 6. Medical Records (15 Records)
INSERT INTO Medical_Records (visit_date, diagnosis, cat_id, vet_id) VALUES 
('2026-01-10', 'Flu', 1, 2), ('2026-01-12', 'Broken Leg', 2, 1), ('2026-01-15', 'Fever', 3, 2),
('2026-02-01', 'Skin Allergy', 4, 3), ('2026-02-05', 'Checkup', 5, 10), ('2026-02-10', 'Eye Infection', 6, 2),
('2026-02-12', 'Ear Mites', 7, 2), ('2026-03-01', 'Heart Check', 8, 4), ('2026-03-05', 'Dental Clean', 9, 11),
('2026-03-10', 'Weight Issue', 10, 6), ('2026-03-15', 'X-Ray', 11, 9), ('2026-03-20', 'Surgery', 12, 7),
('2026-04-01', 'Stomach Pain', 13, 14), ('2026-04-05', 'Vaccine Prep', 14, 2), ('2026-04-10', 'General', 15, 2);

-- 7. Vaccines (15 Records)
INSERT INTO Vaccines (vaccine_name, period_months) VALUES 
('Rabies', 12), ('FVRCP', 36), ('FeLV', 12), ('Bordetella', 6), ('FIP', 12),
('Chlamydia', 12), ('Giardia', 12), ('Calicivirus', 36), ('Herpesvirus', 36),
('Panleukopenia', 36), ('Leukemia', 12), ('Toxoplasmosis', 24), ('Distemper', 12),
('Mites Shot', 3), ('Booster A', 12);

-- 8. Vaccination Log (15 Records)
INSERT INTO Vaccination_Log (cat_id, vaccine_id, vaccination_date) VALUES 
(1,1,'2026-01-01'), (2,1,'2026-01-05'), (3,2,'2026-01-10'), (4,3,'2026-02-01'), (5,4,'2026-02-10'),
(6,5,'2026-02-15'), (7,6,'2026-03-01'), (8,7,'2026-03-05'), (9,8,'2026-03-10'), (10,9,'2026-03-15'),
(11,10,'2026-03-20'), (12,11,'2026-04-01'), (13,12,'2026-04-05'), (14,13,'2026-04-10'), (15,14,'2026-04-15');

-- 9. Foods (15 Records)
INSERT INTO Foods (brand_name, food_type, stock_quantity) VALUES 
('Royal Canin', 'Dry', 50), ('Purina', 'Wet', 30), ('Whiskas', 'Dry', 40),
('Fancy Feast', 'Wet', 25), ('Hill Science', 'Dry', 20), ('Iams', 'Dry', 35),
('Meow Mix', 'Dry', 60), ('Blue Buffalo', 'Wet', 15), ('Orijen', 'Dry', 10),
('Acana', 'Dry', 12), ('Sheba', 'Wet', 45), ('Felix', 'Wet', 38),
('Friskies', 'Dry', 55), ('Nutro', 'Dry', 22), ('Wellness', 'Wet', 18);

-- 10. Appointments (15 Records)
INSERT INTO Appointments (cat_id, room_id, app_date, status) VALUES 
(1,1,'2026-05-01 09:00','Scheduled'), (2,2,'2026-05-01 10:00','Completed'), (3,3,'2026-05-02 11:00','Scheduled'),
(4,4,'2026-05-02 12:00','Scheduled'), (5,5,'2026-05-03 13:00','Cancelled'), (6,1,'2026-05-03 14:00','Scheduled'),
(7,2,'2026-05-04 09:00','Scheduled'), (8,3,'2026-05-04 10:00','Completed'), (9,4,'2026-05-05 11:00','Scheduled'),
(10,5,'2026-05-05 12:00','Scheduled'), (11,6,'2026-05-06 13:00','Scheduled'), (12,7,'2026-05-06 14:00','Scheduled'),
(13,8,'2026-05-07 15:00','Scheduled'), (14,9,'2026-05-08 09:00','Scheduled'), (15,10,'2026-05-08 10:00','Scheduled');

SELECT C.cat_name, B.breed_name, O.full_name AS Owner_Name, O.phone
FROM Cats C
JOIN Breeds B ON C.breed_id = B.breed_id
JOIN Owners O ON C.owner_id = O.owner_id;

SELECT cat_name FROM Cats 
WHERE cat_id NOT IN (SELECT DISTINCT cat_id FROM Medical_Records);

SELECT brand_name, AVG(stock_quantity) AS Avg_Stock
FROM Foods
GROUP BY brand_name;

SELECT R.room_number, R.room_type, COUNT(A.app_id) AS Total_Appointments
FROM Rooms R
LEFT JOIN Appointments A ON R.room_id = A.room_id
GROUP BY R.room_number, R.room_type;

SELECT V.vet_name, COUNT(M.record_id) AS Diagnosis_Count
FROM Vets V
JOIN Medical_Records M ON V.vet_id = M.vet_id
GROUP BY V.vet_name
HAVING Diagnosis_Count > 2;

-- استعراض كافة بيانات جداول مشروع CatCareSystem

-- 1. جدول الفصائل
SELECT * FROM Breeds;

-- 2. جدول الملاك
SELECT * FROM Owners;

-- 3. جدول الأطباء البيطريين
SELECT * FROM Vets;

-- 4. جدول الغرف والعيادات
SELECT * FROM Rooms;

-- 5. جدول القطط
SELECT * FROM Cats;

-- 6. جدول السجلات الطبية والتشخيصات
SELECT * FROM Medical_Records;

-- 7. جدول أنواع التطعيمات
SELECT * FROM Vaccines;

-- 8. جدول سجل تطعيمات القطط
SELECT * FROM Vaccination_Log;

-- 9. جدول مخزون الطعام
SELECT * FROM Foods;

-- 10. جدول المواعيد
SELECT * FROM Appointments;