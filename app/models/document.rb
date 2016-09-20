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
  has_many :document_files

  scope :templates, -> { where(is_template: true) }
  scope :not_templates, -> { where(is_template: false) }

  scope :in_progress, -> { where(status_id: Status::InProgress) }
  scope :published, -> { where(status_id: Status::Published) }
  scope :archived, -> { where(status_id: Status::Archived) }

  def has_sections
    sections.count > 0
  end

  def logo_file
    logos = document_files.logos
    (logos.blank?) ? DocumentFile.new() : logos.first
  end
end
