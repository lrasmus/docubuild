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
end
