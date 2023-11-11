class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
  accepts_nested_attributes_for :parts

  has_many :book_assemblies
  has_many :books, through: :book_assemblies
end
