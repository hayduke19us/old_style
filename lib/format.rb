
module Format
  PATH = Dir.pwd 

  def new_or_open_index
    unless File.directory?(PATH + "/old_style")
      Dir.mkdir(PATH + "/old_style")
    end
    File.open(PATH + "/old_style/index.html", 'w+')
  end

  def create_css_file
    unless File.exist?(css_path) 
      @css_file ||= File.new(css_path)
    end
  end

  def css_path
    PATH + "/old_style/index.css"
  end

  def write_index
    file = new_or_open_index
    file.write "<head>"
    file.write "<link rel='stylesheet' type='text/css' href=#{css_path}>"
    file.write "</head>"
    file.write "<div id='content'>"
    file.write "<h2 id='dir-heading'>#{self.directories}</h2>"
    file.write "<h4>Looked in:</h4>"
    self.css.each do |css, path|
      file.write "<li><a id='css_file' href=#{path}/#{css}>#{css}<a></li>"
    end
    self.html.each do |html, path|
      file.write "<li><a id='html_file' href=#{path}>#{html}<a></li>"

    end
    file.write "<h4 id='found_css'>Good</h4>"
    file.write "#{self.good_percent}"

    self.found.each do |style, desc|
      file.write "<li id='style'>#{style} {#{desc}}</li>"
    end

    file.write "<h4 id='empty_css'>Bad</h4>"
    file.write "#{self.bad_percent}"
    self.empty.each do |style, desc|
      file.write "<li id='empty_style'>#{style} {#{desc}}</li>"
    end
    file.write "</div>"
    puts "Your report was generated at #{Dir.pwd}/old_style/index.html"
    true
  end

  def good_percent
    x = self.found.keys.count/(self.found.keys.count + self.empty.keys.count).to_f
    y = (x * 100).to_s
    z = /(.{5}|.{3}.|.{2})/.match(y)
    z.to_s + "%"
  end

  def bad_percent
    x = self.empty.keys.count/(self.found.keys.count + self.empty.keys.count).to_f
    y = (x * 100).to_s
    z = /(.{5}|.{3}.|.{2})/.match(y)
    z.to_s + "%"
  end
end


