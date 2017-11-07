class DocumentFile < ApplicationRecord
  acts_as_paranoid
  has_paper_trail :skip => [:content]

  belongs_to :document
  belongs_to :document_file_type

  scope :logos, -> { joins(:document_file_type).where("document_file_types.category = 'Logo'") }

  def dimensions
    return ['100%', '100%'] if properties.blank?
    [properties['width'], properties['height']]
  end
end