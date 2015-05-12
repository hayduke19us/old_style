class LoadDir

  HTML_PATH     = Dir.pwd + '/app/views'
  CSS_PATH      = Dir.pwd + '/app/assets/stylesheets'
  CSS_MAIN_PATH = Dir.pwd + '/app/assets/stylesheets/base'

  attr_accessor :directories, :files

  def initialize(*args)
    @directories = args.flatten
    @files = {}
    dir_iteration
  end

  def dir_iteration
    @directories.each do |dir|
      html_files(dir)
      layout_files(dir)
      css_files(dir)
    end
  end

  def html_files dir
    Dir.foreach(HTML_PATH + "/" + dir) do |file|
      self.files[file] = HTML_PATH + "/" + dir + "/" + file unless /^\./.match(file)
    end
  end

  def layout_files dir
    Dir.foreach(HTML_PATH + "/layouts") do |file|
      if /(#{dir}\.html|application\.html)/.match(file)
        self.files[file] = HTML_PATH + "/layouts/" + file unless /^\./.match(file)
      end
    end
  end 

  def css_files dir
    #Dir.foreach methods arg is only the base dir
    Dir.foreach(CSS_PATH) do |file|
      self.files[file] = CSS_PATH if /(#{dir}|application)/.match(file) 
    end
    Dir.foreach(CSS_MAIN_PATH) do |file|
      self.files[file] = CSS_MAIN_PATH if /(#{dir}|application)/.match(file) 
    end
  end
end
