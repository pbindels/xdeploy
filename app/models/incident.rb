class Incident < ActiveRecord::Base
  def self.as_json
    hash =  { "timeline" =>
              { "headline" => "Netops",
                "type" => "default",
                "text" => "<p>Outages and Incidents</p>",
                "asset" => {
                  "media" => "/assets/imgres.jpeg",
                  "credit" => "OKL Engineering",
                  "caption" => "Power of the Elephant"
                }
              }
            }
    hash["timeline"]["date"]= []
    Incident.all.each do |incident|
      hash["timeline"]["date"] <<  {
                                      "startDate" => incident.start_date.strftime("%Y,%-m,%-d,%H,%M"),
                                      "endDate" => incident.start_date.strftime("%Y,%-m,%-d,%H,%M"),
                                      "headline" => incident.title,
                                      "text" => "<p>#{incident.content.gsub("\n", "<br>")}</p>",
                                      "tag" => incident.tag
                                    }
    end
    hash
  end
end
