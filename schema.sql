-- Student Registry Schema (PostgreSQL)

DROP SCHEMA IF EXISTS student_registry CASCADE;
CREATE SCHEMA student_registry;
SET search_path = student_registry, public;

-- Core tables
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name  TEXT NOT NULL,
  email      TEXT UNIQUE NOT NULL CHECK (position('@' IN email) > 1),
  enrolled_on DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  code      TEXT NOT NULL UNIQUE, -- e.g., CS101
  title     TEXT NOT NULL,
  credits   INT  NOT NULL CHECK (credits BETWEEN 1 AND 6)
);

-- Many-to-many: enrollments
CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
  course_id  INT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
  term       TEXT NOT NULL, -- e.g., 'Fall 2025'
  grade      TEXT, -- e.g., 'A', 'B+'
  CONSTRAINT uq_enrollment UNIQUE (student_id, course_id, term)
);

-- Simple index for quick lookups by last name
CREATE INDEX idx_students_last_name ON students(last_name);

-- Helpful view: student -> courses with grades
CREATE OR REPLACE VIEW v_student_courses AS
SELECT s.student_id, s.first_name, s.last_name, c.code, c.title, e.term, e.grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
JOIN courses c ON c.course_id = e.course_id;