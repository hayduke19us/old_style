
module Format
  PATH = Dir.pwd
  BASE = File.expand_path('../../base.css', __FILE__)

  def new_or_open_index
    unless File.directory?(PATH + "/old_style")
      Dir.mkdir(PATH + "/old_style")
    end
    File.open(PATH + "/old_style/index.html", 'w+')
  end

  def create_css_file?
    unless File.exist?(css_path) &&
      File.readlines(BASE).count == File.readlines(css_path)
      file = File.new(css_path, 'w+')
      write_css
    end
  end

  def css_path
    PATH + "/old_style/index.css"
  end

  def write_css
    file = File.open(css_path, 'w+')
    File.readlines(BASE).each do |line|
     file.write line
    end
    file.close
  end

  def write_index
    create_css_file?
    file = new_or_open_index
    file.write "<div id='header'>"
    file.write "<li id='main-heading'>
                #{self.directories.count} Controller evaluated </li>"
    file.write "</div>"
    file.write "<body>"
    file.write "<head>"
    file.write "<link rel='stylesheet' type='text/css' href=#{css_path}>"
    file.write "</head>"
    file.write "<div id='content'>"
    file.write "<div id='directories'>"
    file.write "<h2 id='dir-heading'>#{self.directories.sort_by{|x| x.downcase}}</h2>"
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
    file.write "<div id='found-style-wrapper'>"
    self.found.sort_by{|x| x.first.downcase}.each do |style, desc|
      file.write "<li id='style'>#{style} {#{desc}}</li>"
    end
    file.write "</div>"
    file.write "</div>"

    file.write "<div id='empty-wrapper'>"
    file.write "<div id='empty-title-wrapper'>"
    file.write "<h4 id='empty-css'>Bad</h4>"
    file.write "<li id='bad-percent'> #{self.bad_percent}</li>"
    file.write "</div>"
    file.write "<div id='empty-style-wrapper'>"
    self.empty.sort_by{|x| x.first.downcase}.each do |style, desc|
      file.write "<li id='empty_style'>#{style} {#{desc}}</li>"
    end
    file.write "</div>"
    file.write "</div>"
    file.write "</div>"
    file.write "</body>"
    file.write "<div id='footer'>"
    file.write "<div id='footer-info'>"
    file.write "<li id='footer-caption'>If you find any issues please let me know
                    at </li>"
    file.write "<a id ='issues-link' href = 'https://github.com/hayduke19us/old_style/issues?state=open'>old_style's issues page on github<a>"
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


