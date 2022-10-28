-- Modified from "Number of ppt and mp3 and mp4 files" query

select 
count(*) as "All teaching aids files",
count(distinct f.contenthash) as "Only unique teaching aids files"
from {files} f
  left join {context} cont on f.contextid = cont.id
  left join {course_modules} vcm on cont.instanceid = vcm.id 
  left join {course} co on vcm.course=co.id
  where 
  vcm.module=8 
  and cont.contextlevel = 70 
  and f.component ='mod_folder'
  and co.fullname like :coursename
