require 'helper'

class ParseDirTest < MiniTest::Test
  def setup
   @parse = ParseDir.new("fake")
  end

  def test_attributes_of_Load_Dir
    refute @parse.directories.empty?
  end

  def test_html_directories_and_css_directories
    refute @parse.files.empty?
  end

  def test_true_if_css?
    file = "playlist.css"
    assert @parse.css?(file)
   end

  def false_if_html_with_css?
    file = "playlist.html"
    refute @parse.css?(file)
  end

  def test_true_if_html?
    file = "playlist.css"
    refute @parse.html?(file)
  end

  def false_if_css_for_html?
    file = "playlist.css"
    refute @parse.html?(file)
   end

  def test_ParseDir#segregate_puts_css_files_in_an_array
    @parse.segregate
    assert_equal 2, @parse.css.count
  end
 
  def test_segregate_puts_html_files_in_an_array
    @parse.segregate
    assert_equal 2, @parse.html.count
  end

 def test_parse_css_returns_hash_of_all_selectors_no_comments_no_SASS
    @parse.segregate
    assert_equal 5, @parse.parse_css.keys.count
 end

  def test_parse_hmtl_returns_collection_of_Nokogiri_Document_objects
    @parse.segregate
    @parse.parse_html
    assert_equal Nokogiri::HTML::Document, @parse.parse_html.first.class
  end
  
  def test_parse_html_and_html_attribute_has_same_number_of_objects
    @parse.segregate
    @parse.parse_html
    assert_equal @parse.html.count, @parse.parse_html.count 
  end

  def test_empty_css_returns_a_hash_of_false_selectors
    @parse.segregate
    @parse.parse_html

    assert_equal "#find", @parse.empty_css.keys.first
  end












end
