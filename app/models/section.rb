class Section < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :article
end
