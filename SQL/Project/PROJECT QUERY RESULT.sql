use db_course_conversions;

select count(student_id) from student_engagement;
select count(student_id) from student_info;
select count(student_id) from student_purchases;

-- creating a result table
drop table if exists free_to_conversion;
CREATE TABLE free_to_conversion (
    student_id INT NOT NULL,
    date_registered DATE,
    first_date_watched DATE,
    first_date_purchased DATE DEFAULT NULL,
    date_diff_reg_watch INT,
    date_diff_watch_purch INT DEFAULT NULL
);

insert into free_to_conversion (
SELECT distinct
    info.student_id AS student_id,
    info.date_registered AS date_registered,
    engage.date_watched AS first_date_watched,
    purchase.date_purchased AS first_date_purchased,
    DATEDIFF(info.date_registered, 
			engage.date_watched) AS date_diff_reg_watch,
    DATEDIFF(engage.date_watched,
            purchase.date_purchased) AS date_diff_watch_purch
FROM
    student_info info
        INNER JOIN
    student_engagement engage ON info.student_id = engage.student_id
        INNER JOIN
    student_purchases purchase ON engage.student_id = purchase.student_id);
    
    
-- opcion 2
insert into free_to_conversion (
SELECT distinct
    engage.student_id AS student_id,
    info.date_registered AS date_registered,
    engage.date_watched AS first_date_watched,
    purchase.date_purchased AS first_date_purchased,
    DATEDIFF(info.date_registered, 
			engage.date_watched) AS date_diff_reg_watch,
    DATEDIFF(engage.date_watched,
            purchase.date_purchased) AS date_diff_watch_purch
FROM
    student_engagement engage
        left JOIN
    student_purchases purchase ON engage.student_id = purchase.student_id
        INNER JOIN
    student_info info ON info.student_id = purchase.student_id);
    
SELECT 
    *
FROM
    free_to_conversion
WHERE first_date_watched <= first_date_purchased;

select * from student_purchases e inner join student_engagement p on e.student_id = p.student_id where e.date_purchased >= p.date_watched order by e.purchase_id;
