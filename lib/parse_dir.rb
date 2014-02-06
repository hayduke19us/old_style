
class ParseDir < LoadDir

  attr_accessor :css, :html

  def initialize(args)
    super(args)
    @css = {}
    @html = {}
    self.segregate
    self.parse_html
    self.parse_css
  end

  def css?(file)
    true if /\.css\S*\z/.match(file)
  end

  def html?(file)
    true if/\.html\S*\z/.match(file)
  end

  def segregate
    self.files.each do |file, path|
      if self.css?(file)
        self.css[file] = path
      elsif self.html?(file)
        self.html[file] = path
      end
    end
  end

  def parse_html
    #call segregate first
    self.html.inject([]) do |array, path|
      array << Nokogiri::HTML(open(path.last))
    end
  end

  def parse_css
    hash = {}
    self.css.each do |file, path|
      parser = CssParser::Parser.new
      parser.load_file!(file, path, :all)
      parser.each_selector(:all) do |selector, dec, spec|
        unless /(^\/|\$|@|\d|:hover)/.match(selector)
          hash[selector] = dec
        end
      end
    end
    hash
  end

  def found_css
    tmp = {}
    self.parse_html.each do |doc|
      self.parse_css.each {|sel, des| tmp[sel] = des unless doc.css(sel).empty?}
    end
    tmp
  end

  def empty_css
    hash = {}
    all = self.parse_css.inject([]) {|a, k| a << k}
    found = self.found_css.inject([]) {|a, k| a << k}
    empty = all - found
    empty.each {|arr| hash[arr.first] = arr.last}
    hash
  end

end
