class Folder < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :status
  belongs_to :visibility
end
