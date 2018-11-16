require 'test_helper'
require 'documents_helper'

class DocumentsHelperTest < ActionView::TestCase
  test "text section display false for nil document" do
    assert !document_text_section_display(nil)
  end

  test "text section display false for nil display format" do
    doc = documents(:no_template)
    doc.display_format = nil
    assert !document_text_section_display(doc)
  end

  test "text section display true for display format 'text'" do
    doc = documents(:no_template)
    doc.display_format = {"section_display" => "text"}
    assert document_text_section_display(doc)
  end

  test "collapse section display false for nil document" do
    assert !document_collapsable_section_display(nil)
  end

  test "collapse section display false for nil display format" do
    doc = documents(:no_template)
    doc.display_format = nil
    assert !document_collapsable_section_display(doc)
  end

  test "collapse section display true for display format 'accordion'" do
    doc = documents(:no_template)
    doc.display_format = {"section_display" => "accordion"}
    assert document_collapsable_section_display(doc)
  end
end