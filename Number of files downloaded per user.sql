select distinct u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, 
(select count(*) from
{logstore_standard_log} ltwo
where
ltwo.timecreated > :from2date
and ltwo.timecreated < :to2date
and ltwo.action = 'viewed' 
and ltwo.target='course_module'  
and ( ltwo.objecttable = 'folder' or ltwo.objecttable = 'resource' )
and ltwo.userid = l.userid
) as "Count of files downloaded"
from 
{logstore_standard_log} l
left join {course} c on l.courseid = c.id
left join {user} u on l.userid = u.id
where
l.timecreated > :fromdate
and l.timecreated < :todate
and l.action = 'viewed' 
and l.target='course_module'  
and ( l.objecttable = 'folder' or l.objecttable = 'resource' )
and u.idnumber like :idnum
and u.username like :usernameparam
order by "Count of files downloaded" DESC
