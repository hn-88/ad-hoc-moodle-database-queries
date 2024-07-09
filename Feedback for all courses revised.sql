SELECT
    FROM_UNIXTIME(fc.timemodified) AS Time,
    fc.userid,
    u.idnumber,
    u.username,
    u.firstname,
    u.lastname,
    u.email,
    u.institution,
    fv.value AS "Email entered",
    c.fullname AS BSS,
    MAX(CASE WHEN fi2.name LIKE '%Chapter%' AND fi2.typ = 'textfield' THEN fv2.value ELSE NULL END) AS "Chapter name",
    MAX(CASE WHEN fi2.name LIKE '%Main%Script%' THEN fv2.value ELSE NULL END) AS "MainScript",
    MAX(CASE WHEN fi2.name LIKE '%Inquisit%uestion%' THEN fv2.value ELSE NULL END) AS "IQ",
    MAX(CASE WHEN fi2.name LIKE '%Suggested%ctivity%' THEN fv2.value ELSE NULL END) AS "SA",
    MAX(CASE WHEN fi2.name LIKE '%Assessment%' THEN fv2.value ELSE NULL END) AS "QA",
    MAX(CASE WHEN fi2.name LIKE '%Day%day%elevan%' THEN fv2.value ELSE NULL END) AS "DD",
    MAX(CASE WHEN fi2.name LIKE '%Value%ontent%gained.' THEN fv2.value ELSE NULL END) AS "VC",
    MAX(CASE WHEN fi2.name LIKE '%Interest%side%' THEN fv2.value ELSE NULL END) AS "IA",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%1%' THEN fv2.value ELSE NULL END) AS "Comm 1",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%2%' THEN fv2.value ELSE NULL END) AS "Comm 2",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%3%' THEN fv2.value ELSE NULL END) AS "Comm 3",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%4%' THEN fv2.value ELSE NULL END) AS "Comm 4",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%5%' THEN fv2.value ELSE NULL END) AS "Comm 5",
    MAX(CASE WHEN fi2.name LIKE '%ommon%oint%6%' THEN fv2.value ELSE NULL END) AS "Comm 6"
FROM
    {feedback_value} fv
    LEFT JOIN {feedback_completed} fc ON fc.id = fv.completed
    LEFT JOIN {user} u ON fc.userid = u.id
    LEFT JOIN {feedback_item} fi ON fi.id = fv.item
    LEFT JOIN {feedback} f ON f.id = fi.feedback
    LEFT JOIN {course} c ON c.id = f.course
    LEFT JOIN {feedback_value} fv2 ON fc.id = fv2.completed
    LEFT JOIN {feedback_item} fi2 ON fi2.id = fv2.item
WHERE
    fc.timemodified > :fromdate
    AND fc.timemodified < :todate
    AND u.idnumber LIKE :paramidnumber
    AND fi.name LIKE '%Email%'
GROUP BY
    FROM_UNIXTIME(fc.timemodified),
    fc.userid,
    u.idnumber,
    u.username,
    u.firstname,
    u.lastname,
    u.email,
    u.institution,
    fv.value,
    c.fullname
