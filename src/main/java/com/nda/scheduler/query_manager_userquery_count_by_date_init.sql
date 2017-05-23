delete from query_manager_userquery_count_by_date;

INSERT INTO query_manager_userquery_count_by_date
(user_query_id, query_count, qc_counted_date)
  select id, query_qc, '2017-05-21' from query_manager_userquery;