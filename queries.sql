-- Student Registry Practice Queries
SET search_path = student_registry, public;

-- 1) List all students
SELECT * FROM students;

-- 2) Find a student by email
SELECT * FROM students WHERE email = 'ava.patel@example.com';

-- 3) Students ordered by last name
SELECT student_id, first_name, last_name FROM students ORDER BY last_name, first_name;

-- 4) Courses with credits >= 4
SELECT code, title, credits FROM courses WHERE credits >= 4;

-- 5) Enrollments with course and grade
SELECT s.first_name, s.last_name, c.code, e.term, COALESCE(e.grade, 'Pending') AS grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c  ON c.course_id  = e.course_id
ORDER BY s.last_name, c.code;

-- 6) Count students per course (Fall 2025)
SELECT c.code, c.title, COUNT(*) AS student_count
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
WHERE e.term = 'Fall 2025'
GROUP BY c.code, c.title
ORDER BY student_count DESC;

-- 7) Students not yet graded
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
WHERE e.grade IS NULL;

-- 8) Update a grade (example)
UPDATE enrollments SET grade = 'A-' WHERE enrollment_id = 5;

-- 9) Drop a student from a course
DELETE FROM enrollments WHERE student_id = 3 AND course_id = 2 AND term = 'Fall 2025';

-- 10) View: all student courses
SELECT * FROM v_student_courses ORDER BY last_name, code;

-- 11) Add a new course
INSERT INTO courses (code, title, credits) VALUES ('PHY101','Intro Physics',4);

-- 12) Enroll a student (with unique constraint)
INSERT INTO enrollments (student_id, course_id, term) VALUES (3, 5, 'Fall 2025');

-- 13) Find students taking 2+ courses
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS course_count
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(*) >= 2;

-- 14) Courses with no enrollments
SELECT c.*
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id
HAVING COUNT(e.enrollment_id) = 0;

-- 15) Change a student's email (validated by CHECK)
UPDATE students SET email = 'ava.p@example.com' WHERE student_id = 1;

-- 16) Transaction demo (enroll, then rollback)
BEGIN;
  INSERT INTO enrollments (student_id, course_id, term) VALUES (2, 2, 'Fall 2025');
ROLLBACK;

-- 17) Transaction commit
BEGIN;
  INSERT INTO enrollments (student_id, course_id, term) VALUES (2, 2, 'Fall 2025');
COMMIT;

-- 18) Index usage hint: explain
EXPLAIN ANALYZE SELECT * FROM students WHERE last_name = 'Garcia';

-- 19) Basic pagination
SELECT * FROM students ORDER BY student_id LIMIT 2 OFFSET 2;

-- 20) Distinct terms in the DB
SELECT DISTINCT term FROM enrollments;