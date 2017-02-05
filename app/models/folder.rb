class Folder < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :status
  belongs_to :visibility
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :deleted_by, :class_name => "User", :foreign_key => "deleted_by_id"
end
