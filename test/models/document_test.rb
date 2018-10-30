require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # This section tests change detection from a template

  test "changes from template with no template" do
    doc = documents(:no_template)
    assert_nil doc.changes_from_template
  end

  test "no changes from the template" do
    doc = documents(:from_template)

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "deleted document section does not count as change from the template" do
    doc = documents(:from_template)
    doc.sections.first.destroy

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "new document section does not count as change from the template" do
    doc = documents(:from_template)
    Section.create!(:title => "New section", 
      :description => "My new section",
      :content => "", :status => doc.status, :visibility => doc.visibility, :order => 1, :document => doc, :created_by => doc.created_by)

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "new template section counts as change from the template" do
    doc = documents(:from_template)
    template = documents(:my_template)
    new_section = Section.create!(:title => "New template section", 
      :description => "My new section",
      :content => "", :status => template.status, :visibility => template.visibility, :order => 1, :document => template, :created_by => doc.created_by)

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
    updated_section.save!

    changes = doc.changes_from_template

    assert_not_nil changes
    assert_equal 1, changes[:updated_sections].length
    assert_equal sections(:from_template_two).id, changes[:updated_sections][0].id
  end

  # This section tests change detection from a cloned document

  test "changes from clone with no clone" do
    doc = documents(:no_template)
    assert_nil doc.changes_from_clone
  end

  test "no changes from the clone" do
    doc = documents(:from_clone)

    changes = doc.changes_from_clone

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "deleted document section does not count as change from the clone" do
    doc = documents(:from_clone)
    doc.sections.first.destroy

    changes = doc.changes_from_clone

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "new document section does not count as change from the clone" do
    doc = documents(:from_clone)
    Section.create!(:title => "New section", 
      :description => "My new section",
      :content => "", :status => doc.status, :visibility => doc.visibility, :order => 1, :document => doc, :created_by => doc.created_by)

    changes = doc.changes_from_clone

    assert_not_nil changes
    assert_equal 0, changes[:new_sections].length
    assert_equal 0, changes[:updated_sections].length
  end

  test "new clone section counts as change from the clone" do
    doc = documents(:from_clone)
    doc_clone = documents(:in_progress)
    new_section = Section.create!(:title => "New clone section", 
      :description => "My new section",
      :content => "", :status => doc_clone.status, :visibility => doc_clone.visibility, :order => 1, :document => doc_clone, :created_by => doc_clone.created_by)

    changes = doc.changes_from_clone

    assert_not_nil changes
    assert_equal 1, changes[:new_sections].length
    assert_equal new_section.id, changes[:new_sections][0].id
  end

  test "updated clone section recognized" do
    doc = documents(:from_clone)
    doc_clone = documents(:in_progress)
    updated_section = doc_clone.sections.last
    updated_section.description = "Updated description"
    updated_section.save!

    changes = doc.changes_from_clone

    assert_not_nil changes
    assert_equal 1, changes[:updated_sections].length
    assert_equal sections(:from_clone_two).id, changes[:updated_sections][0].id
  end

  test "detects publicly available documents" do
    doc = documents(:published_public)
    assert doc.is_publicly_available?

    doc = documents(:published_private)
    assert_equal false, doc.is_publicly_available?
    doc = documents(:in_progress)
    assert_equal false, doc.is_publicly_available?
  end

  test "last updated timestamp from content" do
    # When newly created, the last updated timestamp will equal the document's update timestamp.
    # Note that we're tweaking the update & creation because otherwise we run the risk of all
    # timestamps being in the same second as the test progresses.
    doc = documents(:no_sections)
    doc.created_at = doc.created_at - 5.days
    doc.updated_at = doc.created_at
    doc.save!
    assert_equal doc.updated_at, doc.last_updated_content

    # When we add a new section, the last updated timestamp for the document will change to that
    # of the section.  We're doing a little date manipulation here as well.
    new_section = Section.create!(:title => "New section", 
      :description => "My new section",
      :content => "", :status => doc.status, :visibility => doc.visibility, :order => 1, :document => doc, :created_by => doc.created_by)
    new_section.created_at = new_section.created_at - 3.days
    new_section.updated_at = new_section.created_at
    new_section.save!
    original_updated_at = new_section.updated_at
    assert_equal new_section.updated_at, doc.last_updated_content

    # When we update a section, the last updated timestamp for the document will change to that
    # of the section's update timestamp.  We need to make sure as well that the updated timestamp
    # has changed from the original save
    new_section.description = "Here's an updated section"
    new_section.updated_at = new_section.updated_at + 1.days
    new_section.save!
    doc.reload
    recent_updated_at = new_section.updated_at
    assert_not_equal recent_updated_at, original_updated_at
    assert_equal new_section.updated_at, doc.last_updated_content

    # Finally, if we update the document itself, check that the timestamp of the last update
    # reflects that.
    doc.title = "An Updated Document Title"
    doc.save!
    assert_not_equal recent_updated_at, doc.updated_at
    assert_equal doc.updated_at, doc.last_updated_content
  end
end
