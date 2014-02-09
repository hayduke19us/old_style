

module HtmlParser

  def read_html file
    File.readlines(file)
  end

  def remove_extras file
    #the whitespace first
    read_html(file).map {|line| line.delete(" <%>:=''")}
  end

  def selector_sub array
    array.map {|line| line.gsub("#", "id")}
  end

end
