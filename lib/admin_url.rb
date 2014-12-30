require 'rack-plastic'

class AdminUrl < Rack::Plastic

  def change_nokogiri_doc(doc)
    doc.css("a").each do |a|
      next unless a["href"]
      a["href"] = a["href"].gsub("refinery", "admin")
    end
    doc
  end

end
