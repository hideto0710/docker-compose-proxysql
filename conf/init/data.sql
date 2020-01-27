CREATE DATABASE IF NOT EXISTS sample;
CREATE TABLE IF NOT EXISTS sample.users(
    id int(11) NOT NULL, 
    name varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE USER IF NOT EXISTS 'sample'@'%' IDENTIFIED BY 'password';
GRANT ALL ON sample.users TO 'sample'@'%';
