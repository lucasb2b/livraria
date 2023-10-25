class CreatePartsAssemblies < ActiveRecord::Migration[7.0]
  def change
    create_table :parts_assemblies, id: false do |t|
      t.integer :part_id
      t.integer :assembly_id

      t.timestamps
    end
  end
end
