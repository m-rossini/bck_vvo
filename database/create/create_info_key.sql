create table temp_counter (request_id, info_key, info_value ) as
select web_request_id, 'request.size', count(*) from web_request_requests group by web_request_id;

delete from web_request_info where info_key = 'request.size';

insert into web_request_info select * from temp_counter;

drop table temp_counter;

commit;
