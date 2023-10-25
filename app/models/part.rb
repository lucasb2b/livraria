class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
  accepts_nested_attributes_for :assemblies
end
