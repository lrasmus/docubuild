class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :institution, :status, :style, :sections, :contexts

  has_many :sections, serializer: SectionSerializer
  has_many :contexts
  has_one :status
end 