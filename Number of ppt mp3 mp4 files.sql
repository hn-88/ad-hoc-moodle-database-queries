-- Reporting on total number of ppt files uploaded to LMS.
--To get board-wise, standard-wise, or subject-wise PPTs and other MM aids viz., MP4, we can enter the suitable coursename.

--Examples:

--Coursename parameter of % will match all courses.

--Coursename parameter of %CBSE% will match all standards of CBSE.

--Coursename parameter of %Standard%IV% will match all boards standard IV all subjects.

--Coursename parameter of %KSSE%Standard%IV%Mathematics% will match only KSSE Standard IV Mathematics.

-- References:

-- https://moodle.org/mod/forum/discuss.php?d=342459
-- https://www.w3resource.com/sql/aggregate-functions/count-function.php
-- https://moodleschema.zoola.io/tables/files.html
-- https://stackoverflow.com/questions/15938185/selecting-all-the-files-along-with-their-paths-of-a-course-in-moodle
-- Explanation of context table - https://moodle.org/mod/forum/discuss.php?d=202588
-- From https://docs.moodle.org/400/en/course_display
-- "contextlevel 70 is modules, then instanceid points to the mdl_course_modules table" 
-- so in the relevant context table entry, 
-- the instanceid points to course_modules table


select 
count(*) as "All ppt(x) and mp3/mp4 files",
count(distinct f.contenthash) as "Only unique ppt(x) and mp3/mp4 files"
from {files} f
  left join {context} cont on f.contextid = cont.id
  left join {course_modules} vcm on cont.instanceid = vcm.id 
  where 
  vcm.course=co.id 
  and vcm.module=8 
  and cont.contextlevel = 70 
  and f.component ='mod_folder'
  and (f.filename like '%.ppt%' or f.filename like '%.mp%')
  and co.fullname like :coursename
