select distinct u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, 
u.institution, c.shortname, r.name as "Resource viewed" , FROM_UNIXTIME(l.timecreated) as "Timestamp"
from 
{logstore_standard_log} l
left join {course} c on l.courseid = c.id
left join {user} u on l.userid = u.id
left join {resource} r on l.objectid = r.id
where
l.timecreated > :fromdate
and l.timecreated < :todate
and l.action = 'viewed' 
and l.target='course_module'  
and l.objecttable = 'resource' 
and u.idnumber like :idnum
and u.username like :usernameparam
