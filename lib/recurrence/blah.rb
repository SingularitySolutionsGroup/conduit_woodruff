statement = <<EOF
var RRule = require('./rrule').RRule;
var options = RRule.parseString('FREQ=WEEKLY;INTERVAL=1;BYDAY=MO');
options.dtstart = new Date(Date.parse('2015-04-20 15:00:00 +0000'));
var rule = new RRule(options);
var results = rule.between(new Date(Date.parse('Sun, 31 May 2015 20:43:58 +0000')), new Date(Date.parse('Tue, 02 Jun 2015 20:43:58 +0000')));
console.log(results);
EOF

statement = "node -e \"#{statement}\""

result = %x( #{statement} )

puts result
