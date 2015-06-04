module GoogleRecurrence

  # sample: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO'

  # this method generates a node script that will use the
  # rrule package to generate the recurring events given
  # a RRULE value and a set of dates
  def self.get_the_recurrences date, recurrence, range
    recurrence = recurrence.sub('RRULE:', '')
    from = DateTime.parse(range[0].to_s)
    to   = DateTime.parse(range[1].to_s)

    statement = <<EOF
var RRule = require('#{Rails.root}/lib/recurrence/rrule.js').RRule;
var options = RRule.parseString('#{recurrence}');
options.dtstart = new Date(Date.parse('#{date}'));
var rule = new RRule(options);
var results = rule.between(new Date(Date.parse('#{from}')), new Date(Date.parse('#{to}')));
console.log(results);
EOF

    statement = "node -e \"#{statement}\""

    results = %x( #{statement} )

    results.sub('[', '').reverse.sub(']', '').reverse.split(',').map { |x| x.strip }.map { |x| DateTime.parse x }

  end
end
