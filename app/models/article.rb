class Article < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :created_by
  belongs_to :updated_by
  belongs_to :deleted_by
  belongs_to :folder
  belongs_to :template
end
