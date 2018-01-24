class ContextSerializer < ActiveModel::Serializer
  attributes :category, :code, :code_system_oid, :code_system_name, :term
  
  belongs_to :document
  belongs_to :section
end