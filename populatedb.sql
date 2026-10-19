USE grados;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM teaching_loads;
DELETE FROM subject_enrollments;
DELETE FROM grades;
DELETE FROM group_enrollments;
DELETE FROM groups;
DELETE FROM subjects;
DELETE FROM degrees;
DELETE FROM students;
DELETE FROM professors;
DELETE FROM people;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO people (person_id, dni, first_name, last_name, age, email) VALUES
(1, '00000001A', 'David', 'Ruiz', 50, 'druiz@us.es'),
(2, '00000002B', 'Inma', 'Hernández', 40, 'inmahernandez@us.es'),
(3, '00000003C', 'Fernando', 'Sola', 28,Ecco il codice completo per **`populatedb.sql`**, completamente ripulito da ogni commento:

```sql
USE grados;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM teaching_loads;
DELETE FROM subject_enrollments;
DELETE FROM grades;
DELETE FROM group_enrollments;
DELETE FROM groups;
DELETE FROM subjects;
DELETE FROM degrees;
DELETE FROM students;
DELETE FROM professors;
DELETE FROM people;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO people (person_id, dni, first_name, last_name, age, email) VALUES
(1, '00000001A', 'David', 'Ruiz', 50, 'druiz@us.es'),
(2, '00000002B', 'Inma', 'Hernández', 40, 'inmahernandez@us.es'),
(3, '00000003C', 'Fernando',