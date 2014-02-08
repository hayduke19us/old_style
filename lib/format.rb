
module Format
  PATH = Dir.pwd 

  def new_or_open_index
    unless File.directory?(PATH + "/old_style")
      Dir.mkdir(PATH + "/old_style")
    end
    File.open(PATH + "/old_style/index.html", 'w+')
  end

  def create_css_file?
    unless File.exist?(css_path) 
      file =  File.new(css_path, 'w+')
      write_css(file)
    end
  end

  def css_path
    PATH + "/old_style/index.css"
  end

  def write_css(file)
    file.write %s{ 
      #content {padding: 5%;
                line-height: 1.4;
      }

      #dir-heading {border-bottom: 1px solid #efefef;}

      li {list-style: none;}

      a {text-decoration: none;
         color: black;
      }
      #css-file:hover {color: blue;}
      #html-file:hover {color: blue;}

      #found_css {border-bottom: 1px solid #efefef;}
      #empty_css {border-bottom: 1px solid #efefef;}

      #style {color: green;}
      #empty_style {color: red;} }
  end

  def write_index
    create_css_file?
    file = new_or_open_index
    file.write "<head>"
    file.write "<link rel='stylesheet' type='text/css' href=#{css_path}>"
    file.write "</head>"
    file.write "<div id='content'>"
    file.write "<h1 id='main-heading'>
                #{self.directories.count} Controller evaluated </h1>"
    file.write "<div id='directories'>"
    file.write "<h2 id='dir-heading'>#{self.directories}</h2>"
    file.write "</div>"
    file.write "<h4>#{self.css.count} css files compared to 
    #{self.html.count} html files 
    </h4>"
    file.write "<div id='looked-in'>"
    file.write "<div id='looked-css'>"
    file.write "<div id='css-heading'>Css</div>"
    self.css.each do |css, path|
      file.write "<li><a id='css-file' href=#{path}/#{css}>#{css}<a></li>"
    end
    file.write "</div>"
    file.write "<div id='looked-html'>"
    file.write "<div id='html-heading'>Html</div>"
    self.html.each do |html, path|
      file.write "<li><a id='html-file' href=#{path}>#{html}<a></li>"

    end
    file.write "</div>"
    file.write "</div>"
    file.write "<div id='found-wrapper'>"
    file.write "<div id='found-title-wrapper'>"
    file.write "<li id='found-css'>Good</li>"
    file.write "<li id='good-percent'> #{self.good_percent}</li>"
    file.write "</div>"

    self.found.each do |style, desc|
      file.write "<li id='style'>#{style} {#{desc}}</li>"
    end
    file.write "</div>"

    file.write "<div id='empty-wrapper'>"
    file.write "<div id='empty-title-wrapper'>" 
    file.write "<h4 id='empty-css'>Bad</h4>"
    file.write "<li id='bad-percent'> #{self.bad_percent}</li>"
    file.write "</div>"
    self.empty.each do |style, desc|
      file.write "<li id='empty_style'>#{style} {#{desc}}</li>"
    end
    file.write "</div>"
    file.write "</div>"
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


