event_start_date = DateTime.parse('2015-04-20 15:00:00 +0000')
recurrence = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO'
from = 'Sun, 31 May 2015 20:43:58 +0000'
to   = 'Tue, 02 Jun 2015 20:43:58 +0000'

statement = <<EOF
var RRule = require('./rrule').RRule;
var options = RRule.parseString('#{recurrence}');
options.dtstart = new Date(Date.parse('#{event_start_time}'));
var rule = new RRule(options);
var results = rule.between(new Date(Date.parse('#{from}')), new Date(Date.parse('#{to}')));
console.log(results);
EOF

statement = "node -e \"#{statement}\""

result = %x( #{statement} )

puts result
