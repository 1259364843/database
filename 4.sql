INSERT INTO teacher
VALUES ('T60','宋长河','4-15-2000','男','讲师',0,5000);


INSERT INTO teacher(工号,姓名,婚否,生日)
VALUES ('T61','宋长河',0,'4-15-2000');

INSERT INTO teacher(姓名,工号,生日,婚否)
VALUES ('宋长河','T62','4-12-2000',0);


INSERT INTO student(系别,姓名,性别,年龄,学号,身高)
VALUES ('计算机系','宋长河','男',20,'201803607',170);




-- update
UPDATE teacher
SET 工资 = 工资 - 200;

UPDATE teacher
SET 生日 = '1999-1-1',职称 = '讲师'
WHERE 姓名 = '宋长河';



SELECT * FROM teacher
WHERE 工号 in (
    SELECT 任课教师编号 FROM course
);

-- 有课的老师工资增加300
UPDATE teacher
SET 工资 = 工资 + 300
WHERE 工号 in (
    SELECT 任课教师编号 FROM course
);


SELECT * FROM student
WHERE 系别 = '计算机'

UPDATE student
SET 身高 = 身高 + 身高*0.2,年龄 = 年龄 + 2
WHERE 系别 = '计算机'

-- 将学习了“数据库原理”课程的学生的年龄修改为0。

SELECT * FROM student

WHERE 学号 IN
(
    SELECT 学号 FROM score WHERE 课号 = 
    (
        SELECT 课号 FROM course WHERE 课名 = '数据库原理'
    )
);

-- 删除工资低于平均工资的教师

SELECT * FROM teacher
WHERE 工资 < (
    SELECT AVG(工资) FROM teacher
);



-- 删除一门课都没上的同学

DELETE FROM student
WHERE 学号 NOT IN(
    SELECT 学号 FROM score
);






