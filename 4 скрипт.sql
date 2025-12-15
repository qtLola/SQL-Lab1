DROP DATABASE if exists company;
create database company;
USE company;
CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int NOT NULL,
	`user_name` varchar(30) NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`position` varchar(30) NULL,
	`last_name` varchar(30) NOT NULL,
	`employment_date` date NOT NULL,
	`department_id` int,
	`manager_id` int,
	`rate` float NOT NULL,
	`bonus` float,
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `department` (
	`department_id` int NOT NULL,
	`department_name` varchar(30) NOT NULL,
	`city` varchar(30) NOT NULL,
	`street` varchar(40) NOT NULL,
	`building_no` int NOT NULL,
	PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `product` (
	`product_id` int NOT NULL,
	`product_name` varchar(40) NOT NULL,
	`product_description` varchar(150) NOT NULL,
	`category` varchar(15) NOT NULL,
	`manufacture` varchar(30) NOT NULL,
	`product_type` varchar(15) NOT NULL,
	`amount` int NOT NULL,
	`price` float NOT NULL,
	PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `customer` (
	`customer_id` int AUTO_INCREMENT NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`gender` varchar(1) NOT NULL,
	`birth_date` date NOT NULL,
	`phone_number` bigint(15) NOT NULL,
	`email` varchar(50) NOT NULL,
	`discount` int NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `orders` (
	`orders_id` int AUTO_INCREMENT NOT NULL,
	`employee_id` int NOT NULL,
	`product_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`transaction_type` int NOT NULL,
	`transaction_moment` datetime NOT NULL,
	`amount` int NOT NULL,
	PRIMARY KEY (`orders_id`)
);
Create table if not exists `invoice` (
`invoice_id` bigint(15) not null,
`employee_id` int not null,
`customer_id` int,
`payment_method` int not null,
`transaction_moment` datetime not null,
`status` varchar(10) not null
);

ALTER TABLE employee
  ADD CONSTRAINT employee_fk6
  FOREIGN KEY (department_id) REFERENCES department(department_id);

ALTER TABLE employee
  ADD CONSTRAINT employee_fk7
  FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE orders
  ADD CONSTRAINT orders_fk1
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id);

ALTER TABLE orders
  ADD CONSTRAINT orders_fk2
  FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE orders
  ADD CONSTRAINT orders_fk3
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders ADD invoice_id BIGINT(15) NOT NULL;
ALTER TABLE orders ADD order_datetime DATETIME NOT NULL;
ALTER TABLE orders ADD quantity INT NOT NULL;

ALTER TABLE orders DROP COLUMN transaction_type;
ALTER TABLE orders DROP COLUMN transaction_moment;
ALTER TABLE orders DROP COLUMN amount;

ALTER TABLE customer MODIFY COLUMN phone_number BIGINT(15) NOT NULL;

ALTER TABLE department MODIFY COLUMN street VARCHAR(50) NOT NULL;
ALTER TABLE department MODIFY COLUMN building_no INT(4);
ALTER TABLE department MODIFY COLUMN city VARCHAR(30) NOT NULL DEFAULT 'Lviv';

ALTER TABLE employee ADD CONSTRAINT uq_employee_username UNIQUE (user_name);

ALTER TABLE invoice
  ADD PRIMARY KEY (invoice_id);

ALTER TABLE invoice
  ADD CONSTRAINT invoice_fk_employee
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
  ADD CONSTRAINT invoice_fk_customer
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders DROP FOREIGN KEY orders_fk1;
ALTER TABLE orders DROP FOREIGN KEY orders_fk3;

ALTER TABLE orders
  DROP COLUMN employee_id,
  DROP COLUMN customer_id;

ALTER TABLE orders
  ADD CONSTRAINT orders_fk_invoice
  FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id);
  ALTER TABLE customer
MODIFY COLUMN phone_number VARCHAR(20) NOT NULL;
ALTER TABLE invoice
MODIFY COLUMN employee_id INT NULL;

SELECT * FROM department;
    SELECT * FROM employee;
    SELECT * FROM customer;
    SELECT * FROM product;
    SELECT * FROM invoice;
    SELECT * FROM orders;

    USE company;
    SELECT *
    FROM customer 
    Order by last_name ASC;
    
    -- Вивести унікальні назви виробників (manufacture ) з таблиці продуктів в одному запиті, впорядкованому
-- за алфавітом

SELECT DISTINCT manufacture
FROM product
ORDER BY manufacture ASC;
 
-- Отримати коротку інформацію про продукти (назва_продукту, виробник, категорія, тип_продукту, ціна),
-- ироблені компанією 'DELL', з таблиці продуктів в одному запиті, впорядкованому за назвою продукту в 
-- алфавітному порядку. 

SELECT product_name, manufacture, category, product_type, price
FROM product
WHERE manufacture = 'DELL'
ORDER BY product_name ASC;

-- Отримати інформацію про клієнтів-жінок 1990-2000 років народження (ім'я, прізвище, стать, дата
-- народження, номер телефону) з таблиці customer в одному запиті, відсортовану за прізвищем в
-- алфавітному порядку.
SELECT first_name, last_name, gender, birth_date, phone_number
FROM customer
WHERE gender = 'F'
AND birth_date BETWEEN '1990-01-01' AND '2000-12-31'
ORDER BY last_name ASC;

-- Отримати інформацію з таблиці товарів про наявні на складі ноутбуки, які оснащені дисковими
-- накопичувачами об'ємом 512 ГБ.

SELECT *
FROM product
WHERE category = 'NOTEBOOK'
AND product_description LIKE '%512GB%'
AND amount > 0;

-- Отримати інформацію з таблиці товарів про наявні на складі ноутбуки або настільні комп'ютери, які
-- оснащені дисковими накопичувачами 512 ГБ або 1 ТБ.

SELECT *
FROM product
WHERE category IN ('NOTEBOOK', 'Desktops')
AND (product_description LIKE '%512GB%' OR product_description LIKE '%1TB%')
AND amount > 0;

