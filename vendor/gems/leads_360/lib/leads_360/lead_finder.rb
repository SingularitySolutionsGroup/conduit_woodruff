module Leads360
  class LeadFinder
    attr_reader :username, :password
    def initialize(options)
      @username = options[:username]
      @password = options[:password]
    end

    def get_leads_by_date(date)
      url_to_get_lead_ids = "http://service.leads360.com/ClientService.asmx/GetLeads?username=#{@username}&password=#{@password}&from=#{date}&to=#{date+1}"
      document = ::Nokogiri::XML(open(url_to_get_lead_ids).read)
      document.xpath('//Lead').map { |lead_doc| create_a_lead(lead_doc) }
    rescue
      []
    end

    def get_lead_by_id(id)
      url = "http://service.leads360.com/ClientService.asmx/GetLead?username=#{username}&password=#{password}&leadId=#{id}"
      document = ::Nokogiri::XML(open(url).read)
      document.xpath('//Lead').map { |lead_doc| create_a_lead(lead_doc) }.first
    rescue
      nil
    end

    def get_agent_by_id id
      url = "http://service.leads360.com/ClientService.asmx/GetAgent?username=#{username}&password=#{password}&agentId=#{id}"
      document = ::Nokogiri::XML(open(url).read)
      document.xpath('//Agent').map { |doc| create_an_agent doc }.first
    rescue
      nil
    end

    private 

    def create_an_agent(doc)
      agent = Leads360::Agent.new
      agent.id    = doc["AgentId"]
      agent.name  = doc["AgentName"]
      agent.phone = doc["PhoneWork"]
      agent.email = doc["AgentEmail"]

      names = agent.name.to_s.split(',').map { |x| x.strip }
      agent.first_name = names[1] if names.count > 1
      agent.last_name  = names[0]

      agent.xml   = doc.to_s
      agent
    end

    def create_a_lead(doc)
      lead = Leads360::Lead.new
      lead.lead_id = doc["Id"]
      begin
        lead.create_date = Date.parse(doc["CreateDate"])
      rescue
      end
      lead.xml = doc.to_s
      lead
    end
  end
end
