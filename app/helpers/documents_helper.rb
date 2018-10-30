module DocumentsHelper
  def format_last_modified document
    last_update = document.last_updated_content
    last_update.nil? ? "(Unknown)" : last_update.strftime("%d %b %Y")
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

  def safe_get_style_value document, style_name
    return nil if document.nil? or document.style.nil?
    document.style[style_name]
  end

  def document_sync_path document, commit, is_clone
    if is_clone
      clone_sync_document_path(@document, commit: commit)
    else
      template_sync_document_path(@document, commit: commit)
    end
  end

  def document_break_link_path document, is_clone
    if is_clone
      break_clone_link_document_path(@document)
    else
      break_template_link_document_path(@document)
    end
  end
end
