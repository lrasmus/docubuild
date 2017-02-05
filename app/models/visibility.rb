class Visibility < ActiveRecord::Base
  # Replicate the database values here for easy referencing.  Any changes here should be reflected in the seeds
  # and by a migration if you are changing an existing value.
  Public = 1
  Private = 2
end
