select distinct u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, 
(select count(distinct concat(f2.contenthash,l2.contextinstanceid)) from
{logstore_standard_log} l2
left join {files} f2 on l2.contextid = f2.contextid
where
l2.timecreated > :from2date
and l2.timecreated < :to2date
and l2.action = 'viewed' 
and l2.target='course_module'  
and ( l2.objecttable = 'folder' or l2.objecttable = 'resource' )
and f2.filesize > 0
and l2.userid = l.userid
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
