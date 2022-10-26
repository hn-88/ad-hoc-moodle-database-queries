-- Reporting on total number of ppt files uploaded to LMS.

-- References:

-- https://moodle.org/mod/forum/discuss.php?d=342459
-- https://www.w3resource.com/sql/aggregate-functions/count-function.php
-- https://moodleschema.zoola.io/tables/files.html


select count(*) as "All ppt(x) and mp3/mp4 files",
count(distinct f.contenthash) as "Only unique ppt(x) and mp3/mp4 files"
from {files} f
where f.filename like '%ppt%' or f.filename like '%mp%'
