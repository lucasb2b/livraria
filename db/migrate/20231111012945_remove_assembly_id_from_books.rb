class RemoveAssemblyIdFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :assembly_id, :integer
  end
end
