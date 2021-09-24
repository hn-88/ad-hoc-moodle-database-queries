select distinct
FROM_UNIXTIME(fc.timemodified) as Time, fc.userid, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, 
fv.value as "Email entered",
(select fv2.value
from
{feedback_value} fv2
left join {feedback_item} fi2 on fi2.id = fv2.item
left join {feedback_completed} fc2 on fc2.id = fv2.completed
where
fc.timemodified = fc2.timemodified
and fi2.name like '%Chapter%') as "Chapter name",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Main%Script%') as "MainScript",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Inquisit%uestion%') as "IQ",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Suggested%ctivity%') as "SA",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Assessment%') as "QA",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Day%day%elevan%') as "DD",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Value%ontent%') as "VC",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Interest%side%') as "IA",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%1%ultimedia%IIEP%') as "Comm. 1",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%2%relevant%age%') as "Comm. 2",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%3%asset%time%') as "Comm. 3",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%4%grammatically%correct%') as "Comm. 4",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%5%specific%correction%') as "Comm. 5",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Common%oints%6%specific%suggestion%') as "Comm. 6"
from
{feedback_value} fv
left join {feedback_completed} fc on fc.id = fv.completed
left join {user} u on fc.userid = u.id
left join {feedback_item} fi on fi.id = fv.item
where
fc.timemodified > :fromdate
and fc.timemodified < :todate
and u.idnumber like :paramidnumber
and fi.name like '%Email%'
