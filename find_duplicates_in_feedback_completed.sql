select timemodified, count(*) from ourprefix_feedback_completed
GROUP BY timemodified
HAVING COUNT(*) > 1;
