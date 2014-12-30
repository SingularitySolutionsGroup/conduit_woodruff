Interchangeable.define(Age, :for) do |lead|
  begin
    birth_date = lead['data'] ? lead['data']['birth_date'] : lead['birth_date']
    format     = birth_date.include?('/') ? '%m/%d/%Y' : '%m-%d-%Y'
    birth_date = Date.strptime birth_date, format
    (Date.today - birth_date).to_i / 365
  rescue
    0
  end
end
