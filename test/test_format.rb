require 'helper'

class FormatTest < MiniTest::Test
  
  def setup
    @format = Format.new(found: {"#salinger" => "color: blue",
                                 "#test" => "height: 10px;"}, 
                         empty: {".zooey" => "width: 20px",
                                 "#test" => "padding: 20px"})
  end
  
  def test_attributes_are_readable
    assert @format.found
    assert @format.empty
  end

  def test_create_index_creates_or_opens_file_stream
   assert_equal File, @format.file.class
  end
 
  def test_write_index
    @format.write_index
    refute IO.readlines(@format.file).empty?
  end
end
