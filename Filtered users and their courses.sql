SELECT u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, c.fullname as "Courses enrolled"
FROM prefix_course AS c
JOIN prefix_context AS ctx ON c.id = ctx.instanceid
JOIN prefix_role_assignments AS ra ON ra.contextid = ctx.id
JOIN prefix_user AS u ON u.id = ra.userid
WHERE u.idnumber like :idnum
