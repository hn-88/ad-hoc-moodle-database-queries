-- Modified from "Sheet of coursewise number of teaching aids" query

select co2.fullname as Course,
  f2.filename 
  from {files} f2
  left join {context} cont2 on f2.contextid = cont2.id
  left join {course_modules} vcm2 on cont2.instanceid = vcm2.id 
  left join {course} co2 on co2.id = vcm2.course
  where 
  vcm2.module=8 
  and cont2.contextlevel = 70 
  and f2.component ='mod_folder'
  and co2.fullname like :board
  and f2.filename != '.'
