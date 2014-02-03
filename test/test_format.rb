require 'helper'

class FormatTest < MiniTest::Test
  
  def setup
    @format = Format.new(found: {"#salinger" => "colr: blue"}, 
                         empty: {".zooey" => "width: 20px"})
  end

  def test_format_class_valid
    assert @format
  end

end
