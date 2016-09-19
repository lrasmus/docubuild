class DocumentFile < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :document
end