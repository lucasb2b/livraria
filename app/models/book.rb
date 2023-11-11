class Book < ApplicationRecord
  belongs_to :author
  has_many :book_assemblies
  has_many :assemblies, through: :book_assemblies
end
