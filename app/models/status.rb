class Status < ApplicationRecord
  # Replicate the database values here for easy referencing.  Any changes here should be reflected in the seeds
  # and by a migration if you are changing an existing value.
  InProgress = 1
  Published = 2
  Archived = 3
  Deleted = 4

  scope :displayable, -> { where(:id => [InProgress, Published, Archived]) }
end
