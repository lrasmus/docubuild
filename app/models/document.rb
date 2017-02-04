class Document < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id"
  belongs_to :deleted_by, :class_name => "User", :foreign_key => "deleted_by_id"
  belongs_to :folder
  belongs_to :template, :class_name => "Document", :foreign_key => "template_id"
  belongs_to :clone_source, :class_name => "Document", :foreign_key => "clone_source_id"
  has_many :sections
  has_many :document_files
  has_many :contexts, as: :item

  scope :templates, -> { where(is_template: true) }
  scope :not_templates, -> { where(is_template: false) }

  scope :in_progress, -> { where(status_id: Status::InProgress) }
  scope :published, -> { where(status_id: Status::Published) }
  scope :archived, -> { where(status_id: Status::Archived) }

  scope :clonable_by_user, ->(user) { where("created_by_id = ? OR visibility_id = ?", user.id, Visibility::Public) }
  scope :editable_by_user, ->(user) { where(created_by_id: user.id) }

  def has_sections
    sections.count > 0
  end

  def logo_file
    logos = document_files.logos
    (logos.blank?) ? DocumentFile.new() : logos.first
  end

  # This is not meant to be a true diff function, it only alerts us if there is something in the template we may
  # want to incorporate into our document.  This includes:
  #  - New sections
  #  - Updated section content
  def changes_from_template
    return nil if template.nil?
    # Get section IDs from the templates
    template_sections = template.sections
    document_section_ids = sections.with_deleted.map{|s| s.template_id}  # Include our deleted sections, they were included in the templating process even if they are gone now
    new_sections = template_sections.reject {|s| document_section_ids.include? s.id }

    updated_sections = []
    template.sections.each do |ts|
      template_version_id = ts.versions.blank? ? nil : ts.versions.last.id
      updated_sections << self.sections.with_deleted.select do |ds|
        !(ts.versions.blank?) and !(ds.template_version.nil?) and (ds.template_id == ts.id) and (ds.template_version < template_version_id)
      end
    end

    {new_sections: new_sections, updated_sections: updated_sections.flatten}
  end
end
