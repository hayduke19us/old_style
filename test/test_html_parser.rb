require 'helper'

class KlassTest < Minitest::Test
  include HtmlParser

  def setup
    @file = File.expand_path("../../app", __FILE__) + "/views/fake/fake.html.erb" 
  end

  def test_read_html_should_put_document_into_an_array
    refute read_html(@file).empty?
  end

  def test_remove_extras_should_remove_all_punctuation_and_whitespace
    refute remove_extras(@file).join.match(/(:|<|>|=|'|')/)
  end

  def test_remove_extras_should_also_remove_all_whitespace
    refute remove_extras(@file).join.match(' ')
  end

  def test_extras_should_return_an_Array
    assert_equal Array, remove_extras(@file).class
  end

  def test_selector_can_match_a_tag_in_the_html_erb_doc
    #and id of id: test-id id in the file
    array = []
    remove_extras(@file).each do |line|
      array << line if line.match(/(idtest-id|idpeace)/)
      refute line.match('idtear-id'), "incorrect match"
      refute line.match('idtesx-id'), "incorrect match"
      refute line.match('idtest-im'), "incorrect match"
    end

    refute array.empty?, "correct match"
    assert_equal 2, array.count
  end

  def test_#id_exists_then_return_true
    assert_equal true, id_exists?("#test-id", @file)
  end

  def test_#id_doesn't_exist_returns_false
    assert_equal false, id_exists?("#test-ix", @file)
  end

  def test_#class_exists_then_return_true
    assert_equal true, class_exists?(".row", @file)  
  end

  def test_#class_doesn't_doesn't_exist_then_return_false
    refute_equal true, class_exists?(".container", @file)
  end

  def test_using_#class_as_a_control_structure
    if class_exists?(".container", @file) == true
      success = true
    end
    refute_equal true,  success
  end

  def test_id_exists
   assert_equal true, id_exists?("#test-id", @file)
  end

end
