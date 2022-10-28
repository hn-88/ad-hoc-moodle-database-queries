-- Shows number of PPTs and MP3/MP4 files uploaded for each course. 
-- The resulting CSV can then be filtered to get board-wise or subject-wise totals. 
-- Modified from "Number of ppt mp3/mp4 files" query.

select co2.fullname,
(select
  count(*) 
  from {files} f
  left join {context} cont on f.contextid = cont.id
  left join {course_modules} vcm on cont.instanceid = vcm.id 
  where 
  vcm.course=co2.id 
  and vcm.module=8 
  and cont.contextlevel = 70 
  and f.component ='mod_folder'
  and (f.filename like '%.ppt%' or f.filename like '%.mp%')
   ) as "total ppt & mp3 & mp4" ,
(select
  count(*) 
  from {files} f2
  left join {context} cont2 on f2.contextid = cont2.id
  left join {course_modules} vcm2 on cont2.instanceid = vcm2.id 
  where 
  vcm2.course=co2.id 
  and vcm2.module=8 
  and cont2.contextlevel = 70 
  and f2.component ='mod_folder'
   ) as "total teaching aids files",
(select count(f22.filename) 
from {files} f22
  left join {context} cont22 on f22.contextid = cont22.id
  left join {course_modules} cm22 on cont22.instanceid = cm22.id 
  left join {course} co22 on cm22.course=co22.id
  where 
  cont22.contextlevel = 70
  and f22.mimetype = 'application/pdf'
  and co22.id=co2.id) as "PDF files in course"
from 
{course} co2
where co2.fullname like '%tandar%'
