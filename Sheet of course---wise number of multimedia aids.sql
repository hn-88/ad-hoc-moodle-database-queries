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
   ) as "total ppt & mp3 & mp4" 
from 
{course} co2
where co2.fullname like '%tandar%'
