-- Modified from "Sheet of coursewise number of teaching aids" query

select co2.fullname as Course,
(select
  f2.filename 
  from {files} f2
  left join {context} cont2 on f2.contextid = cont2.id
  left join {course_modules} vcm2 on cont2.instanceid = vcm2.id 
  where 
  vcm2.course=co2.id 
  and vcm2.module=8 
  and cont2.contextlevel = 70 
  and f2.component ='mod_folder'
   ) 
from 
{course} co2
where co2.fullname like '%tandar%'
