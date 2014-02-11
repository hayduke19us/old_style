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
      assert_equal 131, File.readlines("base.css").count
    end

    # the following two test are in sequence
    # the first deletes the contents of the css file
    # the next one adds the css to file

    def test_index_css_is_empty
      #deletes file contents by File.new ('w+')
      file = File.new(css_path, 'w+')
      assert_equal 0, File.readlines(file).count
      file.close
    end

    def test_file_index_css_has_lines
      #write the css from base.css file in gem
      write_css
      assert_equal 131, File.readlines(css_path).count
    end

  end

end
