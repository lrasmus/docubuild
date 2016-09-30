require 'rubygems'
require 'zip'
require 'tempfile'

module DocUBuild
  class HtmlExporter
    def document_export_name document
      document.title.downcase.squish.tr(" ", "_")
    end

    def logo_file_export_name logo_file
      "#{logo_file.id}_#{logo_file.name}" if logo_file
    end

    # http://thinkingeek.com/2013/11/15/create-temporary-zip-file-send-response-rails/
    def export_document document, content, export_as
      export_as ||= 'html'
      logo_file_name, logo_file = create_logo_file(document)
      document_file_name_base = document_export_name(document)
      document_file_name = "#{document_file_name_base}.#{export_as}"
      html_file = create_html_file(content, document_file_name)
      filename = document_file_name_base + '.zip'
      temp_file = Tempfile.new(filename)

      begin
        #This is the 'gotcha' - initialize the temp file as a zip file
        Zip::OutputStream.open(temp_file.path) { |zos| }
        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
          zip.add('images/' + logo_file_name, logo_file.path) unless logo_file_name.blank?
          zip.add(document_file_name, html_file.path) unless html_file.blank?
        end
      ensure
        temp_file.close
      end
      temp_file
    end

    def create_html_file content, file_name
      tmp_file = Tempfile.new(file_name)
      File.open(tmp_file.path, 'w') do |f|
        f.write content
      end
      tmp_file
    end

    def create_logo_file document
      unless document.document_files.logos.blank?
        logo_file = document.logo_file
        tmp_file = Tempfile.new(logo_file.name)
        File.open(tmp_file.path, 'wb') do |f|
          f.write logo_file.content
        end
        return logo_file_export_name(logo_file), tmp_file
      end
      return nil, nil
    end
  end
end