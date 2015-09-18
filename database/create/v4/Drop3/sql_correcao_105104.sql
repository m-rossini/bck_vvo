CREATE OR REPLACE VIEW FIN_DR_MONTH_VIEW (
       cycle_cd, caption_text, call_dt, call_dt_str, week_call_dt, dur_calls,
       dur_billing_calls, dur_franq_calls, qtt_calls_current, amount_calls_current,
       avg_qtt_call, avg_am_call, desvio_qtt, desvio_am, Parameter_Amount, Parameter_Percent        
)
AS
(
    SELECT 
       a.cycle_cd, a.caption_text, a.call_dt, a.call_dt_str, a.week_call_dt, a.dur_calls,
       a.dur_billing_calls, a.dur_franq_calls, a.qtt_calls_current, a.amount_calls_current,
       nvl((select avg_qtt_call from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as avg_qtt_call
       ,
        nvl((select avg_am_call from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as avg_am_call
       , 
        nvl((select desvio_qtt from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as desvio_qtt
       , 
       nvl((select desvio_am from FIN_DR_STAT_DM_MVIEW 
            where cycle_cd = a.cycle_cd 
            AND week_call_dt = a.week_call_dt 
            AND caption_text = a.caption_text), 0) as desvio_am
       ,    
       nvl((select PARAMETER_AMOUNT from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'DAILYREVAMOUNT'), 0) as Parameter_Amount,
       nvl((select PARAMETER_ITEM from FIN_REPORT_PARAMETER_DM PA where PA.TYPE_REPORT = 'DAILYREVAMOUNT'), 0) as Parameter_Percent
    FROM FIN_DR_MONTH_MVIEW a
);
