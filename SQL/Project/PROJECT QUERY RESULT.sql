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

-- Creating the subquery, 20255 total students obtained
insert into free_to_conversion (
SELECT
    engage.student_id AS student_id,
    info.date_registered AS date_registered,
    min(engage.date_watched) AS first_date_watched,
    min(purchase.date_purchased) AS first_date_purchased,
    DATEDIFF(min(engage.date_watched), info.date_registered) AS date_diff_reg_watch,
    DATEDIFF(min(purchase.date_purchased), min(engage.date_watched)) AS date_diff_watch_purch
FROM
    student_engagement engage
        inner JOIN
    student_info info ON engage.student_id = info.student_id
        left JOIN
    student_purchases purchase ON engage.student_id = purchase.student_id
group by student_id
having first_date_purchased is null or first_date_purchased >= first_date_watched
);

select * from free_to_conversion;

-- 2nd part, get calculations

SELECT 
    ROUND(COUNT(first_date_purchased) / COUNT(first_date_watched),
            2) AS convertion_rate,
	round(sum(date_diff_reg_watch)/count(first_date_watched),2) as av_reg_watch,
    round(sum(date_diff_watch_purch)/count(date_diff_watch_purch),2) as av_watch_purch
FROM
    free_to_conversion;

