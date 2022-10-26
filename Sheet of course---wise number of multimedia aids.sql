-- Shows number of PPTs and MP3/MP4 files uploaded for each course. 
-- The resulting CSV can then be filtered to get board-wise or subject-wise totals. 
-- Modified from "Number of ppt mp3/mp4 files" query.

select co2.fullname,
(select
  count(*) 
  from {files} f
  INNER JOIN {context} c ON f.contextid = c.id
  INNER JOIN {resource} r ON c.instanceid = r.id
  INNER JOIN {course} co ON r.course = co.id
  where (f.filename like '%ppt%' or f.filename like '%mp%')
  and co.id = co2.id ) as "total ppt & mp3,mp4" 
from 
{course} co2
where co2.fullname like '%tandar%'
