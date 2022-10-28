-- Modified from "Number of ppt and mp3 and mp4 files" query

select 
count(*) as "All teaching aids files",
count(distinct f.contenthash) as "Only unique teaching aids files",
(select count(ff.filename) 
from {files} ff
  left join {context} cont2 on ff.contextid = cont2.id
  left join {course_modules} cm on cont2.instanceid = cm.id 
  left join {course} co2 on cm.course=co2.id
  where 
  cont2.contextlevel = 70
  and ff.mimetype = 'application/pdf'
  and co2.id=co.id) as "PDF files in course"

from {files} f
  left join {context} cont on f.contextid = cont.id
  left join {course_modules} vcm on cont.instanceid = vcm.id 
  left join {course} co on vcm.course=co.id
  where 
  vcm.module=8 
  and cont.contextlevel = 70 
  and f.component ='mod_folder'
  and co.fullname like :coursename
