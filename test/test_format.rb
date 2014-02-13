require 'helper'
module Format
  class KlassTest < Minitest::Test

    include Format

    def test_css_path
     assert_equal Format::PATH + "/old_style/index.css", Format::CSS_PATH
    end

    def test_new_or_open_index_returns_file
     assert_equal File, new_or_open_index.class
    end

    def test_base_css_count_should_return_true
      assert_equal true, base_css_count
    end

    def test_create_css_file_should_return_false
      assert_equal false, create_css_file?
    end

    def test_base_css_file_exist
      assert File.exists?("base.css")
    end
  end

end
