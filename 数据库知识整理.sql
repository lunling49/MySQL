-- 单行注释
-- sql语句，structured：结构化，query：查询，language：语言
/*
多行注释
*/
-- tab键：补全命令

-- 完整查询语法
SELECT * FROM 表名 [WHERE 查询条件] [GROUP BY 分组字段] [HAVING 筛选字段] [ORDER BY 排序字段 ASC/DESC ] [LIMIT 条件]

-- 数据查询语言 DQL Data Query Language
-- 基本查询
SELECT * FROM 表名;

-- 查看表结构
DESC 表名;

-- 表别名 （AS可以省略不写）
SELECT 表别名.字段名.列别名 FROM 表名 AS 表别名
-- 列别名
SELECT e.employee_id AS 员工编号, e.name 名 FROM 表名 e;

-- 条件查询 where
/*
关系运算符：>=, <=, >, <, =, !=, <>
逻辑运算符：and, or, not
算术运算符：+， -， *， /
模糊查询：like。通配符：1，“_”表示任意一个字符	2、“%”表示0个或者任意多个字符
在...之间：between...and...
在（不在）范围中：in/not in
空值查询：null/not null
查询的优先级：算术运算>连接符>关系符>模糊查询，空值，in>between>逻辑运算符，改变优先级，可以通过加（）实现
*/

-- 连接函数 concat()
-- 查询员工全名
SELECT e.first_name, e.last_name, CONCAT(last_name,'.',first_name) NAME FROM 表名 e;

-- 字符大小写转换函数
-- 大写
SELECT UPPER(要转换的内容) FROM 表名;
-- 小写
SELECT LOWER(要转换的内容) FROM 表名;

-- 字符控制函数
-- 截取函数 substring()
SELECT SUBSTRING(要截取的内容,从第几位开始取,取几个数) FROM 表名;
-- 统计字符串长度 length()
SELECT LENGTH(要统计的字符串) FROM 表名;
-- 查询字符串指定的位置 instr()
SELECT INSTR(被查询的内容,'要查询的字符串') FROM 表名;

-- 用指定字符补齐指定的字符串长度
-- 左补齐lpad()
SELECT LPAD(要补齐的内容,补齐后的字符串数,'补齐的符号') FROM 表名;
-- 右补齐rpad()
SELECT RPAD(要补齐的内容,补齐后的字符串数,'补齐的符号') FROM 表名;

-- 去除前后空格 trim()
SELECT TRIM(要去除空格的内容) FROM 表名;

-- 数字处理函数
-- 求余 mod()
SELECT MOD(15,6);
-- 四舍五入 round()
SELECT ROUND('123.345');
SELECT ROUND('123.345',0);
SELECT ROUND('123.345',2);
SELECT ROUND('123.345',-1);
-- 截断舍去 truncate()
SELECT TRUNCATE('1234.5678',0);
SELECT TRUNCATE('1234.5678',2);
SELECT TRUNCATE('1234.5678',-1);

-- 当前日期和时间 now()
SELECT NOW();
-- 当前时间 curtime()
SELECT CURTIME();
-- 返回日期的星期 weekday()
SELECT WEEKDAY(NOW());
-- 返回日期的月份 monthname()
SELECT MONTHNAME(NOW());
-- 指定日期格式函数 date_format()
SELECT DATE_FORMAT(NOW(),'%y-%m-%d %h:%m:%s');
-- 日期时间增加函数 date_add()
SELECT DATE_ADD(NOW(),INTERVAL 1 MONTH); -- 增加一个月
SELECT DATE_ADD(NOW(),INTERVAL '-1 2' DAY_HOUR); -- 回退一天2小时

-- 排序 order by，经常搭配 having 使用
-- 升序 asc（可以省略），  降序 desc
-- 单字段排序
SELECT * FROM 表名 ORDER BY 排序的字段 DESC;
-- 多字段排序
SELECT * FROM 表名 ORDER BY 排序的字段1 ASC,排序的字段2 DESC;

-- 分组 group by
-- 单字段分组
-- 例：查询每个部门的员工人数，部门薪资和，部门平均薪资，部门最高薪资，部门最低薪资
SELECT 
  e.department_id,
  COUNT(e.employee_id),
  SUM(e.salary),
  AVG(e.salary),
  MAX(e.salary),
  MIN(e.salary) 
FROM
  hrdb.employees e 
GROUP BY e.department_id ;
-- 多字段分组
SELECT 
  e.department_id,
  e.salary,
  e.hire_date,
  COUNT(e.employee_id),
  SUM(e.salary),
  AVG(e.salary),
  MAX(e.salary),
  MIN(e.salary) 
FROM
  hrdb.employees e 
GROUP BY e.department_id,e.salary,e.hire_date ;

SELECT * FROM sys_user;

-- 过滤筛选 having
-- 例：按照部门分组，分组后求最大薪资，过滤出薪资大于10000的员工信息
SELECT department_id,MAX(salary) FROM employees GROUP BY department_id HAVING MAX(salary)>10000;
-- 筛选SA_REP中薪资8000以上的员工
SELECT * FROM hrdb.employees e 
WHERE e.job_id = 'SA_REP' 
HAVING e.salary >= 8000 
ORDER BY e.salary ;
-- 查询每个部门最高薪资在9500以上的员工
SELECT 
  MAX(e.salary),
  e.department_id 
