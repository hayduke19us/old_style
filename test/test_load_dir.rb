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

  def test_LoadDir_files_finds_the_files_in_HTML_PATH
    dir = []
    Dir.foreach(LoadDir::HTML_PATH + "/fake" ) {|f| dir << f unless /^\./.match(f)} 
    Dir.foreach(LoadDir::CSS_PATH + "/fake" ) {|f| dir << f unless /^\./.match(f)} 
    assert_equal 4, dir.count
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

  def test_segregate_puts_css_files_in_an_array
    assert_equal 4, @load_dir.files.count
    assert_equal 2, @load_dir.css.count
  end

  def test_segregate_puts_css_files_in_an_array
    assert_equal 2, @load_dir.html.count
  end

  def test_parse_css_returns_a_collection_of_selectors
    assert_equal 3, @load_dir.parse_css.count
  end

  def test_that_comments_are_not_added_to_parse_css_array
    assert_equal 3, @load_dir.parse_css.count
  end

  def test_parse_hmtl_creates_hash_with_noko_doc_as_keys
    assert_equal Nokogiri::HTML::Document, @load_dir.html_css.keys.first.class
  end

  def test_found_css_is_an_array_of_selctors
    assert_equal 2, @load_dir.found_css.count
  end

  def test_empty_css_is_an_array_of_selctors
    assert_equal 2, @load_dir.empty_css.count
  end
end
