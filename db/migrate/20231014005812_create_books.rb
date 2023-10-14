class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :author_id
      t.datetime :published_at
      t.string :isbn
      t.string :title

      t.timestamps
    end
  end
end
