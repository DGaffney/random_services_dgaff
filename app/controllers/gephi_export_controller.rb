class GephiExportController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    t = Time.now
    filename = "#{File.dirname(__FILE__)}/../../tmp/#{Time.now.to_i+rand(1000000)}.gexf"
    logger.info(filename)
    data = params[:data].read
    file = File.open(filename, "w")
    file.write(data)
    file.close
    logger.info("java -jar -Xmx256M public/gephi_layout_script/ToolkitDemos.jar #{filename} #{filename.gsub(".gexf", "_new.gexf")}")
    logger.info(`java -jar -Xmx256M public/gephi_layout_script/ToolkitDemos.jar #{filename} #{filename.gsub(".gexf", "_new.gexf")}`)
    #`rm #{filename}`
    tt = Time.now
    logger.info("Gephi Layout Execution Time: #{tt-t}")
    render :xml => File.read(filename.gsub(".gexf", "_new.gexf"))
  end
end

# RestClient::Request.execute(:method => :post, :url => "http://127.0.0.1:3000/gephi_export", :timeout => 3600*24, :open_timeout => 10)

# resource = RestClient::Resource.new(
#   "http://178.79.169.159:23672/gephi_export",
#   :timeout => -1)
# response = resource.post :data =>  File.new("curation_1133_3023.gexf")

# resource = RestClient::Resource.new(
#   "http://127.0.0.1:3000/gephi_export",
#   :timeout => -1)
# response = resource.post :data =>  File.new("curation_1091_2906.gexf")

