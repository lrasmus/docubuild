class SectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :content, :order, :contexts, :relevance_score

  belongs_to :document
  has_many :contexts, serializer: ContextSerializer
end