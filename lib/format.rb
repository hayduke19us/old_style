class Format
  PATH = File.expand_path('../../', __FILE__)
  attr_reader :found, :empty
  attr_accessor :file

  def initialize(args)
    @found = args[:found]
    @empty = args[:empty]
    @file = new_or_open_index
  end

  def new_or_open_index
    unless File.directory?(PATH + "/old_style")
      Dir.mkdir(PATH + "/old_style")
    else
      File.open(PATH + "/old_style/index.html", 'w+')
    end
  end

  def write_index
    file = self.file
    file.syswrite "<div id='content' style='padding:5%;line-height:1.4;'>"
    file.syswrite "<h2 style='border-bottom: 1px solid #efefef;'>Fake</h2>"
    file.syswrite "<h4 style='border-bottom: 1px solid #efefef;'>Good</h4>"

    self.found.each do |style, desc|
      file.syswrite "<li style='color:green;'>#{style} {#{desc}}</li>"
    end

    file.syswrite "<h4 style='border-bottom: 1px solid #efefef;'>Bad</h4>"
    self.empty.each do |style, desc|
      file.syswrite "<li style='color:red;'>#{style} {#{desc}}</li>"
    end
    file.syswrite "</div>"
  end
end


