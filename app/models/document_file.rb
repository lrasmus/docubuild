class DocumentFile < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :document
  belongs_to :document_file_type

  scope :logos, -> { joins(:document_file_type).where("document_file_types.category = 'Logo'") }
end