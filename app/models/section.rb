class Section < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :document
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id", optional: true
  belongs_to :deleted_by, :class_name => "User", :foreign_key => "deleted_by_id", optional: true
  belongs_to :template, :class_name => "Section", :foreign_key => "template_id", optional: true
  belongs_to :clone_source, :class_name => "Section", :foreign_key => "clone_source_id", optional: true
  has_many :contexts, as: :item

  attr_accessor :relevance_score

  default_scope { order('sections.order') }

  def sync_to_template
    self.title = template.title
    self.description = template.description
    self.content = template.content
  end

  def sync_to_clone
    self.title = clone_source.title
    self.description = clone_source.description
    self.content = clone_source.content
  end

  def suppress_collapse?
    self.display_format != nil && self.display_format["suppress_collapse"] == "1"
  end

  def default_collapsed?
    self.display_format != nil && self.display_format["collapse_default"] == "1"
  end
end
