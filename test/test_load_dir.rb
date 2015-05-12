require 'helper'

class LoadDirTest < MiniTest::Test
  def setup
    @load_dir = LoadDir.new("fake") 
    @html_path = Dir.home + '/my_gems/old_style/app/views'
    @css_path = Dir.home + '/my_gems/old_style/app/assets/stylesheets'
  end

  def test_HTML_PATH_should_be_for_views
    assert_equal @html_path, LoadDir::HTML_PATH 
  end

  def test_CSS_PATH_should_be_for_assets_stylesheets
    assert_equal @css_path, LoadDir::CSS_PATH 
  end

  def test_LoadDir_args_is_an_array_of_dir
    assert_equal Array, @load_dir.directories.class
  end

  def test_directories_count_is_proper
    assert_equal 1, @load_dir.directories.count
  end

  def test_html_files_attribute_is_populated_after_initialization
    #4 html files including layouts
    #3 css files
    assert_equal 7, @load_dir.files.keys.count
  end
end
