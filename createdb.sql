USE grados;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS teaching_loads;
DROP TABLE IF EXISTS subject_enrollments;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS group_enrollments;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS degrees;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS asignaturas;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE people (
    person_id INT AUTO_INCREMENT,
    dni CHAR(9) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(150) NOT NULL,
    age TINYINT NOT NULL,
    email VARCHAR(255) NOT NULL,
    PRIMARY KEY (person_id)
);

CREATE TABLE professors (
    professor_id INT,
    category VARCHAR(30) NOT NULL,
    PRIMARY KEY (professor_id),
    FOREIGN KEY (professor_id) REFERENCES people (person_id)
);

CREATE TABLE students (
    student_id INT,
    access_method VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id),
    FOREIGN KEY (student_id) REFERENCES people (person_id)
);

CREATE TABLE degrees (
    degree_id INT AUTO_INCREMENT,
    degree_name VARCHAR(80) NOT NULL,
    duration_years TINYINT NOT NULL,
    PRIMARY KEY (degree_id)
);

CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT,
    degree_id INT NOT NULL,
    subject_name VARCHAR(120) NOT NULL,
    acronym VARCHAR(12) NOT NULL,
    credits TINYINT NOT NULL,
    course TINYINT NOT NULL,
    subject_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (subject_id),
    FOREIGN KEY (degree_id) REFERENCES degrees (degree_id)
);

CREATE TABLE groups (
    group_id INT AUTO_INCREMENT,
    subject_id INT NOT NULL,
    group_name VARCHAR(40) NOT NULL,
    activity VARCHAR(15) NOT NULL,
    academic_year YEAR NOT NULL,
    PRIMARY KEY (group_id),
    FOREIGN KEY (subject_id) REFERENCES subjects (subject_id) ON DELETE CASCADE
);

