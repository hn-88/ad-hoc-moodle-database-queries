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


select 
count(*) as "All ppt(x) and mp3/mp4 files",
count(distinct f.contenthash) as "Only unique ppt(x) and mp3/mp4 files"
from {files} f
INNER JOIN {context} c ON f.contextid = c.id
INNER JOIN {resource} r ON c.instanceid = r.id
INNER JOIN {course} co ON r.course = co.id
where (f.filename like '%ppt%' or f.filename like '%mp%')
and co.fullname like :coursename
