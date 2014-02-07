require 'helper'
module Format
  class KlassTest < Minitest::Test
    include Format

    def test_new_or_open_index
      assert_equal File, new_or_open_index.class
    end

    def test_create_css_file
      create_css_file
      assert File.exist?(Format::PATH + "/old_style/index.css")
    end

    def test_css_path
     assert_equal Format::PATH + "/old_style/index.css", css_path
    end
  end
end
