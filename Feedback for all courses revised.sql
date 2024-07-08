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
    MAX(CASE WHEN fi3.name LIKE '%Main%Script%' THEN fv3.value ELSE NULL END) AS "MainScript",
    MAX(CASE WHEN fi4.name LIKE '%Inquisit%uestion%' THEN fv4.value ELSE NULL END) AS "IQ",
    MAX(CASE WHEN fi5.name LIKE '%Suggested%ctivity%' THEN fv5.value ELSE NULL END) AS "SA",
    MAX(CASE WHEN fi6.name LIKE '%Assessment%' THEN fv6.value ELSE NULL END) AS "QA",
    MAX(CASE WHEN fi7.name LIKE '%Day%day%elevan%' THEN fv7.value ELSE NULL END) AS "DD",
    MAX(CASE WHEN fi8.name LIKE '%Value%ontent%gained.' THEN fv8.value ELSE NULL END) AS "VC",
    MAX(CASE WHEN fi9.name LIKE '%Interest%side%' THEN fv9.value ELSE NULL END) AS "IA"
FROM
    {feedback_value} fv
    LEFT JOIN {feedback_completed} fc ON fc.id = fv.completed
    LEFT JOIN {user} u ON fc.userid = u.id
    LEFT JOIN {feedback_item} fi ON fi.id = fv.item
    LEFT JOIN {feedback} f ON f.id = fi.feedback
    LEFT JOIN {course} c ON c.id = f.course
    LEFT JOIN {feedback_value} fv2 ON fc.id = fv2.completed
    LEFT JOIN {feedback_item} fi2 ON fi2.id = fv2.item
    LEFT JOIN {feedback_value} fv3 ON fc.id = fv3.completed
    LEFT JOIN {feedback_item} fi3 ON fi3.id = fv3.item
    LEFT JOIN {feedback_value} fv4 ON fc.id = fv4.completed
    LEFT JOIN {feedback_item} fi4 ON fi4.id = fv4.item
    LEFT JOIN {feedback_value} fv5 ON fc.id = fv5.completed
    LEFT JOIN {feedback_item} fi5 ON fi5.id = fv5.item
    LEFT JOIN {feedback_value} fv6 ON fc.id = fv6.completed
    LEFT JOIN {feedback_item} fi6 ON fi6.id = fv6.item
    LEFT JOIN {feedback_value} fv7 ON fc.id = fv7.completed
    LEFT JOIN {feedback_item} fi7 ON fi7.id = fv7.item
    LEFT JOIN {feedback_value} fv8 ON fc.id = fv8.completed
    LEFT JOIN {feedback_item} fi8 ON fi8.id = fv8.item
    LEFT JOIN {feedback_value} fv9 ON fc.id = fv9.completed
    LEFT JOIN {feedback_item} fi9 ON fi9.id = fv9.item
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
