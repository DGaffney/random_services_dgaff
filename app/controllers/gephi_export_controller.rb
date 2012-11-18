class GephiExportController < ApplicationController
  
  def index
    t = Time.now
    filename = "tmp/#{Time.now.to_i+rand(1000000)}.gexf"
    file = File.new(filename, "w")
    file.write(params[:data].read)
    file.close
    `java -jar public/gephi_layout_script/ToolkitDemos.jar #{filename} #{filename.gsub(".gexf", "_new.gexf")}`
    `rm #{filename}`
    tt = Time.now
    logger.info("Gephi Layout Execution Time: #{tt-t}")
    render :xml => File.read(filename.gsub(".gexf", "_new.gexf"))
  end
end

# RestClient::Request.execute(:method => :post, :url => "http://127.0.0.1:3000/gephi_export", :timeout => 3600*24, :open_timeout => 10)

# resource = RestClient::Resource.new(
#   "http://127.0.0.1:3000/gephi_export",
#   :timeout => -1)
# response = resource.post :data =>  File.new("curation_1091_2906.gexf")