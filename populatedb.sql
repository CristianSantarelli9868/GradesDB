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
(3, '00000003C', 'Fernando', 'Sola', 28, 'fsola@us.es'),
(4, '00000004D', 'Carlos', 'García', 35, 'cgarcia@us.es'),
(5, '00000005E', 'María', 'López', 29, 'mlopez@us.es'),
(6, '00000006F', 'Juan', 'Pérez', 20, 'jperez@alum.us.es'),
(7, '00000007G', 'Ana', 'Martín', 21, 'amartin@alum.us.es'),
(8, '00000008H', 'Luis', 'Gómez', 19, 'lgomez@alum.us.es'),
(9, '00000009I', 'Elena', 'Vázquez', 22, 'evazquez@alum.us.es'),
(10, '00000010J', 'Pablo', 'Romero', 20, 'promero@alum.us.es');

INSERT INTO professors (professor_id, category) VALUES
(1, 'Catedrático'),
(2, 'Titular'),
(3, 'Sustituto'),
(4, 'Titular'),
(5, 'Ayudante Doctor');

INSERT INTO students (student_id, access_method) VALUES
(6, 'Selectividad'),
(7, 'Ciclo Formativo'),
(8, 'Selectividad'),
(9, 'Mayor de 25'),
(10, 'Selectividad');

INSERT INTO degrees (degree_id, degree_name, years) VALUES
(1, 'Grado en Ingeniería Informática - Software', 4),
(2, 'Grado en Ingeniería Informática - Computadores', 4),
(3, 'Grado en Ingeniería de la Salud', 4);

INSERT INTO subjects (subject_id, degree_id, subject_name, acronym, credits, course, subject_type) VALUES
(1, 1, 'Introducción a la Programación', 'IP', 12, 1, 'Formación Básica'),
(2, 1, 'Ingeniería del Software e Integración de Sistemas 1', 'IISSI-1', 6, 2, 'Obligatoria'),
(3, 1, 'Bases de Datos', 'BD', 6, 2, 'Obligatoria'),
(4, 3, 'Bioinformática', 'BIO', 6, 3, 'Obligatoria');

INSERT INTO groups (group_id, subject_id, group_name, activity, academic_year) VALUES
(1, 2, 'Grupo 1', 'Teoría', 2024),
(2, 2, 'Grupo 1 - Lab', 'Laboratorio', 2024),
(3, 3, 'Grupo 1', 'Teoría', 2024),
(4, 1, 'Grupo 1', 'Teoría', 2023);

INSERT INTO teaching_loads (professor_id, group_id, credits) VALUES
(1, 1, 3.0),
(2, 2, 3.0),
(3, 3, 4.5);

INSERT INTO group_enrollments (student_id, group_id) VALUES
(6, 1),
(6, 2),
(7, 1),
(7, 2),
(8, 3);

INSERT INTO subject_enrollments (student_id, subject_id) VALUES
(6, 2),
(7, 2),
(8, 3);

INSERT INTO grades (student_id, group_id, grade_value, exam_call, with_honors) VALUES
(6, 1, 8.5, 'Primera', 0),
(7, 1, 9.8, 'Primera', 1),
(8, 3, 4.0, 'Primera', 0),
(8, 3, 7.0, 'Segunda', 0);
