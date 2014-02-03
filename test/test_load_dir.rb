require 'helper'

class LoadDirTest < MiniTest::Test
  def setup
    @load_dir = LoadDir.new("fake") 
    @load_dir.segregate
    @load_dir.parse_html
  end

  def test_HTML_PATH_should_be_for_views
    assert_equal '/Users/hayduke19us/my_gems/old_style/app/views', LoadDir::HTML_PATH 
  end

  def teset_CSS_PATH_should_be_for_assets_stylesheets
    assert_equal '/Users/hayduke19us/my_gems/old_style/app/assets/stylesheets', LoadDir::CSS_PATH 
  end

  def test_LoadDir_is_valid
    assert @load_dir
  end

  def test_LoadDir_takes_an_array_of_dir
    assert_equal 1, @load_dir.directories.count
  end

  def test_true_if_css?
    file = "playlist.html"
    file_2 = "playlist.css"
    refute @load_dir.css?(file)
    assert @load_dir.css?(file_2)
  end

  def test_true_if_html?
    file = "playlist.html"
    file_2 = "playlist.css"
    refute @load_dir.html?(file_2) 
    assert @load_dir.html?(file)
  end

  def test_html_directories_and_css_directories_extracts_files
    assert_equal 4, @load_dir.files.count
  end

  def test_segregate_puts_css_files_in_an_array
    assert_equal 2, @load_dir.css.count
  end

  def test_segregate_puts_html_files_in_an_array
    assert_equal 2, @load_dir.html.count
  end

  def test_parse_css_returns_hash_of_all_selectors_no_comments
    assert_equal %w[#salinger .franny #franny .zooey], @load_dir.parse_css.keys
  end

  def test_parse_hmtl_returns_collection_of_Nokogiri_Document_objects
    assert_equal Nokogiri::HTML::Document, @load_dir.parse_html.first.class
  end

  def test_parse_html_and_html_attribute_has_same_number_of_objects
    assert_equal @load_dir.html.count, @load_dir.parse_html.count 
  end

  def test_empty_css_returns_a_hash_of_false_selectors
    assert_equal ".franny", @load_dir.empty_css.keys.first
  end

end
