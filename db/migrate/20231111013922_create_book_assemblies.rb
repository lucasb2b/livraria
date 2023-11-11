class CreateBookAssemblies < ActiveRecord::Migration[7.0]
  def change
    create_table :book_assemblies do |t|
      t.belongs_to :book, index: true
      t.belongs_to :assembly, index: true
      t.timestamps
    end
  end
end
