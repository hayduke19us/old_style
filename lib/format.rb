
module Format
  PATH = Dir.pwd 

  def new_or_open_index
    unless File.directory?(PATH + "/old_style")
      Dir.mkdir(PATH + "/old_style")
    end
    File.open(PATH + "/old_style/index.html", 'w+')
  end

  def write_index
    file = new_or_open_index
    file.write "<div id='content' style='padding:5%;line-height:1.4;'>"
    file.write "<h2 style='border-bottom: 1px solid #efefef;'>#{self.directories}</h2>"
    file.write "<h4>Looked in:</h4>"
    self.css.each do |css|
      file.write "<li>#{css}</li>"
    end
    self.html.each do |html|
      file.write "<li>#{html}</li>"
    end
    file.write "<h4 style='border-bottom: 1px solid #efefef;'>Good</h4>"
    file.write "#{self.good_percent}"

    self.found.each do |style, desc|
      file.write "<li style='color:green;'>#{style} {#{desc}}</li>"
    end

    file.write "<h4 style='border-bottom: 1px solid #efefef;'>Bad</h4>"
    file.write "#{self.bad_percent}"
    self.empty.each do |style, desc|
      file.write "<li style='color:red;'>#{style} {#{desc}}</li>"
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


