set linesize 10000
set colsep |
SELECT 2, a.path_name||'/'||a.file_name file_name
 FROM bck_control_batch a
WHERE a.job_name='&1'
AND a.job_req='&2'
AND executed_flag <> 1
union
select 1, 'Error' from dual
order by 1;
exit;
