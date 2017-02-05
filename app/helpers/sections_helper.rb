module SectionsHelper
  def format_order_and_title section
    'Section ' + section.order.to_s.rjust(2, '0') + ': ' + section.title
  end

  def summarize_section_change_from_other_document section, is_clone
    other_document = (is_clone ? section.clone_source : section.template)
    other_document_version = (is_clone ? section.clone_source_version : section.template_version)
    # PaperTrail versions store the state of the object BEFORE it's changed.  This means that when we are
    # navigating a history of versions, we need to find the version we started with and then reify the NEXT
    # one in order to get the correct state.
    applied_other_document = other_document.versions.find(other_document_version).next.reify
    changes = []
    return changes if other_document.nil? or applied_other_document.nil?
    changes << "The section content has been updated" if applied_other_document.content != other_document.content
    changes << "The section description has been updated" if applied_other_document.description != other_document.description
    changes << "The section name has been updated to '#{other_document.title}'" if applied_other_document.title != other_document.title
    changes
  end

  def section_sync_path section, is_clone
    if is_clone
      clone_sync_section_path(section)
    else
      template_sync_section_path(section)
    end
  end
end
