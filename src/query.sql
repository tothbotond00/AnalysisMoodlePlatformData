select cmc.userid as UserId, u.email as UserEmail, cmc.completionstate as CourseModuleState,
       cmc.timemodified as CourseModuleState, cc.timestarted as CourseCompletionStart,
       cc.timecompleted CourseCompletionFinish,
       m.name as ModuleName, cm.id as CourseModuleId, cc.course as Courseid, gg.rawgrade as ModuleGrade, gg.rawgrademax as ModuleMaxgrade
INTO OUTFILE '/var/lib/mysql-files/completion_data.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
from mdl_course_modules_completion cmc
join mdl_course_modules cm ON cmc.coursemoduleid = cm.id
join mdl_modules m ON m.id = cm.module
join mdl_course_completions cc ON cm.course = cc.course AND cmc.userid = cc.userid
left join mdl_grade_items as gi ON gi.itemtype = 'mod' AND gi.iteminstance = cm.instance AND m.name = gi.itemmodule
left join mdl_grade_grades gg ON gg.itemid = gi.id AND gg.userid = cmc.userid
join mdl_user u ON u.id = cmc.userid;