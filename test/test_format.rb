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

    def test_base_css_file_exist
      assert File.exists?("base.css")
    end

    def test_base_file_can_be_read
      assert_equal 95, File.readlines("base.css").count
    end

    def test_file_index_css_has_lines
      write_css
      assert_equal 95, File.readlines(css_path).count
    end

  end

end
