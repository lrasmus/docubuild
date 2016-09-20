class DocumentFileType < ActiveRecord::Base
  Logo = 'Logo'
  Style = 'Style'

  def self.get_type_by_category category, file_name
    types = DocumentFileType.where(:category => category)
    types.each do |type|
      return type if file_name.ends_with? type.extension
    end
    nil
  end
end
