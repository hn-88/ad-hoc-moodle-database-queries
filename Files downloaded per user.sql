select distinct u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, c.shortname, vcs.name as "Course Module",  f.filename as "File downloaded" 
from 
{logstore_standard_log} l
left join {course} c on l.courseid = c.id
left join {user} u on l.userid = u.id
left join {files} f on l.contextid = f.contextid
left join {resource} r on l.objectid = r.id
left join {course_modules} vcm on l.contextinstanceid = vcm.id 
left join {course_sections} vcs on vcm.section = vcs.id
where
l.timecreated > :fromdate
and l.timecreated < :todate
and l.action = 'viewed' 
and l.target='course_module'  
and ( l.objecttable = 'folder' or l.objecttable = 'resource' )
and u.idnumber like :idnum
and u.username like :usernameparam
and f.filesize > 0
