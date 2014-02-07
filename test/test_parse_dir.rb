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
    assert_equal 2, @parse.css.count
  end

  def test_ParseDir#segregate_puts_html_files_in_an_array
    assert_equal 2, @parse.html.count
  end

  def test_parse_css_returns_hash_of_all_selectors_no_comments_no_SASS
    assert_equal 5, @parse.parse_css.keys.count
  end

  def test_parse_hmtl_returns_collection_of_Nokogiri_Document_objects
    assert_equal Nokogiri::HTML::Document, @parse.parse_html.first.class
  end

  def test_parse_html_and_html_attribute_has_same_number_of_objects
    assert_equal @parse.html.count, @parse.parse_html.count
  end

  def test_found_css_finds_the_relevent_css
    assert_equal 2, @parse.found.keys.count
  end

  def test_empty_css_returns_a_hash_of_false_selectors
    assert_equal "#find", @parse.empty.keys.first
  end

  def test_mixin
    assert @parse.write_index
  end

  def test_good_percent
    assert_equal "40.0%", @parse.good_percent
  end

end
