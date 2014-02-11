
class LoadDir
  HTML_PATH = (Dir.pwd + '/app/views')
  CSS_PATH = (Dir.pwd + '/app/assets/stylesheets')

  attr_accessor :directories, :files

  def initialize(*args)
    @directories = args.flatten
    @files = {}
    dir_iteration
  end

  def dir_iteration
    @directories.each {|dir| html_files(dir)}
    @directories.each {|dir| css_files(dir)}
  end

  def html_files dir
    Dir.foreach(HTML_PATH + "/" + dir) do |file|
      @files[file] = HTML_PATH + "/" + dir + "/" + file unless /^\./.match(file)
    end
  end

  def css_files dir
    #Dir.foreach methods arg is only the base dir
    Dir.foreach(CSS_PATH) do |file|
      @files[file] = CSS_PATH if /#{dir}/.match(file)
    end
  end

end


