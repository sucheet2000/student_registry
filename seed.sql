-- Student Registry Seed Data
SET search_path = student_registry, public;

INSERT INTO students (first_name, last_name, email) VALUES
('Ava','Patel','ava.patel@example.com'),
('Noah','Kim','noah.kim@example.com'),
('Liam','Nguyen','liam.nguyen@example.com'),
('Emma','Garcia','emma.garcia@example.com');

INSERT INTO courses (code, title, credits) VALUES
('CS101','Intro to Computer Science',3),
('MATH201','Discrete Mathematics',4),
('ENG150','Academic Writing',3),
('HIST110','World History',3);

INSERT INTO enrollments (student_id, course_id, term, grade) VALUES
(1,1,'Fall 2025','A'),
(1,2,'Fall 2025','B+'),
(2,1,'Fall 2025','B'),
(2,3,'Fall 2025','A-'),
(3,2,'Fall 2025',NULL),
(4,1,'Fall 2025','A'),
(4,4,'Fall 2025','B');