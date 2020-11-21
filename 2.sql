
create database 宋长河;

show databases;

use 宋长河;

describe worker;

CREATE TABLE worker
(
    职工号 CHAR(6) NOT NULL PRIMARY KEY,
    姓名 VARCHAR(8),
    性别 CHAR(2) NOT NULL DEFAULT '男',
    生日 date,
    部门号 INT(11)
);

ALTER TABLE worker
ADD
职称 CHAR(8);

-- 将姓名列的数据类型从8个字符改成16个字符

ALTER TABLE worker
MODIFY COLUMN 姓名 CHAR(16);

-- worker表结构中，请将“部门号”由原来的可以为空，改为不可以为空。
ALTER TABLE worker
MODIFY COLUMN 部门号 INT NOT NULL;

-- 8）将worker表的“职称”列改名成“工种”，数据类型不变。
ALTER TABLE worker
change 职称 工种 VARCHAR(8);

-- 删除工种

ALTER TABLE worker
DROP 工种;



-- 11


INSERT INTO worker VALUES('ZG001','宋长河','男','2000-4-15',NULL);

-- 12

INSERT INTO worker VALUES('ZGBH001','宋长河','男','2000-4-15',3);

-- 13
INSERT INTO worker VALUES('ZG001','宋长河','男','2000-4-15',3);

SELECT * FROM worker;


INSERT INTO worker VALUES('ZG001','李芳','女','1990-8-21',2);


INSERT INTO worker (职工号,姓名,部门号) VALUES('ZG003','倪军',5);

DROP TABLE worker;

DROP DATABASE 宋长河;


-- 扩展练习

CREATE DATABASE college;

CREATE TABLE teacher
(
    tno CHAR(10) PRIMARY KEY,
    tn CHAR(8),
    sex CHAR(2) NOT NULL DEFAULT '男',
    age INT(3),
    prof CHAR(6),
    sal INT(6),
    Comm INT(6),
    Dep CHAR(6)
);

CREATE TABLE student
(
    sno CHAR(10) PRIMARY KEY,
    sname CHAR(8),
    ssex CHAR(2) NOT NULL DEFAULT '男',
    sage INT(3),
    sdep CHAR(6)
);

CREATE TABLE course
(
    cno CHAR(10) PRIMARY KEY,
    cname CHAR(8),
    ccredit INT(3),
    cpno CHAR(10)
);


CREATE TABLE sc
(
    sno CHAR(10) NOT NULL REFERENCES teacher(tno),
    cno CHAR(10) NOT NULL REFERENCES course(cno),
    grade INT(3)
);

CREATE TABLE tc
(
    tno CHAR(10) NOT NULL REFERENCES teacher(tno),
    cno CHAR(10) NOT NULL REFERENCES course(cno),
);


describe tc;

SELECT * FROM tc;