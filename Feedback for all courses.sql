select
fi.name as "Feedback item", fv.value as Feedback, 
FROM_UNIXTIME(fc.timemodified) as Time
from
{feedback_value} fv
left join {feedback_completed} fc on fc.id = fv.completed
left join {feedback_item} fi on fi.id = fv.item
where
fc.timemodified > :fromdate
and fc.timemodified < :todate
