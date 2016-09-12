class Document < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :created_by
  belongs_to :updated_by
  belongs_to :deleted_by
  belongs_to :folder
  belongs_to :template, :class_name => "Document", :foreign_key => "template_id"
  has_many :sections

  scope :templates, -> { where(is_template: true) }
  scope :not_templates, -> { where(is_template: false) }

  scope :in_progress, -> { where(status_id: 1) }
  scope :published, -> { where(status_id: 2) }
  scope :archived, -> { where(status_id: 3) }

  def has_sections
    sections.count > 0
  end
end
