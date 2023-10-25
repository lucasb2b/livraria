class CreateAssembliesPartsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :assemblies_parts, id: false do |t|
      t.belongs_to :assembly
      t.belongs_to :part
    end

    add_index :assemblies_parts, [:assembly_id, :part_id]
  end
end
