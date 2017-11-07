class Context < ApplicationRecord
  belongs_to :item, polymorphic: true
end