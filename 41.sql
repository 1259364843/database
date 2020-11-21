-- 1）-- 查询有课教师的姓名、职称及其所授的课程名
SELECT teacher.姓名,teacher.职称, course.课名
FROM teacher JOIN course
ON teacher.工号= course.任课教师编号

-- 2）-- 查询所有教师的姓名、职称及其所授的课程名

SELECT teacher.姓名, teacher.职称, course.课名
FROM teacher LEFT JOIN course
ON teacher.工号= course.任课教师编号

-- -- 查询有课的学生的学号，姓名和所学的课号及成绩。
-- （注：学生学课的成绩记录在score表中）

SELECT student.学号,student.姓名,score.课号,score.成绩
FROM student INNER JOIN score  ON student.学号 = score. 学号
-- 4）-- 查询没课的学生的学号，姓名和性别。
SELECT student.学号,student.姓名,score.课号,score.成绩
FROM student LEFT JOIN score  ON student.学号 = score. 学号
WHERE score.课号 IS NULL;


-- 5）-- 查询有课学生的姓名、所学的课名及成绩。
SELECT student.姓名, course.课名, score.成绩
FROM score
INNER JOIN student ON score.学号 = student.学号
INNER JOIN course ON course.课号 = score.课号;






















-- 1）-- 查询与周华同一系的所有学生。
SELECT 学号,姓名
FROM student 
WHERE 系别 =(
    SELECT 系别 from student WHERE 姓名 = '周华');

-- 2）-- 查询罗明军老师教授的课名和教室。
SELECT 课名,教室
FROM course
WHERE 任课教师编号 = (
SELECT 工号 FROM teacher WHERE 姓名 = '罗明军');


-- 3）-- 查询比其中某一位讲师工资少的教师姓名、工资和职称。
SELECT 姓名,工资,职称
FROM teacher
WHERE 工资 < any(
    SELECT 工资 FROM teacher WHERE 职称 = '讲师'
);

-- 4）-- 查询比所有讲师工资少的教师姓名。
SELECT DISTINCT 姓名
FROM teacher
WHERE 工资 < ALL(
    SELECT 工资 FROM teacher WHERE 职称 = '讲师'
);


-- 5）-- 查询至少有一门课不及格的学生的学号、姓名与系别。（其实本查询完全可以通过连接+条件查询实现，但我们主要练习一下相关子查询的用法）

SELECT 学号,姓名,系别
FROM student WHERE EXISTS(
    SELECT * FROM score
    WHERE score.学号 = student.学号 and score.成绩 < 60
);

-- 6）-- 查询课程成绩全都及格了的学生的学号、姓名与系别。
SELECT 学号,姓名,系别
FROM student WHERE NOT EXISTS(
    SELECT * FROM score
    WHERE score.学号 = student.学号 and score.成绩 < 60
);


-- 不相关子查询
SELECT 学号,姓名,系别
FROM student WHERE 学号 NOT IN (
    SELECT 学号 FROM score
    WHERE 成绩 < 60
);

-- 7）-- 查询与最年轻的一位教师职称相同的教师。

-- SELECT *
-- FROM teacher
-- WHERE 职称 = (
--     SELECT 职称 FROM teacher ORDER BY YEAR(生日) DESC LIMIT 1 );

-- 8）-- 查询与学生同名的教师。

SELECT *
FROM teacher
WHERE 姓名 IN (
    SELECT 姓名 FROM student
)

-- 9）-- 查询与老师同名的学生。
SELECT *
FROM student
WHERE 姓名 IN (
    SELECT 姓名 FROM teacher);

-- 连接查询
SELECT student.*
FROM student INNER JOIN teacher 
    ON student.姓名 = teacher.姓名;



-- 9）-- 查询潘强老师教过的所有学生。
-- 提示：这里要求用嵌套实现。如果知道了潘强老师的工号，
-- 就可以从课程表中查出他上的课号，
-- 进而就可以在成绩表中查询出哪些学号学过这些课，
-- 最后就可以在学生表中查询出是哪些学生了。
-- 所以4层不相关的嵌套就可以查询出结果。
-- 结果有黄河等37条记录

-- score
-- course

SELECT *
FROM student
WHERE 学号 IN (
    SELECT 学号 FROM score WHERE 课号 IN (
        SELECT 课号 FROM course WHERE 任课教师编号 = (
            SELECT 工号 FROM teacher WHERE 姓名 = '潘强'
        )
    )
);

-- 换一种方式

SELECT student.*
FROM student INNER JOIN score ON student.学号 = score.学号
            INNER JOIN course ON score.课号 = course.课号
            INNER JOIN teacher ON course.任课教师编号 = teacher.工号
WHERE teacher.姓名 = '潘强';
