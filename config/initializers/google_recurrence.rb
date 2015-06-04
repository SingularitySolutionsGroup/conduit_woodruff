Interchangeable.define TheGoogle::Event, :lookup_recurring_dates do |options|
  GoogleRecurrence.get_the_recurrences options[:date], options[:recur], options[:timeframe]
end