CREATE TABLE group_enrollments (
    student_id INT,
    group_id INT,
    PRIMARY KEY (student_id, group_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (group_id) REFERENCES groups (group_id)
);

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT,
    student_id INT NOT NULL,
    group_id INT NOT NULL,
    grade_value DECIMAL(4,2) NOT NULL,
    exam_call VARCHAR(20) NOT NULL,
    with_honors BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (grade_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (group_id) REFERENCES groups (group_id)
);

CREATE TABLE subject_enrollments (
    student_id INT,
    subject_id INT,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);

CREATE TABLE teaching_loads (
    professor_id INT,
    group_id INT,
    credits DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (professor_id, group_id),
    FOREIGN KEY (professor_id) REFERENCES professors (professor_id),
    FOREIGN KEY (group_id) REFERENCES groups (group_id)
);

CREATE TABLE IF NOT EXISTS asignaturas (
    asignaturaId INT(11) NOT NULL AUTO_INCREMENT,
    curso INT(11) DEFAULT NULL,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(7) NOT NULL,
    creditos INT(11) NOT NULL,
    tipo ENUM('Formación Básica','Obligatoria','Optativa','Trabajo fin de grado') NOT NULL,
    departamento VARCHAR(255) NOT NULL,
    vigencia TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (asignaturaId)
);

DROP PROCEDURE IF EXISTS spInsertarAsignatura;
DELIMITER //
CREATE PROCEDURE spInsertarAsignatura(
    IN curso INT,
    IN nombre VARCHAR(255),
    IN codigo VARCHAR(7),
    IN creditos INT,
    IN tipo VARCHAR(31),
    IN departamento VARCHAR(255),
    IN vigencia TINYINT
)
BEGIN
    INSERT INTO asignaturas(curso, nombre, codigo, creditos, tipo, departamento, vigencia)
    VALUES (curso, nombre, codigo, creditos, tipo, departamento, vigencia);
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS spInsertarDatosAsignaturas;
DELIMITER //
CREATE PROCEDURE spInsertarDatosAsignaturas()
BEGIN
CALL spInsertarAsignatura('1', 'Álgebra Lineal y Numérica', '2060006', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Cálculo Infinitesimal y Numérico', '2060003', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Administración de Empresas', '2060002', '6', 'Formación Básica', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('1', 'Circuitos Electrónicos Digitales', '2060004', '6', 'Formación Básica', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('1', 'Estadística', '2060007', '6', 'Formación Básica', 'ESTADÍSTICA E INVESTIGACIÓN OPERATIVA', '1');
CALL spInsertarAsignatura('1', 'Estructura de Computadores', '2060008', '6', 'Formación Básica', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('1', 'Fundamentos de Programación', '2060001', '12', 'Formación Básica', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('1', 'Fundamentos Físicos de la Informática', '2060009', '6', 'Formación Básica', 'FÍSICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Introducción a la Matemática Discreta', '2060005', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('2', 'Análisis y Diseño de Datos y Algoritmos', '2060010', '12', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Lógica Informática', '2060012', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('2', 'Matemática Discreta', '2060013', '6', 'Obligatoria', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('2', 'Redes de Computadores', '2060014', '6', 'Obligatoria', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('2', 'Arquitectura de Computadores', '2060015', '6', 'Obligatoria', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('2', 'Arquitectura de Redes', '2060016', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('2', 'Sistemas Operativos', '2060017', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Introducción a la Ingeniería del Software y los Sistemas de Información I', '2060054', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Introducción a la Ingeniería del Software y los Sistemas de Información II', '2060055', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Configuración Implementación y Mantenimiento de Sistemas Informáticos', '2060018', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('3', 'Gestión de Sistemas de Información', '2060019', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Gestión y Estrategia Empresarial', '2060020', '6', 'Optativa', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('3', 'Inteligencia Artificial', '2060021', '6', 'Obligatoria', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Procesadores de Lenguajes', '2060022', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Programación Declarativa', '2060023', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Tecnologías Avanzadas de la Información', '2060024', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('3', 'Ampliación de Inteligencia Artificial', '2060025', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Arquitectura de Sistemas Distribuidos', '2060026', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('3', 'Matemática Aplicada a Sistemas de Información', '2060027', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('3', 'Sistemas de Información Empresiales', '2060028', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Sistemas Inteligentes', '2060029', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Sistemas Orientados a Servicios', '2060030', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Prácticas Externas', '2060031', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Acceso Inteligente a la Información', '2060032', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Administración de Sistemas de Información', '2060033', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Gestión de Procesos y Servicios', '2060034', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Infraestructura de Sistemas de Información', '2060035', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Integración de Sistemas Físicos e Informáticos', '2060036', '6', 'Optativa', 'FÍSICA APLICADA I', '0');
CALL spInsertarAsignatura('4', 'Interacción Persona-ordenador', '2060037', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Matemática Aplicada a Tecnologías de la Información', '2060038', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Matemáticas para la Computación', '2060039', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Planificación y Gestión de Proyectos Informáticos', '2060040', '6', 'Obligatoria', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Procesamiento de Imágenes Digitales', '2060041', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Seguridad en Sistemas Informáticos y en Internet', '2060042', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Teledetección', '2060043', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Aplicaciones de Soft Computing', '2060044', '6', 'Optativa', 'ELECTRÓNICA Y ELECTROMAGNETISMO', '1');
CALL spInsertarAsignatura('4', 'Computación Móvil', '2060045', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('4', 'Criptografía', '2060046', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Estadística Computacional', '2060047', '6', 'Optativa', 'ESTADÍSTICA E INVESTIGACIÓN OPERATIVA', '1');
CALL spInsertarAsignatura('4', 'Gestión de la Producción', '2060048', '6', 'Optativa', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('4', 'Inteligencia Empresarial', '2060049', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Modelado y Análisis de Requisitos en Sistemas de Información', '2060050', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Modelos de Computación y Complejidad', '2060051', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('4', 'Tecnología Informática y Sociedad', '2060052', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Trabajo Fin de Grado', '2060053', '12', 'Trabajo fin de grado', 'TECNOLOGÍA ELECTRÓNICA', '1');
END//
DELIMITER ;

CALL spInsertarDatosAsignaturas();

ALTER TABLE people
    ADD CONSTRAINT rn12_people_age CHECK (age BETWEEN 16 AND 70),
    ADD CONSTRAINT rn14_people_dni CHECK (dni REGEXP '^[0-9]{8}[A-Za-z]$'),
    ADD CONSTRAINT rn_uq_people_dni UNIQUE (dni),
    ADD CONSTRAINT rn_uq_people_email UNIQUE (email);

ALTER TABLE professors
    ADD CONSTRAINT ck_professors_category CHECK (
        category IN ('Ayudante', 'Ayudante Doctor', 'Titular', 'Catedrático')
    );

ALTER TABLE students
    ADD CONSTRAINT ck_students_access_method CHECK (
        access_method IN ('Selectividad', 'Ciclo', 'Mayor', 'Titulado', 'Extranjero')
    );

ALTER TABLE degrees
    ADD CONSTRAINT rn13_degree_duration CHECK (duration_years BETWEEN 3 AND 6),
    ADD CONSTRAINT rn_uq_degrees_name UNIQUE (degree_name);

ALTER TABLE subjects
    ADD CONSTRAINT rn10_subjects_credits CHECK (credits IN (6, 12)),
    ADD CONSTRAINT rn16_subjects_course CHECK (course BETWEEN 1 AND 6),
    ADD CONSTRAINT ck_subjects_type CHECK (
        subject_type IN ('Formación Básica', 'Obligatoria', 'Optativa')
    ),
    ADD CONSTRAINT rn_uq_subjects_name UNIQUE (subject_name),
    ADD CONSTRAINT rn_uq_subjects_acronym UNIQUE (acronym);

ALTER TABLE groups
    ADD CONSTRAINT rn15_groups_year CHECK (academic_year BETWEEN 2000 AND 2100),
    ADD CONSTRAINT ck_groups_activity CHECK (
        activity IN ('Teoría', 'Laboratorio')
    ),
    ADD CONSTRAINT rn_uq_groups_name UNIQUE (subject_id, group_name, academic_year);

ALTER TABLE teaching_loads
    ADD CONSTRAINT ck_teaching_loads_credits CHECK (credits > 0);

ALTER TABLE grades
    ADD CONSTRAINT rn11_grades_value CHECK (grade_value BETWEEN 0 AND 10),
    ADD CONSTRAINT rn01_grades_with_honors CHECK (
        with_honors = 0 OR grade_value >= 9
    ),
    ADD CONSTRAINT rn18_grades_exam_call CHECK (
        exam_call IN ('Primera', 'Segunda', 'Tercera', 'Extraordinaria')
    );