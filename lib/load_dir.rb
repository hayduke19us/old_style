
class LoadDir
  HTML_PATH = (Dir.pwd + '/app/views')
  CSS_PATH = (Dir.pwd + '/app/assets/stylesheets')

  attr_accessor :directories, :files

  def initialize(*args)
    @directories = args.flatten
    @files = {}
    dir_iteration
    css_directories
  end

  def dir_iteration
    @directories.each {|dir| html_files(dir)}
  end

  def html_files  dir
    Dir.foreach(HTML_PATH + "/" + dir) do |file|
      @files[file] = HTML_PATH + "/" + dir + "/" + file unless /^\./.match(file)
    end
  end

  def html_directories
    @directories.each do |dir|
      Dir.foreach(HTML_PATH + "/" + dir) do |file|
        @files[file] = HTML_PATH + "/" + dir + "/" + file unless /^\./.match(file)
      end
    end
  end

  def css_directories
    # This method's return hashes' PATH value is different from html_directories.
    # It only includes the directory because the css parser requires
    # an argument of file, base_directory, media_type
    # The path can't include the file
    @directories.each do |dir|
      Dir.foreach(CSS_PATH) do |file|
        @files[file] = CSS_PATH if /#{dir}/.match(file)
      end
    end
  end

end


