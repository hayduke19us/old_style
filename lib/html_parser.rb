
module HtmlParser

  def read_html file
    File.readlines(file)
  end

  def remove_extras file
    #the whitespace first
    read_html(file).map {|line| line.delete(" <%>:=''\"\"")}
  end

  def id_exists? tag, file
    tag = tag.gsub('#', 'id')
    remove_extras(file).each do |line|
      if line.match(tag)
       return  true
      end
    end
  end

  def class_exists? tag, file
    tag = tag.gsub('.', 'class') if tag.match(/^./)
    remove_extras(file).each do |line|
      if line.match(tag)
        return true
      end
    end
  end

  def parent_exists? tag, file
    tag = tag.gsub('div.', 'class') if tag.match(/div/)
    remove_extras(file).each do |line|
      if line.match(tag)
        return true
      end
    end
  end

end
