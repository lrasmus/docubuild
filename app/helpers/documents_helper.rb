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
end
