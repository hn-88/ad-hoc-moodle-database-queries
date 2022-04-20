select distinct
FROM_UNIXTIME(fc.timemodified) as Time, fc.userid, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, 
fv.value as "Email entered", c.fullname as BSS,
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
and fi3.name like '%Value%ontent%gained.') as "VC",
(select fv3.value
from
{feedback_value} fv3
left join {feedback_item} fi3 on fi3.id = fv3.item
left join {feedback_completed} fc3 on fc3.id = fv3.completed
where
fc.timemodified = fc3.timemodified
and fi3.name like '%Interest%side%') as "IA"
from
{feedback_value} fv
left join {feedback_completed} fc on fc.id = fv.completed
left join {user} u on fc.userid = u.id
left join {feedback_item} fi on fi.id = fv.item
left join {feedback} f on f.id = fi.feedback
left join {course} c on c.id = f.course
where
fc.timemodified > :fromdate
and fc.timemodified < :todate
and u.idnumber like :paramidnumber
and fi.name like '%Email%'
