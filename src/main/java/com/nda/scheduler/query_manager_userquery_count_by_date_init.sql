/*##날짜에 의한 qc_count 처리를 위한 테이블 생성*/

create table query_manager_userquery_count_by_date
(
  id int not null auto_increment primary key,
  user_query_id int null,
  query_count int null,
  qc_counted_date date null,
  query_work_status int null,
  query_route int null
)
;


create index query_count
  on query_manager_userquery_count_by_date (query_count)
;

create index user_query_id
  on query_manager_userquery_count_by_date (user_query_id)
;



/*최초데이터 생성 --> 어제까지의 total_qc_count를 초기데이타로 넣어준다..

2017-05-24 <--어제 날짜로 대치할것.
*/
delete from query_manager_userquery_count_by_date;

INSERT INTO query_manager_userquery_count_by_date
(user_query_id, query_count, qc_counted_date)
  select id, query_qc, '2017-05-24' from query_manager_userquery;



desc query_manager_userquery



