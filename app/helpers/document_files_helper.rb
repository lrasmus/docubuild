module DocumentFilesHelper
  def document_file_label document_file
    return "No Files Chosen" if document_file.nil? or document_file.new_record?
    document_file.name
  end
end
