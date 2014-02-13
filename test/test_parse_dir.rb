require 'helper'
require 'benchmark'

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
    assert_equal 4, @parse.html.count
  end

  def test_parse_css_returns_hash_of_all_selectors_no_comments_no_SASS
    assert_equal 8, @parse.parse_css.keys.count
  end

  def test_parse_css_keys_content
    a = [".row", "#salinger", "#find", "div.well", 
         ".franny", "#franny", ".zooey", "#test-id"]
    assert_equal a, @parse.parse_css.keys
  end

  def test_found_css_finds_the_relevent_css
    assert_equal 5, @parse.found.keys.count
  end

  def test_empty_css_returns_a_hash_of_false_selectors
    assert_equal "#find", @parse.empty.keys.first
  end

  def test_if_Format#write_index_returns_true
    assert_equal true, @parse.write_index
  end

  def test_good_percent
    assert_equal "62.5%", @parse.good_percent
  end

  def test_success_message_if_Format#write_index_is_true
    assert @parse.success?
  end

#Preformance
=begin
  def test_performance_of_found
    n = 10000
    Benchmark.bmbm do |x|
      x.report("found:") {n.times do @parse.found end}
    end
  end
=end

end
