require 'rubygems'
require 'zip'
require 'tempfile'

module DocUBuild
  class HtmlExporter
    # http://thinkingeek.com/2013/11/15/create-temporary-zip-file-send-response-rails/
    def export_document document, content
      logo_file_name, logo_file = create_logo_file(document)
      html_file = create_html_file(content)
      filename = document.id.to_s + '.zip'
      temp_file = Tempfile.new(filename)

      begin
        #This is the 'gotcha' - initialize the temp file as a zip file
        Zip::OutputStream.open(temp_file.path) { |zos| }
        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
          zip.add('document_files/' + logo_file_name, logo_file.path) unless logo_file_name.blank?
          zip.add('index.html', html_file.path) unless html_file.blank?
        end
      ensure
        temp_file.close
      end
      temp_file
    end

    def create_html_file content
      tmp_file = Tempfile.new("index.html")
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
        return logo_file.id.to_s, tmp_file
      end
      return nil, nil
    end
  end
end