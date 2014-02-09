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

  def test_selector_sub_should_return_array_with_id_for_#
    selectors = %w[#pl_name #gr_delete #user_title ]
    new = %w[idpl_name idgr_delete iduser_title]

    assert_equal new, selector_sub(selectors)
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

end
