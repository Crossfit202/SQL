-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_code` VARCHAR(10) NULL,
  `department_name` VARCHAR(45) NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`, `college_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NULL,
  `course_title` VARCHAR(45) NULL,
  `credits` INT NULL,
  `department_id` INT NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `department_id`, `college_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC, `college_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id` , `college_id`)
    REFERENCES `university`.`department` (`department_id` , `college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(45) NULL,
  `year` YEAR NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`teacher` ;

CREATE TABLE IF NOT EXISTS `university`.`teacher` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT,
  `teacher_fname` VARCHAR(45) NULL,
  `teacher_lname` VARCHAR(45) NULL,
  PRIMARY KEY (`teacher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_num` INT NULL,
  `capacity` INT NULL,
  `course_id` INT NOT NULL,
  `department_id` INT NOT NULL,
  `college_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `course_id`, `department_id`, `college_id`, `term_id`, `teacher_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC, `department_id` ASC, `college_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id` , `department_id` , `college_id`)
    REFERENCES `university`.`course` (`course_id` , `department_id` , `college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `university`.`teacher` (`teacher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` ENUM('M', 'F') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(2) NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE university;

INSERT INTO college (college_name) VALUES
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');

INSERT INTO department (department_id, department_code, department_name, college_id) VALUES
(1, 'CIT', 'Computer Information Technology', 1),
(2, 'ECON', 'Economics', 2),
(3, 'HUM', 'Humanities and Philosophy', 3);

INSERT INTO course (course_num, course_title, credits, department_id, college_id) VALUES
(111, 'Intro to Databases', 3, 1, 1),
(388, 'Econometrics', 4, 2, 2),
(150, 'Micro Economics', 3, 2, 2),
(376, 'Classical Heritage', 2, 3, 3);

INSERT INTO term (term_name, year) VALUES
('Fall', 2019),
('Winter', 2018);

INSERT INTO teacher (teacher_fname, teacher_lname)
VALUES
    ('Marty', 'Morring'),
    ('Nate', 'Norris'),
    ('Ben', 'Barrus'),
    ('John', 'Jensen'),
    ('Bill', 'Barney');

INSERT INTO section (section_num, capacity, course_id, department_id, college_id, term_id, teacher_id) VALUES
(1, 30, 1, 1, 1, 1, 1),
(1, 50, 3, 2, 2, 1, 2),
(2, 50, 3, 2, 2, 1, 2),
(1, 35, 2, 2, 2, 1, 3),
(1, 30, 4, 3, 3, 1, 4),
(2, 30, 1, 1, 1, 2, 1),
(3, 35, 1, 1, 1, 2, 5),
(1, 50, 3, 2, 2, 2, 2),
(2, 50, 3, 2, 2, 2, 2),
(1, 30, 4, 3, 3, 2, 4);


INSERT INTO student (first_name, last_name, gender, city, state, birthdate) VALUES
('Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
('Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
('Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
('Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
('Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
('Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
('Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
('Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
('Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
('Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

INSERT INTO enrollment (section_id, student_id) VALUES
(7,6),
(6,7),
(8,7),
(10,7),
(5,4),
(9,9),
(4,2),
(4,3),
(4,5),
(5,5),
(1,1),
(3,1),
(9,8),
(6,10);

-- Query 1
SELECT first_name AS 'fname', last_name AS 'lname', DATE_FORMAT(birthdate, '%M %e, %Y') AS 'Sept Birthdays'
FROM student
WHERE
    MONTH(birthdate) = 9
ORDER BY last_name;

-- Query 2
SELECT last_name, first_name, FLOOR((DATEDIFF('2017-01-05', birthdate) / 365)) AS 'Years', (DATEDIFF('2017-01-05', birthdate) % 365) AS 'Days',
CONCAT(FLOOR((DATEDIFF('2017-01-05', birthdate) / 365)), ' - Yrs, ', (DATEDIFF('2017-01-05', birthdate) % 365), ' - Days') AS 'Years and Days'
FROM student
ORDER BY Years DESC, Days DESC;


-- Query 3
SELECT s.first_name, s.last_name
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN section sec ON e.section_id = sec.section_id
INNER JOIN teacher t ON sec.teacher_id = t.teacher_id
WHERE t.teacher_lname = 'Jensen'
ORDER BY s.last_name;


-- Query 4 
SELECT t.teacher_fname, t.teacher_lname
FROM teacher t
JOIN section s ON t.teacher_id = s.teacher_id
JOIN enrollment e ON e.section_id = s.section_id
JOIN student st ON st.student_id = e.student_id
JOIN term ON term.term_id = s.term_id
WHERE st.first_name = 'Bryce'
    AND term.term_name = 'Winter'
    AND term.year = 2018
ORDER BY t.teacher_lname;


-- Query 5
SELECT s.first_name, s.last_name
FROM student s
	JOIN
		enrollment e 
		ON s.student_id = e.student_id
	JOIN
		section sec 
		ON e.section_id = sec.section_id
	JOIN
		course c 
			ON sec.course_id = c.course_id AND sec.department_id = c.department_id AND sec.college_id = c.college_id
	JOIN
		term t 
			ON sec.term_id = t.term_id
WHERE
    c.course_title = 'Econometrics'
    AND t.term_name = 'Fall'
    AND t.year = 2019
ORDER BY
    s.last_name;

-- Query 6
SELECT d.department_code, c.course_num, c.course_title
FROM course c
	JOIN
		section sec 
			ON c.course_id = sec.course_id
	JOIN
		department d 
			ON sec.department_id = d.department_id
	JOIN
		college co 
			ON sec.college_id = co.college_id
	JOIN
		term t 
			ON sec.term_id = t.term_id
	JOIN
		enrollment e 
			ON sec.section_id = e.section_id
	JOIN
		student s 
			ON e.student_id = s.student_id
WHERE s.last_name = 'Carlson' AND s.first_name = 'Bryce' AND t.year = 2018 AND t.term_name = 'Winter'
ORDER BY c.course_title;

-- Query 7
SELECT term_name AS 'term', year, COUNT(e.student_id) AS 'enrollment'
FROM enrollment e
INNER JOIN section sec ON e.section_id = sec.section_id
INNER JOIN term t ON sec.term_id = t.term_id
WHERE t.term_name = 'Fall' AND t.year = 2019;


-- Query 8
SELECT c.college_name, COUNT(DISTINCT crs.course_id) AS course_count
FROM college c
LEFT JOIN department d ON c.college_id = d.college_id
LEFT JOIN course crs ON d.department_id = crs.department_id
GROUP BY c.college_id
ORDER BY c.college_name;

-- Query 9 
SELECT t.teacher_fname, t.teacher_lname, SUM(s.capacity) AS 'TeachingCapacity'
FROM teacher t
INNER JOIN section s ON t.teacher_id = s.teacher_id
INNER JOIN term ter ON s.term_id = ter.term_id
WHERE ter.term_name = 'Winter' AND ter.year = 2018
GROUP BY t.teacher_id
ORDER BY TeachingCapacity;

-- Query 10
SELECT s.last_name, s.first_name, SUM(c.credits) AS total_credit_load
FROM student s
INNER JOIN enrollment e ON s.student_id = e.student_id
INNER JOIN section sec ON e.section_id = sec.section_id
INNER JOIN course c ON sec.course_id = c.course_id
INNER JOIN term t ON sec.term_id = t.term_id
WHERE t.term_name = 'Fall' AND t.year = 2019
GROUP BY s.student_id
HAVING total_credit_load > 3
ORDER BY total_credit_load DESC;




