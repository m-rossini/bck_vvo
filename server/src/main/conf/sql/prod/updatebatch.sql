set feedback off
set termout off
set verify off
UPDATE bck_control_batch set executed_flag='1'
WHERE job_name='&1'
AND job_req='&2';
exit;
