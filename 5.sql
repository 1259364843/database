-- 2.1
INSERT INTO TEACHER
VALUES ('T60','刘绪良','1987/5/18','男','讲师',0,3780)

SELECT* FROM TEACHER WHERE 工号 = 'T61';

-- 2.2
INSERT INTO TEACHER (工号,姓名,婚否,生日)
VALUES ('T61','周源彬',1,'1978/2/16');

-- 2.3
INSERT INTO student (学号,姓名,性别,年龄,系别,身高)
VALUES ('S800','李蓓蓓','女',19,'自动化',164);

SELECT* FROM student WHERE 学号 = 'S800';

-- 2.4
INSERT INTO student (学号,姓名)
VALUES ('S810','郑勇军');

SELECT* FROM student WHERE 学号 = 'S810';



-- 2.1

SELECT 工资 FROM teacher;

UPDATE teacher
SET 工资 = 工资 - 200;

-- 2.2  将吴浩老师的职称改为讲师，生日改成1978-5-13

SELECT * FROM teacher WHERE 姓名 = '吴浩';


UPDATE TEACHER
SET 生日 = '1978-5-13', 职称 = '讲师'
WHERE 姓名 = '吴浩';

-- 2.3 将有课老师的工资增加300

SELECT 姓名,工资 FROM teacher;

SELECT * FROM teacher
WHERE 工号 IN (
    SELECT 任课教师编号 FROM course
);

UPDATE TEACHER
SET 工资 = 工资 + 300
WHERE 工号 IN (
    SELECT 任课教师编号 FROM course
);

-- 2.4 -- 将student表中所有学生的身高置为100
SELECT 姓名,身高 FROM student;

UPDATE student
SET 身高 = 100;

-- 2.5  -- 将student表中计算机系的学生的身高增加20%,年龄增加2。

SELECT 姓名,身高,年龄,系别 FROM student WHERE 系别 = '计算机';


UPDATE student
SET 身高 = 身高*1.2, 年龄 = 年龄+2
WHERE 系别 = '计算机'


-- 2.6 -- 将学习了“数据库原理”课程的学生的年龄修改为0。
	-- 请自行设计如何验证结果

SELECT * FROM student
WHERE 学号 IN (
    SELECT 学号 FROM score WHERE 课号 = (
        SELECT 课号 FROM course WHERE 课名 = '数据库原理'
    )
);

UPDATE student
SET 年龄 = 0
WHERE 学号 IN (
    SELECT 学号 FROM score WHERE 课号 = (
        SELECT 课号 FROM course WHERE 课名 = '数据库原理'
    )
);


-- 3.1 删除前面增加的那位叫“周源彬”的老师。
DELETE FROM TEACHER WHERE 姓名 = '周源彬';

SELECT * FROM TEACHER WHERE 姓名 = '周源彬';

-- 3.2  删除没课的老师


SELECT * FROM TEACHER WHERE 工号 NOT IN 
(SELECT 任课教师编号 FROM COURSE);

DELETE FROM TEACHER WHERE 工号 NOT IN 
(SELECT 任课教师编号 FROM COURSE);


-- 3.3 删除所有老师

DELETE FROM TEACHER;

SHOW CREATE TABLE teacher


-- 删除外键约束
ALTER TABLE course DROP FOREIGN KEY fk_js;


DELETE FROM TEACHER WHERE 工号 IN (
    SELECT 任课教师编号 FROM course
);



-- 3.4 删除student表中叫“刘维君”的学生
SELECT * FROM student WHERE 姓名 = '刘维君';

DELETE FROM student WHERE 姓名 = '刘维君';

-- 3.5  删除student表中那些一门课成绩都没有的同学


SELECT * FROM student WHERE 学号 NOT IN (
    SELECT 学号 FROM score
);


DELETE FROM student WHERE 学号 NOT IN (
    SELECT 学号 FROM score
);

-- 如何用一条SQL命令实现将黄河同学选修了高等数学得了82分增加进score表？

INSERT INTO score (学号,课号,成绩)
VALUES((SELECT 学号 FROM student WHERE 姓名='黄河'),(SELECT 课号 FROM course WHERE 课名 = '高等数学'),82);




-- 附加题
-- 将生肖和今年相同的老师的工资增加300

SELECT * FROM teacher
WHERE YEAR(生日) MOD 12 = YEAR(NOW()) MOD 12;

UPDATE teacher
SET 工资 = 工资 + 300
WHERE YEAR(生日) MOD 12 = YEAR(NOW()) MOD 12;