Query 1

Select *
From survey
Limit 10;

Columns question, user_id, and response


Query 2

Select question,
Count(distinct user_id)
from survey
Group By question;

What are you looking for? 500 100%
Whats your fit? 475 95%
Which shapes do you like? 380 76%
Which colors do you like? 361 72%
When was your last eye exam? 270 54%

Which questions of the quiz have a lower completion rates?
What do you think is the reason?


Query 4

Select *
From quiz
limit 5;

Select *
From home_try_on
limit 5;

Select *
From purchase
limit 5;

Columns user_id style fit shape color (quiz) user_id number_of_pairs address (home_try_on) User_id product_id style mode_name color price (purchase)    *(column)


Query 5

Select distinct q.user_id,
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase'
From quiz q
Left Join home_try_on h
on q.user_id = h.user_id
Left Join purchase p
on p.user_id = q.user_id
Limit 10;



Query 6

WITH funnels as (
SELECT DISTINCT q.user_id,
  h.number_of_pairs,
  h.user_id IS NOT NULL AS 'is_home_try_on',
  p.user_id IS NOT NULL AS 'is_purchase'
  From quiz as 'q'
  LEFT JOIN home_try_on as 'h'
  ON q.user_id = h.user_id 
  LEFT JOIN purchase as 'p'
  ON p.user_id = q.user_id )
  Select Count (*) 'quiz',
  Sum(is_home_try_on) as 'is_home_try_on',
  Sum(is_purchase) as 'is_purchase',
  1.0 * SUM(is_home_try_on) / COUNT(user_id),
  1.0 * SUM(is_purchase) / SUM(is_home_try_on)
  From funnels;
