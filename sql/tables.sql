CREATE SCHEMA AUTHORIZATION moita_app;

SET search_path TO moita_app;

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS company;

CREATE TABLE moita_app.company (
    id INT,
    name VARCHAR(50),
    PRIMARY KEY (id)
);

CREATE TABLE employee (
    id INT PRIMARY KEY,
    company_id INT REFERENCES company (id),
    name VARCHAR(30) NOT NULL,
    surname VARCHAR(30) NOT NULL
);

INSERT INTO company (id, name) VALUES (1, 'Luxoft');
INSERT INTO company (id, name) VALUES (2, 'UBS');

INSERT INTO employee (id, name, surname, company_id) VALUES (1, 'Raphael', 'Moita', 1);
INSERT INTO employee (id, name, surname, company_id) VALUES (2, 'Mariana', 'Moita', 2);

SELECT e.name || ' ' ||e.surname as employee, c.name as company
FROM employee e
JOIN company c
ON e.company_id = c.id
WHERE c.name = 'UBS';
