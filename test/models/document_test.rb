require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  test "changes from template with no template" do
    doc = documents(:no_template)
    assert_nil doc.changes_from_template
  end

  test "no changes from the template" do
    doc = documents(:from_template)

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
  end

  test "deleted document section does not count as change from the template" do
    doc = documents(:from_template)
    doc.sections.first.destroy

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
  end

  test "new document section does not count as change from the template" do
    doc = documents(:from_template)
    Section.create(:title => "New section", 
      :description => "My new section",
      :content => "", :status => doc.status, :visibility => doc.visibility, :order => 1, :document => doc)

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
  end

  test "new template section counts as change from the template" do
    doc = documents(:from_template)
    template = documents(:my_template)
    new_section = Section.create(:title => "New template section", 
      :description => "My new section",
      :content => "", :status => template.status, :visibility => template.visibility, :order => 1, :document => template)

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 1, changes[:new_sections].length
    assert_equal new_section.id, changes[:new_sections][0].id
  end

  test "updated template section recognized" do
    doc = documents(:from_template)
    template = documents(:my_template)
    updated_section = template.sections.last
    updated_section.description = "Updated description"
    updated_section.save

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 1, changes[:updated_sections].length
    assert_equal sections(:from_template_two).id, changes[:updated_sections][0].id
  end
end
