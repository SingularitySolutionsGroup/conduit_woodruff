select count(*) as "start_count"
	, case when _completions.completion_count is null then 0 else _completions.completion_count end 
	, round(100.0 * (case when _completions.completion_count is null then 0 else _completions.completion_count end) / count(*)) as "completion_percentage"
	, starts.form_id
from analytics starts
left join (
	select form_id, count(*) as completion_count
	from analytics
	group by analytics.form_id, analytics.user_action
	having analytics.user_action = 'complete form'
) _completions
	on (_completions.form_id = starts.form_id)
group by starts.form_id, starts.user_action, _completions.completion_count
having starts.user_action = 'begin form'
order by completion_percentage asc