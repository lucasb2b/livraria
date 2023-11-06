class AddDescriptionToParts < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :description, :string
  end
end
