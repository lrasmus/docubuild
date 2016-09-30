module DocumentsHelper
  def format_last_modified document
    document.updated_at.strftime("%d %b %Y")
  end

  def default_document_status
    Status.first.id
  end

  def default_document_visibility
    Visibility.first.id
  end

  def doc_avatar_title document
    (document.nil? || document.title.blank?) ? 'D' : document.title[0]
  end

  def font_list
    ["Arial", "Calibri", "Helvetica"]
  end

  def font_size_list
    [10, 11, 12, 14, 16, 18, 20, 22]
  end

  def set_item_context_path item
    if item.is_a?(Document)
      set_context_document_path(item)
    elsif item.is_a?(Section)
      set_context_section_path(item)
    end
  end
end
