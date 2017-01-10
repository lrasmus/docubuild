class Section < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :document
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :deleted_by, :class_name => "User", :foreign_key => "deleted_by_id"
  belongs_to :template, :class_name => "Section", :foreign_key => "template_id"
  has_many :contexts, as: :item


  default_scope { order('sections.order') }
end
