
class LoadDir
  HTML_PATH = File.expand_path(Dir.pwd + '/app/views')
  CSS_PATH = File.expand_path(Dir.pwd + '/app/assets/stylesheets')


  attr_accessor :directories, :files

  def initialize(*args)
    @directories = args.flatten
    @files = {}
    html_directories
    css_directories
  end

  def html_directories
    @directories.each do |dir|
      Dir.foreach(HTML_PATH + "/#{dir}") do |file|
        @files[file] = HTML_PATH + "/#{dir}/#{file}" unless /^\./.match(file)
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


