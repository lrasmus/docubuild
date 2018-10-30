class Document < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :status
  belongs_to :visibility
  belongs_to :created_by, :class_name => "User", :foreign_key => "created_by_id"
  belongs_to :updated_by, :class_name => "User", :foreign_key => "updated_by_id", optional: true
  belongs_to :deleted_by, :class_name => "User", :foreign_key => "deleted_by_id", optional: true
  belongs_to :folder, optional: true
  belongs_to :template, :class_name => "Document", :foreign_key => "template_id"
  belongs_to :clone_source, :class_name => "Document", :foreign_key => "clone_source_id", optional: true
  has_many :sections
  has_many :document_files
  has_many :contexts, as: :item

  scope :templates, -> { where(is_template: true) }
  scope :not_templates, -> { where(is_template: false) }

  scope :in_progress, -> { where(status_id: Status::InProgress) }
  scope :published, -> { where(status_id: Status::Published) }
  scope :archived, -> { where(status_id: Status::Archived) }
  scope :publicly_available, -> { where("status_id = ? AND visibility_id = ?", Status::Published, Visibility::Public) }

  scope :clonable_by_user, ->(user) { where("created_by_id = ? OR visibility_id = ?", user.id, Visibility::Public) }
  scope :editable_by_user, ->(user) { where(created_by_id: user.id) }

  def has_sections
    sections.count > 0
  end

  def logo_file
    logos = document_files.logos
    (logos.blank?) ? DocumentFile.new() : logos.first
  end

  # This is not meant to be a true diff function, it only alerts us if there is something in the clone document we may
  # want to incorporate into our document.  This includes:
  #  - New sections
  #  - Updated section content
  def changes_from_clone
    changes_from_document(clone_source, true)
  end

  # This is not meant to be a true diff function, it only alerts us if there is something in the template we may
  # want to incorporate into our document.  This includes:
  #  - New sections
  #  - Updated section content
  def changes_from_template
    changes_from_document(template, false)
  end

  def is_publicly_available?
    status_id == Status::Published && visibility_id == Visibility::Public
  end

  def last_updated_content
    updates = []
    updates << [updated_at, created_at].max
    updates << sections.map { |s| [s.created_at, s.updated_at].max  }.max unless sections.empty?
    updates.max
  end

  private
    def changes_from_document(other_document, is_clone)
      return nil if other_document.nil?

      other_document_sections = other_document.sections
      document_section_ids = sections.with_deleted.map{|s| (is_clone ? s.clone_source_id : s.template_id)}  # Include our deleted sections, they were included in the templating process even if they are gone now
      new_sections = other_document_sections.reject {|s| document_section_ids.include? s.id }

      updated_sections = []
      other_document.sections.each do |os|
        other_document_version_id = (os.versions.blank? or os.versions.count < 2) ? nil : os.versions.last.id
        updated_sections << self.sections.with_deleted.select do |ds|
          if is_clone
            !(other_document_version_id.blank?) and !(ds.clone_source_version.nil?) and (ds.clone_source_id == os.id) and (ds.clone_source_version < other_document_version_id)
          else
            !(other_document_version_id.blank?) and !(ds.template_version.nil?) and (ds.template_id == os.id) and (ds.template_version < other_document_version_id)
          end
        end
      end

      {new_sections: new_sections, updated_sections: updated_sections.flatten}
    end
end
