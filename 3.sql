SELECT 姓名,性别,职称 FROM teacher;


SELECT 姓名,YEAR(生日) AS 出生年,YEAR(NOW())-YEAR(生日) AS 年龄 FROM teacher;

SELECT 课号,课名,教室 FROM course;

SELECT 学号,姓名,性别,年龄,YEAR(NOW())-年龄 AS 出生年 FROM student;

SELECT DISTINCT 职称 FROM teacher;

SELECT DISTINCT 系别 FROM student GROUP BY 系别;


SELECT DISTINCT YEAR(生日) div 10 *10 AS 出生年代 FROM teacher;

SELECT * FROM teacher WHERE 性别='男';

SELECT * FROM teacher WHERE 工资 BETWEEN 5000 AND 6000;

SELECT * FROM teacher WHERE 工资 IN(2300,2400,3600,4300);

SELECT * FROM teacher WHERE 姓名 LIKE '刘%';

SELECT * FROM teacher WHERE 姓名 LIKE '_明';


SELECT * FROM teacher WHERE (性别 = '男' AND 职称 = '讲师') OR ((性别 = '女' AND 职称 = '助教'));


SELECT * FROM student WHERE 系别 = '自动化' AND 性别 = '女';

SELECT 课号,课名 FROM course WHERE 课名 LIKE '%原理%';

SELECT 课号,课名,教室 FROM course WHERE 先修课 IS NULL OR 先修课 LIKE'';

SELECT DISTINCT 学号 FROM score WHERE 成绩 < 60;

SELECT 工号,姓名,工资 FROM teacher ORDER BY 工资 DESC;

SELECT * FROM student ORDER BY 系别;


SELECT * FROM score ORDER BY 学号;

SELECT * FROM teacher ORDER BY 生日 LIMIT 4;

SELECT * FROM student ORDER BY 身高 DESC LIMIT 1;

SELECT 学号,课号,成绩 FROM score ORDER BY 成绩 LIMIT 1;

SELECT COUNT(工号) AS 人数 FROM teacher;


SELECT COUNT(工号) AS 人数,
SUM(工资)AS总工资,
ROUND(AVG(工资),2) AS 平均工资,MAX(工资)AS最高工资,
MIN(工资)AS最低工资
FROM teacher
WHERE 职称='讲师';



SELECT COUNT(学号) AS 人数,AVG(年龄) AS 平均年龄
FROM student;

SELECT COUNT(成绩) AS 人数,MAX(成绩) AS 最高分,MIN(成绩) AS 最低分,AVG(成绩) AS 平均分
FROM score
WHERE 课号 = 'C01';

SELECT COUNT(成绩) AS 人数, MAX(成绩) AS 最高分, MIN(成绩) AS 最低分, AVG(成绩) AS 平均分
FROM score
WHERE 课号 = 'C01';


SELECT 职称, COUNT(工号) AS 人数
FROM teacher
GROUP BY 职称;

SELECT 职称, Count(工号) as 人数
FROM teacher
GROUP BY 职称 HAVING COUNT(工号)>=3;

SELECT 职称,性别, Count(工号) AS 人数
FROM teacher
GROUP BY 职称,性别;

SELECT 职称,性别,婚否,COUNT(工号) AS 人数
FROM teacher
GROUP BY 职称,性别,婚否;


SELECT 系别,COUNT(学号) AS 人数,MAX(年龄) AS 最高年龄,MIN(年龄) AS 最小年龄,AVG(年龄) AS 平均年龄
FROM student
GROUP BY 系别;

SELECT 课号,COUNT(学号) AS 人数,AVG(成绩) AS 平均分
FROM score
GROUP BY 课号;


SELECT 课号,COUNT(学号) AS 不及格人数
FROM score
WHERE 成绩 < 60
GROUP BY 课号;

SELECT COUNT(学号) AS 人数,学号,COUNT(课号) AS 不及格课程数
FROM score
WHERE 成绩 < 60
GROUP BY 课号 HAVING COUNT(课号) >1;

SELECT 系别,AVG(年龄) AS 平均年龄
FROM stUdent
GROUP BY 系别
ORDER BY AVG(年龄) DESC
LIMIT 1 ;
