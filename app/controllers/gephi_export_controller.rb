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
