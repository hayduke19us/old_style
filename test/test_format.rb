require 'helper'
module Format
  class KlassTest < Minitest::Test
    include Format

    def test_if_old_style_index_html_exist_new_or_open_index_returns_IO_stream
      new_or_open_index
      assert_equal File, new_or_open_index.class
    end

    def test_create_css_file
      create_css_file?
      assert File.exist?(Format::PATH + "/old_style/index.css")
    end

    def test_if_css_file_exist_#create_css_file_returns_nil
      create_css_file?
      assert_equal nil, create_css_file?
    end

    def test_css_path
     assert_equal Format::PATH + "/old_style/index.css", css_path
    end
  
  end
end