FROM
  hrdb.employees e 
GROUP BY e.department_id 
HAVING MAX(e.salary) >= 9500 
ORDER BY e.salary ;

-- Top-N分析 limit
-- 例：查询前3条记录
SELECT * FROM 表名 LIMIT 3;
SELECT * FROM 表名 LIMIT 0,3；-- limit x，y（x表示从第几个开始，y表示显示几条）

-- 去重 distinct
SELECT DISTINCT 字段 FROM 表名;
SELECT DISTINCT * FROM 表名;

-- 高级查询
-- 多表查询
-- 1、笛卡尔积：A * B、
SELECT * FROM 表名1,表名2;
-- 2、内连接：inner join，搭配on使用
SELECT a.id,a.name,b.salary FROM 表名1 a INNER JOIN 表名2 b ON a.name=b.name;
-- 外连接
-- 左外连接：left join
SELECT a.id,a.name,b.salary FROM 表名1 a LEFT JOIN 表名2 b ON a.name=b.name;
-- 右外连接：right join
SELECT a.id,a.name,b.salary FROM 表名1 a RIGHT JOIN 表名2 b ON a.name=b.name;
-- 全外链接：union/union all
SELECT a.id,a.name,b.salary FROM 表名1 a RIGHT JOIN 表名2 b ON a.name=b.name UNION;
SELECT a.id,a.name,b.salary FROM 表名1 a RIGHT JOIN 表名2 b ON a.name=b.name UNION ALL;

-- 子查询
-- 1、select子句充当条件
SELECT * FROM 表名 WHERE 查询条件 select子句;
/*
any/all子查询
any: where字段 > any(select字句）
any是指select字句结果中最小值；任何一个，一般指最小值 
all: where字段 > all(select字句）
all是指select字句结果中最大值；全部，一般指最大值
*/
-- 2、select字句充当表
SELECT * FROM select子句;

-- 数据操纵语言：DML Data Manipulation Language
-- 对象：表中的数据/记录
/*
数据类型：
1、整型
	tinyint(x)
	smallint(x)
	mediumint(x)
	int(x)
	bigint(x)
2、浮点型
	单精度浮点型：float(x,y)
	双精度浮点型：double(x,y)
	decimall(x,y)
3、字符型
	定长：char(x)
	变长：varchar(x)
4、日期型
	日期型：date
	时间型：time
	日期时间型：datetime
	年：year
5、混合型
	枚举型：enum('M','F')
*/

-- 增：insert into
INSERT INTO 表名 VALUES(值1,值2,...);
INSERT INTO 表名 VALUES(值1,值2,...),(值11,值22,...),(值111,值222,...);
INSERT INTO 表名(列名1,列名2) VALUES(值1,值2);
INSERT INTO 表名(列名1,列名2) SELECT 表名1.列名x,表名1.列名y FROM 表名1;

-- 删：delete、truncate
DELETE FROM 表名;
TRUNCATE 表名;
DELETE FROM 表名 WHERE 查询条件;

-- 改：update
UPDATE 表名 SET 列名=值;
UPDATE 表名 SET 列名=值 WHERE 查询条件;
UPDATE 表名 SET 列名1=值1,列名2=值2 WHERE 查询条件;

-- 数据定义语言：DDL Data Definiton Language
-- 对象：库(database)，表(table)，用户(user)，视图(view)，索引(index)，存储过程(procedure)
/*
表约束
1、主键约束：primary key = 唯一 + 不为空
2、唯一约束：unique key
3、空值约束：null/not null
4、缺省约束：default
5、检查约束：check
6、自增约束：AUTO_INCREMENT
7、外键约束：foreign key
*/

-- 增：create
CREATE DATABASE IF NOT EXISTS 表名 DEFAULT CHARSET='utf-8';
CREATE USER 'user_name'@'%' IDENTIFIED BY 'password';
-- 中文的用char，数字的用int，birther用data就可以，后面不用带数字，例如birther data
CREATE TABLE 表名 (
		uid INT(20) PRIMARY KEY AUTO_INCREMENT,	
		NAME VARCHAR(50) UNIQUE KEY,
		age INT(10) NOT NULL,
		sex ENUM('f','m') DEFAULT 'f'
		);
-- 删：drop
DROP USER 'user_name'@'%';
DROP DATABASE 库名;
DROP TABLE 表名;

-- 改：alter
-- 添加列
ALTER TABLE 表名 ADD COLUMN phone INT(15) AFTER NAME;
ALTER TABLE 表名1 ADD CONSTRAINT user_phone_fk FOREIGN KEY(phone) REFERENCES 表名2(tel);
ALTER TABLE 表名 MODIFY phone INT(10) NOT NULL;
ALTER TABLE 表名 MODIFY phone INT(10) DEFAULT '110';
ALTER TABLE 表名 CHANGE sex gender CHAR(5);
ALTER TABLE 表名 MODIFY gender ENUM('f','m') DEFAULT 'm';
ALTER TABLE 表名 DROP COLUMN 列名;

