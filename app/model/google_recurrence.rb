module GoogleRecurrence

  def self.testing
    event_start_date = DateTime.parse('2015-04-20 15:00:00 +0000')
    recurrence = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO'
    from = 'Sun, 31 May 2015 20:43:58 +0000'
    to   = 'Tue, 02 Jun 2016 20:43:58 +0000'
    get_the_recurrences event_start_date, recurrence, [from, to]
  end

  def self.testing2
    testing.sub('[', '').reverse.sub(']', '').reverse.split(',').map { |x| x.strip }.map { |x| DateTime.parse x }
  end

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

    %x( #{statement} )

  end
end
