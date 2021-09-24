select 
u.id, u.idnumber, u.username, u.firstname, u.lastname, u.email, u.institution, 
IF (u.lastaccess = 0,'never', DATE_FORMAT(FROM_UNIXTIME(u.lastaccess),'%Y-%m-%d')) as "Last Accessed" 
from {user} u 
where u.idnumber like :idnum
