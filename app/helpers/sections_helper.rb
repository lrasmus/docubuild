module SectionsHelper
  def format_order_and_title section
    'Section ' + section.order.to_s.rjust(2, '0') + ': ' + section.title
  end

  def summarize_section_change_from_template section
    template = section.template
    # PaperTrail versions store the state of the object BEFORE it's changed.  This means that when we are
    # navigating a history of versions, we need to find the version we started with and then reify the NEXT
    # one in order to get the correct state.
    applied_template = template.versions.find(section.template_version).next.reify
    changes = []
    return changes if template.nil? or applied_template.nil?
    changes << "The section content has been updated" if applied_template.content != template.content
    changes << "The section description has been updated" if applied_template.description != template.description
    changes << "The section name has been updated to '#{template.title}'" if applied_template.title != template.title
    changes
  end
end
