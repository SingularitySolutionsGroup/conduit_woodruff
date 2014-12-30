module Leads360

  class LeadCreator

    def initialize options
      @username = options[:username]
      @password = options[:password]
    end

    def add_lead(data)
      data = HashWithIndifferentAccess.new(data)
      parsed_data = {
                      reference_id:        data[:reference_id],
                      status_id:           data[:status_id],
                      campaign_id:         data[:campaign_id],
                      first_name:          data[:first_name],
                      last_name:           data[:last_name],
                      email:               data[:email],
                      phone:               data[:phone],
                      campus_of_interest:  data[:campus_of_interest],
                      program_of_interest: data[:program_of_interest],
                      comment:             data[:comment],
                    }
      parsed_data.each do |key, value|
        next unless value.class == String
        parsed_data[key] = value.gsub('<', '').gsub('>', '') unless value.nil?
      end
      if parsed_data[:program_of_interest]
        program_of_interest_line = "<Field FieldId=\"26\" Value=\"#{parsed_data[:program_of_interest]}\"></Field>"
      end
      sample_format = <<EOF
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
<s:Body xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<AddLeads xmlns="https://service.leads360.com">
<username>#{@username}</username>
<password>#{@password}</password>
<leads>
<Leads xmlns="">
<Lead>
<Status StatusId="#{parsed_data[:status_id]}"></Status>
<Campaign CampaignId="#{parsed_data[:campaign_id]}"></Campaign>
<Fields>
<Field FieldId="1" Value="#{parsed_data[:reference_id]}"></Field>
<Field FieldId="4" Value="#{parsed_data[:first_name]}"></Field>
<Field FieldId="5" Value="#{parsed_data[:last_name]}"></Field>
<Field FieldId="3" Value="#{parsed_data[:email]}"></Field>
<Field FieldId="11" Value="#{parsed_data[:phone]}"></Field>
<Field FieldId="91" Value="#{parsed_data[:campus_of_interest]}"></Field>
<Field FieldId="105" Value="#{parsed_data[:comment]}"></Field>
#{program_of_interest_line}
</Fields>
</Lead>
</Leads>
</leads>
</AddLeads>
</s:Body>
</s:Envelope>
EOF
      sample_format.strip!
      sample_format.gsub!("\n\n", "\n")

      send_the_data(sample_format).body
    end

    def send_the_data data
      client = Savon.client("http://service.leads360.com/ClientService.asmx?wsdl")
      client.request :add_leads do
        soap.xml = data
      end
    end
    
  end

end
